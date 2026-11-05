package com.midoali.snes;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.RectF;
import android.view.MotionEvent;
import android.view.View;

/**
 * On-screen SNES pad drawn over the video.
 *
 *  - a D-pad cross bottom left (touching an arm gives that direction, the
 *    corners give the diagonals)
 *  - the four face buttons in a diamond bottom right (X top, Y left, A right,
 *    B bottom) exactly like the real pad
 *  - L and R as shoulder buttons in the top corners
 *  - START / SELECT pills at the top centre
 */
final class ControlsView extends View {
    private static final int ZONE_NONE = 0;

    private final VirtualPad pad;

    private final Paint fill = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint stroke = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint text = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final RectF tmpRect = new RectF();

    private float controlScale = 1f;

    private float dpadCx, dpadCy, dpadArm, dpadRadius;
    private int dpadPointer = -1;
    private boolean dpadUp, dpadDown, dpadLeft, dpadRight;

    private final float[] faceCx = new float[4];
    private final float[] faceCy = new float[4];
    private float faceRadius;
    private final int[] facePointer = {-1, -1, -1, -1};

    private final RectF lRect = new RectF();
    private final RectF rRect = new RectF();
    private int lPointer = -1, rPointer = -1;

    private final RectF startRect = new RectF();
    private final RectF selectRect = new RectF();
    private int startPointer = -1, selectPointer = -1;

    ControlsView(Context context, VirtualPad pad) {
        super(context);
        this.pad = pad;
        setFocusable(false);
        fill.setStyle(Paint.Style.FILL);
        stroke.setStyle(Paint.Style.STROKE);
        text.setColor(Color.WHITE);
        text.setTextAlign(Paint.Align.CENTER);
        text.setFakeBoldText(true);
        setWillNotDraw(false);
    }

    void setControlScale(float scale) {
        controlScale = scale;
        requestLayout();
        invalidate();
    }

    private float dp(float v) {
        return v * getResources().getDisplayMetrics().density;
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        float w = getWidth(), h = getHeight();

        /* D-pad cross, bottom left. */
        dpadArm = Math.min(h * 0.115f, w * 0.062f) * controlScale;
        dpadRadius = dpadArm * 1.5f;
        dpadCx = dpadArm * 1.9f;
        dpadCy = h - dpadArm * 1.9f;

        /* Face buttons in a diamond, bottom right: X up, Y left, A right, B down. */
        faceRadius = Math.min(h * 0.082f, w * 0.043f) * controlScale;
        float spread = faceRadius * 2.05f;
        float fx = w - faceRadius * 3.0f - spread * 0.5f;
        float fy = h - faceRadius * 3.0f - spread * 0.5f;
        faceCx[VirtualPad.FACE_X] = fx;
        faceCy[VirtualPad.FACE_X] = fy - spread;
        faceCx[VirtualPad.FACE_Y] = fx - spread;
        faceCy[VirtualPad.FACE_Y] = fy;
        faceCx[VirtualPad.FACE_A] = fx + spread;
        faceCy[VirtualPad.FACE_A] = fy;
        faceCx[VirtualPad.FACE_B] = fx;
        faceCy[VirtualPad.FACE_B] = fy + spread;

        /* Shoulders, top corners. */
        float shW = Math.min(w * 0.12f, dp(110f)) * controlScale;
        float shH = Math.min(h * 0.075f, dp(44f)) * controlScale;
        lRect.set(dp(8f), dp(8f), dp(8f) + shW, dp(8f) + shH);
        rRect.set(w - dp(8f) - shW, dp(8f), w - dp(8f), dp(8f) + shH);

        /* START / SELECT, top centre. */
        float pillW = Math.min(w * 0.13f, dp(120f));
        float pillH = Math.min(h * 0.085f, dp(46f));
        float cx = w * 0.5f;
        startRect.set(cx + dp(10f), dp(10f), cx + dp(10f) + pillW, dp(10f) + pillH);
        selectRect.set(cx - dp(10f) - pillW, dp(10f), cx - dp(10f), dp(10f) + pillH);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        drawDpad(canvas);
        drawFace(canvas);
        drawShoulder(canvas, lRect, "L", lPointer >= 0);
        drawShoulder(canvas, rRect, "R", rPointer >= 0);
        drawPill(canvas, startRect, "START", startPointer >= 0);
        drawPill(canvas, selectRect, "SELECT", selectPointer >= 0);
    }

