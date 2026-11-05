package com.midoali.nes;

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
 * onto the surface so video and audio stay in step; frames are letterboxed to
 * the NES 4:3 aspect ratio and never cropped.
 */
final class GameView extends SurfaceView implements SurfaceHolder.Callback {
    private final Paint paint = new Paint();
    private final Paint clear = new Paint();
    private final Rect dst = new Rect();
    private volatile int viewWidth, viewHeight;
    private volatile boolean stretch;
    void setStretch(boolean value) { stretch = value; }

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
            if (stretch) dst.set(0, 0, w, h);
            else frameRect(w, h, bitmap.getWidth(), bitmap.getHeight(), dst);
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
        int w = getWidth() > 0 ? getWidth() : viewWidth;
        int h = getHeight() > 0 ? getHeight() : viewHeight;
        Rect r = new Rect();
        if (stretch) r.set(0, 0, w, h);
        else frameRect(w > 0 ? w : 1920, h > 0 ? h : 1080, 256, 240, r);
        return r;
    }

    /** Fits the frame into the view keeping the NES 4:3 display aspect. */
    static void frameRect(int viewW, int viewH, int texW, int texH, Rect out) {
        int[] r = ScreenMap.fitRect(viewW, viewH);
        out.set(r[0], r[1], r[0] + r[2], r[1] + r[3]);
    }
}
