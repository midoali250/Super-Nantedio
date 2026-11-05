package com.midoali.snes;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.view.SurfaceHolder;
import android.view.SurfaceView;

/**
 * High-definition surface view for Sunset Riders (رعاة البقر).
 * Uses hardware bilinear filtering on top of the native 2x Scale2x + De-Dither
 * ARGB_8888 frame buffer ("Sharp Bilinear + Scale2x") for crystal-clear image
 * quality across full-width mobile widescreen displays.
 */
final class GameView extends SurfaceView implements SurfaceHolder.Callback {
    private final Paint paint = new Paint(Paint.FILTER_BITMAP_FLAG | Paint.ANTI_ALIAS_FLAG | Paint.DITHER_FLAG);
    private final Paint clear = new Paint();
    private final Rect dst = new Rect();
    private volatile int viewWidth, viewHeight;
    private volatile boolean stretch = true;
    private volatile boolean smoothFilter = true;

    void setStretch(boolean value) { stretch = value; }

    boolean isStretch() { return stretch; }

    void setSmoothFilter(boolean value) {
        smoothFilter = value;
        paint.setFilterBitmap(value);
        paint.setAntiAlias(value);
        paint.setDither(true);
    }

    boolean isSmoothFilter() { return smoothFilter; }

    GameView(Context context) {
        super(context);
        getHolder().addCallback(this);
        setFocusable(false);
        paint.setFilterBitmap(true);
        paint.setAntiAlias(true);
        paint.setDither(true);
        clear.setColor(Color.BLACK);
    }

    @Override
    public void surfaceCreated(SurfaceHolder holder) {
        viewWidth = getWidth();
        viewHeight = getHeight();
    }

    @Override
    public void surfaceChanged(SurfaceHolder holder, int format, int width, int height) {
        viewWidth = width;
        viewHeight = height;
    }

    @Override
    public void surfaceDestroyed(SurfaceHolder holder) { }

    /** Called on the emulator thread. */
    void present(Bitmap bitmap) {
        SurfaceHolder holder = getHolder();
        if (holder == null || bitmap == null) return;
        Canvas canvas = null;
        try {
            canvas = holder.lockCanvas();
            if (canvas == null) return;
            int w = canvas.getWidth();
            int h = canvas.getHeight();
            viewWidth = w;
            viewHeight = h;
            int[] r = ScreenMap.displayRect(w, h, stretch);
            dst.set(r[0], r[1], r[0] + r[2], r[1] + r[3]);
            canvas.drawRect(0, 0, w, h, clear);
            canvas.drawBitmap(bitmap, null, dst, paint);
        } catch (IllegalArgumentException ignored) {
            /* surface went away mid-frame */
        } finally {
            if (canvas != null) {
                try {
                    holder.unlockCanvasAndPost(canvas);
                } catch (IllegalArgumentException ignored) { }
            }
        }
    }

    /** Area (in view pixels) the emulator image occupies right now. */
    Rect imageRect() {
        int w = getWidth() > 0 ? getWidth() : (viewWidth > 0 ? viewWidth : 1920);
        int h = getHeight() > 0 ? getHeight() : (viewHeight > 0 ? viewHeight : 1080);
        int[] r = ScreenMap.displayRect(w, h, stretch);
        return new Rect(r[0], r[1], r[0] + r[2], r[1] + r[3]);
    }

    static void frameRect(int viewW, int viewH, int texW, int texH, Rect out) {
        int[] r = ScreenMap.fitRect(viewW, viewH);
        out.set(r[0], r[1], r[0] + r[2], r[1] + r[3]);
    }
}
