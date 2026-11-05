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
 * Surface that shows the emulator output. The emulator thread draws directly
 * onto the surface so video and audio stay in step. Defaults to full mobile
 * widescreen across the entire display width, with an option in Settings to
 * switch to 4:3 pillarboxed mode.
 */
final class GameView extends SurfaceView implements SurfaceHolder.Callback {
    private final Paint paint = new Paint();
    private final Paint clear = new Paint();
    private final Rect dst = new Rect();
    private volatile int viewWidth, viewHeight;
    private volatile boolean stretch = true;

    void setStretch(boolean value) { stretch = value; }

    boolean isStretch() { return stretch; }

    GameView(Context context) {
        super(context);
        getHolder().addCallback(this);
        setFocusable(false);
        paint.setFilterBitmap(false);
        paint.setAntiAlias(false);
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

    /** Fits the frame into the view keeping the SNES 4:3 display aspect. */
    static void frameRect(int viewW, int viewH, int texW, int texH, Rect out) {
        int[] r = ScreenMap.fitRect(viewW, viewH);
        out.set(r[0], r[1], r[0] + r[2], r[1] + r[3]);
    }
}
