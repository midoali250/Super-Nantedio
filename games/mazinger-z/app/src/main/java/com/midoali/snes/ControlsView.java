package com.midoali.snes;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.LinearGradient;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.RadialGradient;
import android.graphics.RectF;
import android.graphics.Shader;
import android.view.MotionEvent;
import android.view.View;

/**
 * On-screen Super Famicom pad, drawn over the video.
 *
 * Design goals:
 *  - elegant, modern look: soft glass panels, rim light, animated press glow
 *  - every button of the real game pad is present and functional
 *  - analogue stick with NO limit and NO deadzone (see VirtualPad)
 *  - the player can remap each button's action, its size, its opacity and
 *    where it sits (drag-and-drop layout, persisted)
 */
final class ControlsView extends View {

    /* ---- Layout knobs pushed in from the settings panel ---- */
    private float controlScale = 1f;
    private boolean freeStick = true;
    private int accent = 0xFF2DD4BF;          /* teal default */

    /* Per-slot offsets in dp, applied on top of the base layout. */
    private final float[] slotDx = new float[VirtualPad.SLOT_COUNT];
    private final float[] slotDy = new float[VirtualPad.SLOT_COUNT];
    private boolean editMode;

    private final VirtualPad pad;

    private final Paint fill = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint stroke = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint text = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint shadow = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint glow = new Paint(Paint.ANTI_ALIAS_FLAG);

    /* Stick geometry */
    private float stickHomeX, stickHomeY;
    private float stickBaseX, stickBaseY;
    private float stickKnobX, stickKnobY;
    private float stickRadius, stickKnobRadius;
    private int stickPointer = -1;

    /* Face buttons (slots B/Y/A/X) */
    private final float[] faceCx = new float[4];
    private final float[] faceCy = new float[4];
    private float faceRadius;
    private final int[] facePointer = {-1, -1, -1, -1};

    /* Shoulders + system pills, per slot */
    private final RectF[] slotRect = new RectF[VirtualPad.SLOT_COUNT];
    private final int[] slotPointer = new int[VirtualPad.SLOT_COUNT];

    ControlsView(Context context, VirtualPad pad) {
        super(context);
        this.pad = pad;
        for (int i = 0; i < slotRect.length; i++) {
            slotRect[i] = new RectF();
            slotPointer[i] = -1;
        }
        setFocusable(false);
        fill.setStyle(Paint.Style.FILL);
        stroke.setStyle(Paint.Style.STROKE);
        text.setColor(Color.WHITE);
        text.setTextAlign(Paint.Align.CENTER);
        text.setFakeBoldText(true);
        shadow.setColor(0x66000000);
        setWillNotDraw(false);
        setLayerType(LAYER_TYPE_HARDWARE, null);
    }

    /* ------------------------------------------------------------------ API */

    void setControlScale(float scale) {
        controlScale = Math.max(0.55f, Math.min(1.6f, scale));
        requestLayout();
        invalidate();
    }

    void setFreeStick(boolean free) {
        freeStick = free;
        if (stickPointer < 0) resetStickToHome();
        invalidate();
    }

    boolean isFreeStick() { return freeStick; }

    void setAccent(int color) {
        accent = color;
        invalidate();
    }

    void setSlotOffset(int slot, float dx, float dy) {
        if (slot < 0 || slot >= VirtualPad.SLOT_COUNT) return;
        slotDx[slot] = dx;
        slotDy[slot] = dy;
        requestLayout();
        invalidate();
    }

    float slotOffsetX(int slot) { return slot < 0 ? 0 : slotDx[slot]; }

    float slotOffsetY(int slot) { return slot < 0 ? 0 : slotDy[slot]; }

    void setEditMode(boolean on) {
        editMode = on;
        invalidate();
    }

    boolean isEditMode() { return editMode; }

    void clearFeedback() { invalidate(); }

    private float dp(float v) {
        return v * getResources().getDisplayMetrics().density;
    }

    /* -------------------------------------------------------------- Layout */

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        float w = getWidth(), h = getHeight();

        /* Analogue stick, bottom left. */
        stickRadius = Math.min(h * 0.170f, w * 0.095f) * controlScale;
        stickKnobRadius = stickRadius * 0.44f;
        stickHomeX = stickRadius * 1.42f + dp(14f);
        stickHomeY = h - stickRadius * 1.30f - dp(14f);
        if (stickPointer < 0) resetStickToHome();

