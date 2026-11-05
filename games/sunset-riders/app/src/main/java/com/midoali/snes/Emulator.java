package com.midoali.snes;

import android.content.Context;
import android.graphics.Bitmap;
import android.media.AudioAttributes;
import android.media.AudioFormat;
import android.media.AudioTrack;
import android.os.Build;
import android.util.Log;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

/**
 * Owns the emulation thread. Copies the native 2x HQ Scale2x RGB565 frame
 * buffer directly into a hardware-uploaded RGB_565 Bitmap via zero-loop
 * copyPixelsFromBuffer and synchronizes 44.1 kHz stereo audio with pre-roll
 * cushioning for 60 FPS lag-free gameplay and crystal-clear sound.
 */
final class Emulator implements Runnable {
    private static final String TAG = "SnesEmu";
    private static final int AUDIO_FRAMES_PER_READ = 2048;
    private static final int MAX_FB_W = 800;
    private static final int MAX_FB_H = 600;

    private final Context context;
    private final byte[] rom;
    private final GameView view;
    private final VirtualPad pad;

    private volatile boolean running;
    private volatile boolean paused;
    private volatile boolean resetRequested;
    private volatile int videoFilter = SnesCore.VIDEO_FILTER_HD_CRISP;
    private final Object pauseLock = new Object();
    private Thread thread;
    private AudioTrack track;
    private boolean audioPlaying;
    private int prerollFrames;

    private Bitmap bitmap;
    private ByteBuffer frameBuffer;
    private final short[] audioBuffer = new short[AUDIO_FRAMES_PER_READ * 2];

    private int frameWidth = 640, frameHeight = 448;

    Emulator(Context context, byte[] rom, GameView view, VirtualPad pad) {
        this.context = context.getApplicationContext();
        this.rom = rom;
        this.view = view;
        this.pad = pad;
    }

    int frameWidth() { return frameWidth; }

    int frameHeight() { return frameHeight; }

    void resetGame() {
        resetRequested = true;
        synchronized (pauseLock) {
            pauseLock.notifyAll();
        }
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

    void start() {
        if (running) return;
        running = true;
        thread = new Thread(this, "snes-emulator");
        thread.setPriority(Thread.MAX_PRIORITY);
        thread.start();
    }

    void stop() {
        running = false;
        synchronized (pauseLock) {
            pauseLock.notifyAll();
        }
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
                if (value) {
                    t.pause();
                    audioPlaying = false;
                } else {
                    prerollFrames = 0;
                }
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
            ensureBitmap(SnesCore.nativeFrameWidth(), SnesCore.nativeFrameHeight());
            createAudio();

            while (running) {
                if (resetRequested) {
                    resetRequested = false;
                    SnesCore.nativeReset();
                    AudioTrack t = track;
                    if (t != null) {
                        try {
                            t.pause();
                            t.flush();
                            audioPlaying = false;
                            prerollFrames = 0;
                        } catch (IllegalStateException ignored) { }
                    }
                }

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
                SnesCore.nativeRunFrame();

                int frames = SnesCore.nativeReadAudio(audioBuffer, AUDIO_FRAMES_PER_READ);
                AudioTrack t = track;
                if (frames > 0 && t != null) {
                    try {
                        if (Build.VERSION.SDK_INT >= 23) {
                            t.write(audioBuffer, 0, frames * 2, AudioTrack.WRITE_BLOCKING);
                        } else {
                            t.write(audioBuffer, 0, frames * 2);
                        }
                        if (!audioPlaying) {
                            prerollFrames += frames;
                            if (prerollFrames >= 1472) {
                                t.play();
                                audioPlaying = true;
                            }
                        }
                    } catch (IllegalStateException ignored) { }
                }

                int w = SnesCore.nativeFrameWidth();
                int h = SnesCore.nativeFrameHeight();
                ensureBitmap(w, h);
                if (frameBuffer != null && SnesCore.nativeCopyVideo(frameBuffer) == 1 && bitmap != null) {
                    frameBuffer.position(0);
                    try {
                        bitmap.copyPixelsFromBuffer(frameBuffer);
                    } catch (RuntimeException ignored) { }
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
            w = 640;
            h = 448;
        }
        if (bitmap == null || w != frameWidth || h != frameHeight) {
            frameWidth = w;
            frameHeight = h;
            bitmap = Bitmap.createBitmap(frameWidth, frameHeight, Bitmap.Config.RGB_565);
            frameBuffer = ByteBuffer.allocateDirect(frameWidth * frameHeight * 2).order(ByteOrder.nativeOrder());
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
            audioPlaying = false;
            prerollFrames = 0;
        } catch (Throwable t) {
            Log.e(TAG, "audio track unavailable", t);
            track = null;
        }
    }

    private void releaseAudio() {
        AudioTrack t = track;
        track = null;
        audioPlaying = false;
        if (t != null) {
            try {
                t.pause();
                t.flush();
                t.release();
            } catch (Throwable ignored) { }
        }
    }
}
