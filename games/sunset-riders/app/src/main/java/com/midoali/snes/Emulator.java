package com.midoali.snes;

import android.content.Context;
import android.graphics.Bitmap;
import android.media.AudioAttributes;
import android.media.AudioFormat;
import android.media.AudioTrack;
import android.util.Log;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.ShortBuffer;

/**
 * Owns the emulation thread. Converts the native 2x HQ Scale2x RGB565 frame
 * buffer into 32-bit ARGB_8888 using a full 8-bit bit-replication LUT for
 * zero color banding and maximum visual clarity.
 */
final class Emulator implements Runnable {
    private static final String TAG = "SnesEmu";
    private static final int AUDIO_FRAMES_PER_READ = 1024;
    private static final int MAX_FB_W = 800;
    private static final int MAX_FB_H = 600;
    private static final int[] RGB565_TO_ARGB = new int[65536];

    static {
        for (int v = 0; v < 65536; v++) {
            int r5 = (v >>> 11) & 0x1F;
            int g6 = (v >>> 5) & 0x3F;
            int b5 = v & 0x1F;
            int r = (r5 << 3) | (r5 >>> 2);
            int g = (g6 << 2) | (g6 >>> 4);
            int b = (b5 << 3) | (b5 >>> 2);
            RGB565_TO_ARGB[v] = 0xFF000000 | (r << 16) | (g << 8) | b;
        }
    }

    private final Context context;
    private final byte[] rom;
    private final GameView view;
    private final VirtualPad pad;

    private volatile boolean running;
    private volatile boolean paused;
    private volatile int cheatMask;
    private volatile int videoFilter = SnesCore.VIDEO_FILTER_HD_CRISP;
    private final Object pauseLock = new Object();
    private Thread thread;
    private AudioTrack track;

    private Bitmap bitmap;
    private int[] argbPixels;
    private ByteBuffer frameBuffer;
    private ShortBuffer shortFrameBuffer;
    private final short[] audioBuffer = new short[AUDIO_FRAMES_PER_READ * 2];

    private int frameWidth = 512, frameHeight = 448;

    Emulator(Context context, byte[] rom, GameView view, VirtualPad pad) {
        this.context = context.getApplicationContext();
        this.rom = rom;
        this.view = view;
        this.pad = pad;
    }

    int frameWidth() { return frameWidth; }

    int frameHeight() { return frameHeight; }

    void setCheats(int mask) {
        cheatMask = mask;
        try {
            SnesCore.nativeSetCheats(mask);
        } catch (Throwable ignored) { }
    }

    int getCheats() {
        return cheatMask;
    }

    void setVideoFilter(int mode) {
        videoFilter = mode;
        view.setSmoothFilter(mode != SnesCore.VIDEO_FILTER_RAW_PIXEL);
        try {
            SnesCore.nativeSetVideoFilter(mode);
        } catch (Throwable ignored) { }
    }

    int getVideoFilter() {
        return videoFilter;
    }

    void applyCheatCode(int index, boolean enabled, String code) {
        try {
            SnesCore.nativeApplyCheatCode(index, enabled, code);
        } catch (Throwable ignored) { }
    }

    void start() {
        if (running) return;
        running = true;
        thread = new Thread(this, "snes-emulator");
        thread.setPriority(Thread.MAX_PRIORITY);
        thread.start();
    }

    void stop() {
        running = false;
        Thread t = thread;
        if (t != null) {
            try {
                t.join(1500);
            } catch (InterruptedException ignored) {
                Thread.currentThread().interrupt();
            }
        }
        releaseAudio();
    }

    void setPaused(boolean value) {
        paused = value;
        synchronized (pauseLock) {
            pauseLock.notifyAll();
        }
        AudioTrack t = track;
        if (t != null) {
            try {
                if (value) t.pause();
                else t.play();
            } catch (IllegalStateException ignored) { }
        }
    }