        /* Face diamond bottom right: X up, Y left, A right, B down. */
        faceRadius = Math.min(h * 0.083f, w * 0.044f) * controlScale;
        float spread = faceRadius * 2.10f;
        float fx = w - faceRadius * 2.6f - spread * 0.55f;
        float fy = h - faceRadius * 2.6f - spread * 0.55f;
        placeFace(VirtualPad.SLOT_X, fx, fy - spread);
        placeFace(VirtualPad.SLOT_Y, fx - spread, fy);
        placeFace(VirtualPad.SLOT_A, fx + spread, fy);
        placeFace(VirtualPad.SLOT_B, fx, fy + spread);

        /* Shoulders: full-width pill above the stick and above the diamond. */
        float shW = Math.min(w * 0.155f, dp(150f)) * controlScale;
        float shH = Math.min(h * 0.088f, dp(52f)) * controlScale;
        slotRect[VirtualPad.SLOT_L].set(
                dp(10f) + slotDx[VirtualPad.SLOT_L], h * 0.30f + slotDy[VirtualPad.SLOT_L],
                dp(10f) + slotDx[VirtualPad.SLOT_L] + shW,
                h * 0.30f + slotDy[VirtualPad.SLOT_L] + shH);
        slotRect[VirtualPad.SLOT_R].set(
                w - dp(10f) - shW + slotDx[VirtualPad.SLOT_R], h * 0.30f + slotDy[VirtualPad.SLOT_R],
                w - dp(10f) + slotDx[VirtualPad.SLOT_R],
                h * 0.30f + slotDy[VirtualPad.SLOT_R] + shH);