    private void drawDpad(Canvas canvas) {
        float a = dpadArm;
        float[] xs = {dpadCx, dpadCx, dpadCx - a, dpadCx + a};
        float[] ys = {dpadCy - a, dpadCy + a, dpadCy, dpadCy};
        boolean[] active = {dpadUp, dpadDown, dpadLeft, dpadRight};

        fill.setColor(0x33000000);
        canvas.drawRect(dpadCx - a, dpadCy - a, dpadCx + a, dpadCy + a, fill);

        for (int i = 0; i < 4; i++) {
            float hw = (i < 2) ? a : a;
            float hh = (i < 2) ? a : a;
            float x0 = (i == 0 || i == 2) ? xs[i] - hw : dpadCx - hw;
            float y0 = (i == 0 || i == 1) ? ys[i] - hh : dpadCy - hh;
            float x1 = (i == 1 || i == 3) ? xs[i] + hw : dpadCx + hw;
            float y1 = (i == 2 || i == 3) ? ys[i] + hh : dpadCy + hh;
            fill.setColor(active[i] ? 0x99E04040 : 0x55101010);
            canvas.drawRect(x0, y0, x1, y1, fill);
            stroke.setColor(active[i] ? 0xFFFFFFFF : 0x99FFFFFF);
            stroke.setStrokeWidth(dp(1.5f));
            canvas.drawRect(x0, y0, x1, y1, stroke);
        }

        /* Direction arrows. */
        text.setColor(Color.WHITE);
        text.setTextSize(a * 0.8f);
        canvas.drawText("▲", dpadCx, dpadCy - a * 0.35f, text);
        canvas.drawText("▼", dpadCx, dpadCy + a * 1.25f, text);
        canvas.drawText("◀", dpadCx - a * 0.9f, dpadCy + a * 0.35f, text);
        canvas.drawText("▶", dpadCx + a * 0.9f, dpadCy + a * 0.35f, text);
    }

    private void drawFace(Canvas canvas) {
        String[] labels = {"X", "Y", "A", "B"};
        for (int i = 0; i < 4; i++) {
            boolean down = facePointer[i] >= 0;
            fill.setColor(down ? 0x99E04040 : 0x55101010);
            canvas.drawCircle(faceCx[i], faceCy[i], faceRadius, fill);
            stroke.setColor(down ? 0xFFFFFFFF : 0x99FFFFFF);
            stroke.setStrokeWidth(dp(2f));
            canvas.drawCircle(faceCx[i], faceCy[i], faceRadius, stroke);
            text.setColor(Color.WHITE);
            text.setTextSize(faceRadius * 0.95f);
            canvas.drawText(labels[i], faceCx[i],
                    faceCy[i] + text.getTextSize() * 0.35f, text);
        }
    }

    private void drawShoulder(Canvas canvas, RectF r, String label, boolean down) {
        float radius = r.height() * 0.5f;
        fill.setColor(down ? 0x99E04040 : 0x55000000);
        canvas.drawRoundRect(r, radius, radius, fill);
        stroke.setColor(0x99FFFFFF);
        stroke.setStrokeWidth(dp(1.5f));
        canvas.drawRoundRect(r, radius, radius, stroke);
        text.setColor(Color.WHITE);
        text.setTextSize(r.height() * 0.6f);
        canvas.drawText(label, r.centerX(), r.centerY() + text.getTextSize() * 0.35f, text);
    }

    private void drawPill(Canvas canvas, RectF r, String label, boolean down) {
        float radius = r.height() * 0.5f;
        fill.setColor(down ? 0x99E04040 : 0x55000000);
        canvas.drawRoundRect(r, radius, radius, fill);
        stroke.setColor(0x99FFFFFF);
        stroke.setStrokeWidth(dp(1.5f));
        canvas.drawRoundRect(r, radius, radius, stroke);
        text.setColor(Color.WHITE);
        text.setTextSize(r.height() * 0.46f);
        canvas.drawText(label, r.centerX(), r.centerY() + text.getTextSize() * 0.35f, text);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        switch (event.getActionMasked()) {
            case MotionEvent.ACTION_DOWN:
            case MotionEvent.ACTION_POINTER_DOWN: {
                int index = event.getActionIndex();
                handleDown(event.getPointerId(index), event.getX(index), event.getY(index));
                break;
            }
            case MotionEvent.ACTION_MOVE: {
                for (int i = 0; i < event.getPointerCount(); i++) {
                    handleMove(event.getPointerId(i), event.getX(i), event.getY(i));
                }
                break;
            }
            case MotionEvent.ACTION_UP:
            case MotionEvent.ACTION_POINTER_UP: {
                int index = event.getActionIndex();
                handleUp(event.getPointerId(index));
                break;
            }
            case MotionEvent.ACTION_CANCEL:
                releaseAll();
                break;
            default:
                break;
        }
        invalidate();
        return true;
    }