    @Override
    public void run() {
        try {
            SnesCore.nativeSetVideoFilter(videoFilter);
            if (!SnesCore.nativeStart(rom, context.getFilesDir().getAbsolutePath())) {
                Log.e(TAG, "core rejected the ROM");
                return;
            }
            SnesCore.nativeSetCheats(cheatMask);
            frameBuffer = ByteBuffer.allocateDirect(MAX_FB_W * MAX_FB_H * 2).order(ByteOrder.nativeOrder());
            shortFrameBuffer = frameBuffer.asShortBuffer();
            ensureBitmap(SnesCore.nativeFrameWidth(), SnesCore.nativeFrameHeight());
            createAudio();

            while (running) {
                if (paused) {
                    synchronized (pauseLock) {
                        try {
                            pauseLock.wait(200);
                        } catch (InterruptedException ignored) {
                            Thread.currentThread().interrupt();
                            break;
                        }
                    }
                    continue;
                }

                SnesCore.nativeSetInput(pad.mask());
                SnesCore.nativeSetCheats(cheatMask);
                SnesCore.nativeSetVideoFilter(videoFilter);
                SnesCore.nativeRunFrame();

                int frames = SnesCore.nativeReadAudio(audioBuffer, AUDIO_FRAMES_PER_READ);
                if (frames > 0 && track != null) {
                    try {
                        track.write(audioBuffer, 0, frames * 2);
                    } catch (IllegalStateException ignored) { }
                }

                int w = SnesCore.nativeFrameWidth();
                int h = SnesCore.nativeFrameHeight();
                ensureBitmap(w, h);
                if (SnesCore.nativeCopyVideo(frameBuffer) == 1 && bitmap != null) {
                    int total = frameWidth * frameHeight;
                    shortFrameBuffer.position(0);
                    for (int i = 0; i < total; i++) {
                        argbPixels[i] = RGB565_TO_ARGB[shortFrameBuffer.get(i) & 0xFFFF];
                    }
                    bitmap.setPixels(argbPixels, 0, frameWidth, 0, 0, frameWidth, frameHeight);
                    view.present(bitmap);
                }
            }
        } catch (Throwable t) {
            Log.e(TAG, "emulation thread died", t);
        } finally {
            releaseAudio();
            try {
                SnesCore.nativeStop();
            } catch (Throwable ignored) { }
        }
    }

    private void ensureBitmap(int w, int h) {
        if (w <= 0 || h <= 0 || w > MAX_FB_W || h > MAX_FB_H) {
            w = 512;
            h = 448;
        }
        if (bitmap == null || w != frameWidth || h != frameHeight) {
            frameWidth = w;
            frameHeight = h;
            bitmap = Bitmap.createBitmap(frameWidth, frameHeight, Bitmap.Config.ARGB_8888);
            argbPixels = new int[frameWidth * frameHeight];
        }
    }

    private void createAudio() {
        int sampleRate = (int) Math.round(SnesCore.nativeSampleRate());
        if (sampleRate < 8000 || sampleRate > 192000) sampleRate = 44100;
        int minBuffer = AudioTrack.getMinBufferSize(sampleRate,
                AudioFormat.CHANNEL_OUT_STEREO, AudioFormat.ENCODING_PCM_16BIT);
        if (minBuffer <= 0) minBuffer = 8192;
        try {
            track = new AudioTrack.Builder()
                    .setAudioAttributes(new AudioAttributes.Builder()
                            .setUsage(AudioAttributes.USAGE_GAME)
                            .setContentType(AudioAttributes.CONTENT_TYPE_MUSIC)
                            .build())
                    .setAudioFormat(new AudioFormat.Builder()
                            .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                            .setSampleRate(sampleRate)
                            .setChannelMask(AudioFormat.CHANNEL_OUT_STEREO)
                            .build())
                    .setBufferSizeInBytes(Math.max(minBuffer * 2, 16384))
                    .setTransferMode(AudioTrack.MODE_STREAM)
                    .build();
            track.play();
        } catch (Throwable t) {
            Log.e(TAG, "audio track unavailable", t);
            track = null;
        }
    }

    private void releaseAudio() {
        AudioTrack t = track;
        track = null;
        if (t != null) {
            try {
                t.pause();
                t.flush();
                t.release();
            } catch (Throwable ignored) { }
        }
    }
}