        /* START / SELECT, centred at the bottom edge. */
        float pillW = Math.min(w * 0.115f, dp(112f)) * Math.max(0.85f, controlScale);
        float pillH = Math.min(h * 0.077f, dp(44f)) * Math.max(0.85f, controlScale);
        float cx = w * 0.50f;
        float py = h - pillH - dp(6f);
        slotRect[VirtualPad.SLOT_SELECT].set(
                cx - dp(9f) - pillW + slotDx[VirtualPad.SLOT_SELECT],
                py + slotDy[VirtualPad.SLOT_SELECT],
                cx - dp(9f) + slotDx[VirtualPad.SLOT_SELECT],
                py + slotDy[VirtualPad.SLOT_SELECT] + pillH);
        slotRect[VirtualPad.SLOT_START].set(
                cx + dp(9f) + slotDx[VirtualPad.SLOT_START],
                py + slotDy[VirtualPad.SLOT_START],
                cx + dp(9f) + pillW + slotDx[VirtualPad.SLOT_START],
                py + slotDy[VirtualPad.SLOT_START] + pillH);
    }

    private void placeFace(int slot, float cx, float cy) {
        int i = slotToFaceIndex(slot);
        faceCx[i] = cx + slotDx[slot];
        faceCy[i] = cy + slotDy[slot];
    }

    private static int slotToFaceIndex(int slot) {
        switch (slot) {
            case VirtualPad.SLOT_X: return 0;
            case VirtualPad.SLOT_Y: return 1;
            case VirtualPad.SLOT_A: return 2;
            case VirtualPad.SLOT_B: return 3;
            default: return 0;
        }
    }

    private static int faceIndexToSlot(int i) {
        switch (i) {
            case 0: return VirtualPad.SLOT_X;
            case 1: return VirtualPad.SLOT_Y;
            case 2: return VirtualPad.SLOT_A;
            default: return VirtualPad.SLOT_B;
        }
    }

    /* --------------------------------------------------------------- Draw */

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        drawJoystick(canvas);
        for (int i = 0; i < 4; i++) drawFaceButton(canvas, i);
        drawPill(canvas, VirtualPad.SLOT_L);
        drawPill(canvas, VirtualPad.SLOT_R);
        drawPill(canvas, VirtualPad.SLOT_START);
        drawPill(canvas, VirtualPad.SLOT_SELECT);
    }

    private void drawJoystick(Canvas canvas) {
        boolean active = stickPointer >= 0;

        /* Base glass disc with a radial falloff, so it reads as a modern stick
         * pad rather than a flat circle. */
        fill.setShader(new RadialGradient(stickBaseX, stickBaseY, stickRadius,
                new int[] {active ? withAlpha(accent, 0x44) : 0x33FFFFFF,
                           active ? withAlpha(accent, 0x18) : 0x14000000},
                new float[] {0f, 1f}, Shader.TileMode.CLAMP));
        canvas.drawCircle(stickBaseX, stickBaseY, stickRadius, fill);
        fill.setShader(null);

        /* Rim light */
        stroke.setColor(active ? withAlpha(accent, 0xCC) : 0x77FFFFFF);
        stroke.setStrokeWidth(dp(active ? 2.4f : 1.8f));
        canvas.drawCircle(stickBaseX, stickBaseY, stickRadius - dp(1f), stroke);

        /* Inner guide ring (pure decoration: there is no dead zone). */
        stroke.setColor(0x22FFFFFF);
        stroke.setStrokeWidth(dp(1f));
        canvas.drawCircle(stickBaseX, stickBaseY, stickRadius * 0.62f, stroke);

        /* Cardinal notches */
        for (int a = 0; a < 360; a += 90) {
            double rad = Math.toRadians(a);
            float r0 = stickRadius * 0.80f, r1 = stickRadius * 0.94f;
            stroke.setColor(0x88FFFFFF);
            stroke.setStrokeWidth(dp(2f));
            canvas.drawLine(stickBaseX + (float) Math.cos(rad) * r0,
                    stickBaseY + (float) Math.sin(rad) * r0,
                    stickBaseX + (float) Math.cos(rad) * r1,
                    stickBaseY + (float) Math.sin(rad) * r1, stroke);
        }

        /* Movement arc: shows how far the thumb is pushing. */
        if (active) {
            float nx = pad.stickNormX(), ny = pad.stickNormY();
            float len = (float) Math.sqrt(nx * nx + ny * ny);
            if (len > 0.02f) {
                stroke.setColor(withAlpha(accent, 0xAA));
                stroke.setStrokeWidth(dp(3f));
                float r = stickRadius * 0.62f;
                RectF arc = new RectF(stickBaseX - r, stickBaseY - r,
                        stickBaseX + r, stickBaseY + r);
                float mid = (float) Math.toDegrees(Math.atan2(ny, nx));
                canvas.drawArc(arc, mid - 26f, 52f, false, stroke);
            }
        }

        /* Knob: gradient dome + specular highlight + rim. */
        fill.setShader(new RadialGradient(stickKnobX - stickKnobRadius * 0.3f,
                stickKnobY - stickKnobRadius * 0.35f, stickKnobRadius * 1.25f,
                new int[] {active ? 0xFFFFFFFF : 0xEEF1F5F9,
                           active ? lighten(accent, 0.35f) : 0xFF94A3B8,
                           active ? accent : 0xFF475569},
                new float[] {0f, 0.55f, 1f}, Shader.TileMode.CLAMP));
        canvas.drawCircle(stickKnobX, stickKnobY, stickKnobRadius, fill);
        fill.setShader(null);

        stroke.setColor(active ? withAlpha(accent, 0xFF) : 0xCCFFFFFF);
        stroke.setStrokeWidth(dp(2.2f));
        canvas.drawCircle(stickKnobX, stickKnobY, stickKnobRadius, stroke);

        text.setColor(active ? 0xFF04222B : 0xCC0F172A);
        text.setTextSize(stickKnobRadius * 0.78f);
        canvas.drawText("MZ", stickKnobX, stickKnobY + text.getTextSize() * 0.34f, text);
    }

    private void drawFaceButton(Canvas canvas, int i) {
        int slot = faceIndexToSlot(i);
        boolean down = facePointer[i] >= 0;
        float cx = faceCx[i], cy = faceCy[i];

        /* Drop shadow */
        shadow.setColor(0x55000000);
        canvas.drawCircle(cx, cy + dp(3f), faceRadius, shadow);

        if (down) {
            glow.setColor(withAlpha(accent, 0x66));
            canvas.drawCircle(cx, cy, faceRadius * 1.22f, glow);
        }

        fill.setShader(new RadialGradient(cx - faceRadius * 0.25f, cy - faceRadius * 0.3f,
                faceRadius * 1.5f,
                down ? new int[] {lighten(accent, 0.55f), accent, darken(accent, 0.30f)}
                     : new int[] {0x55FFFFFF, 0x2A0F172A, 0x77000000},
                new float[] {0f, 0.6f, 1f}, Shader.TileMode.CLAMP));
        canvas.drawCircle(cx, cy, faceRadius, fill);
        fill.setShader(null);

        stroke.setColor(down ? 0xFFFFFFFF : 0x99FFFFFF);
        stroke.setStrokeWidth(dp(down ? 2.6f : 1.8f));
        canvas.drawCircle(cx, cy, faceRadius, stroke);

        text.setColor(Color.WHITE);
        text.setTextSize(faceRadius * 0.98f);
        canvas.drawText(VirtualPad.SLOT_LABELS[slot], cx,
                cy + text.getTextSize() * 0.35f, text);
    }

    private void drawPill(Canvas canvas, int slot) {
        RectF r = slotRect[slot];
        boolean down = slotPointer[slot] >= 0;
        float radius = r.height() * 0.5f;

        shadow.setColor(0x55000000);
        RectF shadowRect = new RectF(r);
        shadowRect.offset(0, dp(2.5f));
        canvas.drawRoundRect(shadowRect, radius, radius, shadow);

        if (down) {
            glow.setColor(withAlpha(accent, 0x55));
            RectF big = new RectF(r);
            big.inset(-dp(3f), -dp(3f));
            canvas.drawRoundRect(big, radius + dp(3f), radius + dp(3f), glow);
        }

        fill.setShader(new LinearGradient(r.left, r.top, r.left, r.bottom,
                down ? new int[] {lighten(accent, 0.45f), accent, darken(accent, 0.25f)}
                     : new int[] {0x66FFFFFF, 0x2C0F172A, 0x88000000},
                new float[] {0f, 0.55f, 1f}, Shader.TileMode.CLAMP));
        canvas.drawRoundRect(r, radius, radius, fill);
        fill.setShader(null);

        stroke.setColor(down ? 0xFFFFFFFF : 0x88FFFFFF);
        stroke.setStrokeWidth(dp(down ? 2.2f : 1.4f));
        canvas.drawRoundRect(r, radius, radius, stroke);

        text.setColor(Color.WHITE);
        text.setTextSize(r.height() * (slot >= VirtualPad.SLOT_START ? 0.42f : 0.52f));
        canvas.drawText(VirtualPad.SLOT_LABELS[slot], r.centerX(),
                r.centerY() + text.getTextSize() * 0.35f, text);

        if (editMode) {
            stroke.setColor(withAlpha(accent, 0xEE));
            stroke.setStrokeWidth(dp(1.6f));
            RectF handle = new RectF(r);
            handle.inset(-dp(4f), -dp(4f));
            canvas.drawRoundRect(handle, radius + dp(4f), radius + dp(4f), stroke);
        }
    }

    private static int withAlpha(int color, int alpha) {
        return (color & 0x00FFFFFF) | ((alpha & 0xFF) << 24);
    }

    private static int lighten(int color, float amount) {
        int r = Math.min(255, (int) (Color.red(color) + (255 - Color.red(color)) * amount));
        int g = Math.min(255, (int) (Color.green(color) + (255 - Color.green(color)) * amount));
        int b = Math.min(255, (int) (Color.blue(color) + (255 - Color.blue(color)) * amount));
        return Color.rgb(r, g, b);
    }

    private static int darken(int color, float amount) {
        int r = (int) (Color.red(color) * (1f - amount));
        int g = (int) (Color.green(color) * (1f - amount));
        int b = (int) (Color.blue(color) * (1f - amount));
        return Color.rgb(r, g, b);
    }

    /* -------------------------------------------------------------- Touch */

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
        /* Edit mode: dragging moves the button instead of pressing it. */
        if (editMode) {
            for (int slot = 0; slot < VirtualPad.SLOT_COUNT; slot++) {
                if (hitSlot(slot, x, y)) {
                    slotPointer[slot] = id;
                    return;
                }
            }
            return;
        }

        for (int slot = VirtualPad.SLOT_L; slot < VirtualPad.SLOT_COUNT; slot++) {
            if (slotPointer[slot] < 0 && hitSlot(slot, x, y)) {
                slotPointer[slot] = id;
                pad.setSlot(slot, true);
                return;
            }
        }
        for (int i = 0; i < 4; i++) {
            if (facePointer[i] < 0
                    && Math.hypot(x - faceCx[i], y - faceCy[i]) <= faceRadius * 1.32f) {
                facePointer[i] = id;
                pad.setSlot(faceIndexToSlot(i), true);
                return;
            }
        }
        float distFromHome = (float) Math.hypot(x - stickHomeX, y - stickHomeY);
        boolean inFreeZone = freeStick && x <= getWidth() * 0.52f;
        if (stickPointer < 0 && (inFreeZone || distFromHome <= stickRadius * 1.5f)) {
            stickPointer = id;
            if (freeStick && distFromHome > stickRadius * 0.8f) {
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
            return;
        }
        if (editMode) {
            for (int slot = 0; slot < VirtualPad.SLOT_COUNT; slot++) {
                if (slotPointer[slot] == id && slot >= VirtualPad.SLOT_L) {
                    /* Keep the anchor of the last layout pass and shift it. */
                    RectF r = slotRect[slot];
                    float w = r.width();
                    slotDx[slot] = x - dp(10f) - (slot == VirtualPad.SLOT_R ? w : 0f);
                    slotDy[slot] = y - dp(10f);
                    requestLayout();
                    invalidate();
                    return;
                }
            }
            return;
        }
        for (int i = 0; i < 4; i++) {
            if (facePointer[i] == id) {
                if (Math.hypot(x - faceCx[i], y - faceCy[i]) > faceRadius * 1.55f) {
                    facePointer[i] = -1;
                    pad.setSlot(faceIndexToSlot(i), false);
                }
            }
        }
        for (int slot = VirtualPad.SLOT_L; slot < VirtualPad.SLOT_COUNT; slot++) {
            if (slotPointer[slot] == id && !slotRect[slot].contains(x, y)) {
                slotPointer[slot] = -1;
                pad.setSlot(slot, false);
            }
        }
    }

    private boolean hitSlot(int slot, float x, float y) {
        if (slot >= VirtualPad.SLOT_L) {
            RectF r = slotRect[slot];
            return r.width() > 0 && r.contains(x, y);
        }
        int i = slotToFaceIndex(slot);
        return Math.hypot(x - faceCx[i], y - faceCy[i]) <= faceRadius * 1.32f;
    }

    private void handleUp(int id) {
        if (id == stickPointer) {
            stickPointer = -1;
            resetStickToHome();
            pad.setDpad(false, false, false, false);
        }
        for (int i = 0; i < 4; i++) {
            if (facePointer[i] == id) {
                facePointer[i] = -1;
                pad.setSlot(faceIndexToSlot(i), false);
            }
        }
        for (int slot = VirtualPad.SLOT_L; slot < VirtualPad.SLOT_COUNT; slot++) {
            if (slotPointer[slot] == id) {
                slotPointer[slot] = -1;
                pad.setSlot(slot, false);
            }
        }
    }

    void releaseAll() {
        stickPointer = -1;
        resetStickToHome();
        pad.setDpad(false, false, false, false);
        for (int i = 0; i < 4; i++) {
            facePointer[i] = -1;
            pad.setSlot(faceIndexToSlot(i), false);
        }
        for (int slot = VirtualPad.SLOT_L; slot < VirtualPad.SLOT_COUNT; slot++) {
            slotPointer[slot] = -1;
            pad.setSlot(slot, false);
        }
    }

    private void resetStickToHome() {
        stickBaseX = stickHomeX;
        stickBaseY = stickHomeY;
        stickKnobX = stickHomeX;
        stickKnobY = stickHomeY;
    }

    private void updateStick(float x, float y) {
        float[] res = pad.updateFreeStick(stickBaseX, stickBaseY, x, y, stickRadius, freeStick);
        stickBaseX = res[0];
        stickBaseY = res[1];
        stickKnobX = res[2];
        stickKnobY = res[3];
    }
}
