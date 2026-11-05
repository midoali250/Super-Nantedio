package com.midoali.snes;

import android.content.Context;
import android.graphics.Bitmap;
import android.media.AudioAttributes;
import android.media.AudioFormat;
import android.media.AudioTrack;
import android.util.Log;

import java.nio.ByteBuffer;

/**
 * Owns the emulation thread. Runs the core as fast as the audio queue allows,
 * which keeps NTSC timing and sound stable, and pushes each finished frame to
 * the view.
 */
final class Emulator implements Runnable {
    private static final String TAG = "SnesEmu";
    private static final int AUDIO_FRAMES_PER_READ = 1024;

    private final Context context;
    private final byte[] rom;
    private final GameView view;
    private final VirtualPad pad;

    private volatile boolean running;
    private volatile boolean paused;
    private final Object pauseLock = new Object();
    private Thread thread;
    private AudioTrack track;

    private Bitmap bitmap;
    private ByteBuffer frameBuffer;
    private final short[] audioBuffer = new short[AUDIO_FRAMES_PER_READ * 2];

    private int frameWidth = 256, frameHeight = 224;

    Emulator(Context context, byte[] rom, GameView view, VirtualPad pad) {
        this.context = context.getApplicationContext();
        this.rom = rom;
        this.view = view;
        this.pad = pad;
    }

    int frameWidth() { return frameWidth; }

    int frameHeight() { return frameHeight; }

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
            if (!SnesCore.nativeStart(rom, context.getFilesDir().getAbsolutePath())) {
                Log.e(TAG, "core rejected the ROM");
                return;
            }
            frameWidth = SnesCore.nativeFrameWidth();
            frameHeight = SnesCore.nativeFrameHeight();
            if (frameWidth <= 0 || frameHeight <= 0) {
                frameWidth = 256;
                frameHeight = 224;
            }
            bitmap = Bitmap.createBitmap(frameWidth, frameHeight, Bitmap.Config.RGB_565);
            frameBuffer = ByteBuffer.allocateDirect(frameWidth * frameHeight * 2);
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
                SnesCore.nativeRunFrame();

                int frames = SnesCore.nativeReadAudio(audioBuffer, AUDIO_FRAMES_PER_READ);
                if (frames > 0 && track != null) {
                    try {
                        track.write(audioBuffer, 0, frames * 2);
                    } catch (IllegalStateException ignored) { }
                }

                if (SnesCore.nativeCopyVideo(frameBuffer) == 1) {
                    frameBuffer.rewind();
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
