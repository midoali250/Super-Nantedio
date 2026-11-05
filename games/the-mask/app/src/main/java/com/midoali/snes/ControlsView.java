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
 *  - a 360-degree free-floating virtual analog joystick on the left side of the
 *    screen (anchors where the thumb touches on the left half and follows the
 *    thumb smoothly in all 8 directions)
 *  - the four face buttons in a diamond bottom right (X top, Y left, A right,
 *    B bottom)
 *  - L and R as shoulder buttons
 *  - START / SELECT pills at the top centre
 */
final class ControlsView extends View {
    private final VirtualPad pad;

    private final Paint fill = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint stroke = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint text = new Paint(Paint.ANTI_ALIAS_FLAG);

    private float controlScale = 1f;
    private boolean freeStick = true;

    private float stickHomeX, stickHomeY;
    private float stickBaseX, stickBaseY;
    private float stickKnobX, stickKnobY;
    private float stickRadius, stickKnobRadius;
    private int stickPointer = -1;

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

    void setFreeStick(boolean free) {
        freeStick = free;
        if (stickPointer < 0) {
            stickBaseX = stickHomeX;
            stickBaseY = stickHomeY;
            stickKnobX = stickHomeX;
            stickKnobY = stickHomeY;
        }
        invalidate();
    }

    boolean isFreeStick() {
        return freeStick;
    }

    private float dp(float v) {
        return v * getResources().getDisplayMetrics().density;
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        float w = getWidth(), h = getHeight();

        /* Free-floating virtual joystick home position, bottom left. */
        stickRadius = Math.min(h * 0.165f, w * 0.092f) * controlScale;
        stickKnobRadius = stickRadius * 0.46f;
        stickHomeX = stickRadius * 1.45f + dp(12f);
        stickHomeY = h - stickRadius * 1.35f - dp(12f);
        if (stickPointer < 0) {
            stickBaseX = stickHomeX;
            stickBaseY = stickHomeY;
            stickKnobX = stickHomeX;
            stickKnobY = stickHomeY;
        }

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

        /* Shoulders: L below the top-left menu buttons, R at top-right corner. */
        float shW = Math.min(w * 0.12f, dp(110f)) * controlScale;
        float shH = Math.min(h * 0.075f, dp(44f)) * controlScale;
        lRect.set(dp(10f), dp(58f), dp(10f) + shW, dp(58f) + shH);
        rRect.set(w - dp(10f) - shW, dp(10f), w - dp(10f), dp(10f) + shH);

        /* START / SELECT, top centre. */
        float pillW = Math.min(w * 0.12f, dp(110f));
        float pillH = Math.min(h * 0.08f, dp(42f));
        float cx = w * 0.54f;
        startRect.set(cx + dp(8f), dp(10f), cx + dp(8f) + pillW, dp(10f) + pillH);
        selectRect.set(cx - dp(8f) - pillW, dp(10f), cx - dp(8f), dp(10f) + pillH);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        drawFreeJoystick(canvas);
        drawFace(canvas);
        drawShoulder(canvas, lRect, "L", lPointer >= 0);
        drawShoulder(canvas, rRect, "R", rPointer >= 0);
        drawPill(canvas, startRect, "START", startPointer >= 0);
        drawPill(canvas, selectRect, "SELECT", selectPointer >= 0);
    }