    private void handleDown(int id, float x, float y) {
        /* D-pad: any touch inside the cross's bounding circle grabs it. */
        float dist = (float) Math.hypot(x - dpadCx, y - dpadCy);
        if (dpadPointer < 0 && dist <= dpadRadius * 1.25f) {
            dpadPointer = id;
            updateDpad(x, y);
            return;
        }
        for (int i = 0; i < 4; i++) {
            if (facePointer[i] < 0
                    && Math.hypot(x - faceCx[i], y - faceCy[i]) <= faceRadius * 1.3f) {
                facePointer[i] = id;
                pad.setFace(i, true);
                return;
            }
        }
        if (lPointer < 0 && lRect.contains(x, y)) {
            lPointer = id;
            pad.setShoulder(VirtualPad.SHOULDER_L, true);
            return;
        }
        if (rPointer < 0 && rRect.contains(x, y)) {
            rPointer = id;
            pad.setShoulder(VirtualPad.SHOULDER_R, true);
            return;
        }
        if (startPointer < 0 && startRect.contains(x, y)) {
            startPointer = id;
            pad.setButton(VirtualPad.BTN_START, true);
            return;
        }
        if (selectPointer < 0 && selectRect.contains(x, y)) {
            selectPointer = id;
            pad.setButton(VirtualPad.BTN_SELECT, true);
            return;
        }
    }

    private void handleMove(int id, float x, float y) {
        if (id == dpadPointer) {
            updateDpad(x, y);
        }
    }

    private void handleUp(int id) {
        if (id == dpadPointer) {
            dpadPointer = -1;
            dpadUp = dpadDown = dpadLeft = dpadRight = false;
            pad.setDpad(false, false, false, false);
        }
        for (int i = 0; i < 4; i++) {
            if (facePointer[i] == id) {
                facePointer[i] = -1;
                pad.setFace(i, false);
            }
        }
        if (lPointer == id) {
            lPointer = -1;
            pad.setShoulder(VirtualPad.SHOULDER_L, false);
        }
        if (rPointer == id) {
            rPointer = -1;
            pad.setShoulder(VirtualPad.SHOULDER_R, false);
        }
        if (startPointer == id) {
            startPointer = -1;
            pad.setButton(VirtualPad.BTN_START, false);
        }
        if (selectPointer == id) {
            selectPointer = -1;
            pad.setButton(VirtualPad.BTN_SELECT, false);
        }
    }

    void releaseAll() {
        dpadPointer = -1;
        dpadUp = dpadDown = dpadLeft = dpadRight = false;
        pad.setDpad(false, false, false, false);
        for (int i = 0; i < 4; i++) {
            facePointer[i] = -1;
            pad.setFace(i, false);
        }
        lPointer = rPointer = -1;
        pad.setShoulder(VirtualPad.SHOULDER_L, false);
        pad.setShoulder(VirtualPad.SHOULDER_R, false);
        startPointer = selectPointer = -1;
        pad.setButton(VirtualPad.BTN_START, false);
        pad.setButton(VirtualPad.BTN_SELECT, false);
    }

    /** Maps a touch on the cross to one of the eight pad directions. */
    private void updateDpad(float x, float y) {
        float dx = (x - dpadCx) / dpadArm;
        float dy = (y - dpadCy) / dpadArm;
        boolean up = false, down = false, left = false, right = false;

        if (Math.abs(dx) > 0.28f || Math.abs(dy) > 0.28f) {
            double deg = Math.toDegrees(Math.atan2(dy, dx));
            right = deg > -67.5 && deg < 67.5;
            left = deg > 112.5 || deg < -112.5;
            down = deg >= 22.5 && deg <= 157.5;
            up = deg <= -22.5 && deg >= -157.5;
        }

        dpadUp = up;
        dpadDown = down;
        dpadLeft = left;
        dpadRight = right;
        pad.setDpad(up, down, left, right);
    }
}