    private void drawFreeJoystick(Canvas canvas) {
        boolean active = stickPointer >= 0;

        /* Outer base circle */
        fill.setColor(active ? 0x4416A34A : 0x38101820);
        canvas.drawCircle(stickBaseX, stickBaseY, stickRadius, fill);

        stroke.setColor(active ? 0xCC4ADE80 : 0x88FFFFFF);
        stroke.setStrokeWidth(dp(2.2f));
        canvas.drawCircle(stickBaseX, stickBaseY, stickRadius, stroke);

        /* Inner deadzone ring */
        stroke.setColor(0x44FFFFFF);
        stroke.setStrokeWidth(dp(1.2f));
        canvas.drawCircle(stickBaseX, stickBaseY, stickRadius * VirtualPad.STICK_DEADZONE, stroke);

        /* 8-direction guide ticks around the base ring */
        for (int a = 0; a < 360; a += 45) {
            double rad = Math.toRadians(a);
            float r0 = stickRadius * 0.78f;
            float r1 = stickRadius * 0.93f;
            float x0 = stickBaseX + (float) Math.cos(rad) * r0;
            float y0 = stickBaseY + (float) Math.sin(rad) * r0;
            float x1 = stickBaseX + (float) Math.cos(rad) * r1;
            float y1 = stickBaseY + (float) Math.sin(rad) * r1;
            stroke.setColor(a % 90 == 0 ? 0x99FFFFFF : 0x55FFFFFF);
            stroke.setStrokeWidth(dp(a % 90 == 0 ? 2f : 1.2f));
            canvas.drawLine(x0, y0, x1, y1, stroke);
        }

        /* Shaft connecting base center to movable thumb knob */
        stroke.setColor(active ? 0xBBFACC15 : 0x66FFFFFF);
        stroke.setStrokeWidth(dp(4f));
        canvas.drawLine(stickBaseX, stickBaseY, stickKnobX, stickKnobY, stroke);

        /* Movable thumb stick knob */
        fill.setColor(active ? 0xCC22C55E : 0x88202830);
        canvas.drawCircle(stickKnobX, stickKnobY, stickKnobRadius, fill);
        stroke.setColor(active ? 0xFFFDE047 : 0xCCFFFFFF);
        stroke.setStrokeWidth(dp(2.5f));
        canvas.drawCircle(stickKnobX, stickKnobY, stickKnobRadius, stroke);

        /* Inner highlight cap on knob */
        fill.setColor(0x44FFFFFF);
        canvas.drawCircle(stickKnobX - stickKnobRadius * 0.2f,
                stickKnobY - stickKnobRadius * 0.2f, stickKnobRadius * 0.42f, fill);
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
        for (int i = 0; i < 4; i++) {
            if (facePointer[i] < 0
                    && Math.hypot(x - faceCx[i], y - faceCy[i]) <= faceRadius * 1.3f) {
                facePointer[i] = id;
                pad.setFace(i, true);
                return;
            }
        }
        /* Free-floating joystick on the left side of the screen */
        float distFromHome = (float) Math.hypot(x - stickHomeX, y - stickHomeY);
        boolean inFreeZone = freeStick && x <= getWidth() * 0.48f && y >= lRect.bottom + dp(6f);
        if (stickPointer < 0 && (inFreeZone || distFromHome <= stickRadius * 1.45f)) {
            stickPointer = id;
            if (freeStick && distFromHome > stickRadius * 0.85f) {
                stickBaseX = x;
                stickBaseY = y;
            } else {
                stickBaseX = stickHomeX;
                stickBaseY = stickHomeY;
            }
            updateStick(x, y);
        }
    }

    private void handleMove(int id, float x, float y) {
        if (id == stickPointer) {
            updateStick(x, y);
        }
    }

    private void handleUp(int id) {
        if (id == stickPointer) {
            stickPointer = -1;
            stickBaseX = stickHomeX;
            stickBaseY = stickHomeY;
            stickKnobX = stickHomeX;
            stickKnobY = stickHomeY;
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
        stickPointer = -1;
        stickBaseX = stickHomeX;
        stickBaseY = stickHomeY;
        stickKnobX = stickHomeX;
        stickKnobY = stickHomeY;
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

    private void updateStick(float x, float y) {
        float[] res = pad.updateFreeStick(stickBaseX, stickBaseY, x, y, stickRadius, freeStick);
        stickBaseX = res[0];
        stickBaseY = res[1];
        stickKnobX = res[2];
        stickKnobY = res[3];
    }
}
