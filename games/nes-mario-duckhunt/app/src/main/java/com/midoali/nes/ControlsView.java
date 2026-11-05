package com.midoali.nes;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.view.MotionEvent;
import android.view.View;

/**
 * On-screen controls drawn over the video.
 *
 *  - free analog stick on the left (maps to the NES d-pad)
 *  - four round buttons on the right: BIG JUMP, SMALL JUMP (repeat),
 *    rapid FIRE, single FIRE
 *  - START / SELECT pills at the top
 *  - a tap anywhere else on the play area is a Zapper shot at that pixel
 */
final class ControlsView extends View {
    private static final int ZONE_NONE = 0, ZONE_STICK = 1, ZONE_BUTTON = 2,
            ZONE_START = 3, ZONE_SELECT = 4, ZONE_SHOOT = 5;

    private final VirtualPad pad;
    private final GameView gameView;

    private final Paint fill = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint stroke = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint text = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint shot = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final RectF tmpRect = new RectF();

    private float stickCx, stickCy, stickRadius, knobRadius;
    private float controlScale = 1f;
    void setControlScale(float scale) { controlScale = scale; requestLayout(); invalidate(); }
    private float[] buttonCx = new float[4];
    private float[] buttonCy = new float[4];
    private float buttonRadius;
    private final RectF startRect = new RectF();
    private final RectF selectRect = new RectF();

    private int stickPointer = -1;
    private float stickDx, stickDy;
    private final int[] buttonPointer = {-1, -1, -1, -1};
    private int startPointer = -1, selectPointer = -1, shootPointer = -1;

    private float shotX = -1, shotY = -1;
    private long shotTime;

    ControlsView(Context context, VirtualPad pad, GameView gameView) {
        super(context);
        this.pad = pad;
        this.gameView = gameView;
        setFocusable(false);
        fill.setStyle(Paint.Style.FILL);
        stroke.setStyle(Paint.Style.STROKE);
        text.setColor(Color.WHITE);
        text.setTextAlign(Paint.Align.CENTER);
        text.setFakeBoldText(true);
        shot.setStyle(Paint.Style.STROKE);
        shot.setStrokeWidth(dp(2f));
        shot.setColor(0xFFFF4040);
        setWillNotDraw(false);
    }

    private float dp(float v) {
        return v * getResources().getDisplayMetrics().density;
    }

    @Override
    protected void onLayout(boolean changed, int left, int top, int right, int bottom) {
        super.onLayout(changed, left, top, right, bottom);
        float w = getWidth(), h = getHeight();
        stickRadius = Math.min(h * 0.26f, w * 0.11f) * controlScale;
        knobRadius = stickRadius * 0.46f;
        stickCx = stickRadius * 1.45f;
        stickCy = h - stickRadius * 1.45f;

        buttonRadius = Math.min(h * 0.115f, w * 0.055f) * controlScale;
        float gap = buttonRadius * 0.34f;
        float bx = w - buttonRadius * 1.55f - (buttonRadius * 2 + gap);
        float by = h - buttonRadius * 3.5f - gap;
        buttonCx[0] = bx;                   buttonCy[0] = by;                       /* BIG   (top-left) */
        buttonCx[1] = bx + (buttonRadius * 2 + gap); buttonCy[1] = by;               /* SMALL (top-right) */
        buttonCx[2] = bx;                   buttonCy[2] = by + buttonRadius * 2 + gap; /* RAPID (bottom-left) */
        buttonCx[3] = bx + (buttonRadius * 2 + gap); buttonCy[3] = by + buttonRadius * 2 + gap; /* FIRE (bottom-right) */

        float pillW = Math.min(w * 0.13f, dp(120f));
        float pillH = Math.min(h * 0.085f, dp(46f));
        float cx = w * 0.5f;
        startRect.set(cx + dp(10f), dp(10f), cx + dp(10f) + pillW, dp(10f) + pillH);
        selectRect.set(cx - dp(10f) - pillW, dp(10f), cx - dp(10f), dp(10f) + pillH);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        drawStick(canvas);
        drawButtons(canvas);
        drawPills(canvas);
        drawShot(canvas);
    }

    private void drawStick(Canvas canvas) {
        fill.setColor(0x33000000);
        canvas.drawCircle(stickCx, stickCy, stickRadius, fill);
        stroke.setColor(0x88FFFFFF);
        stroke.setStrokeWidth(dp(2f));
        canvas.drawCircle(stickCx, stickCy, stickRadius, stroke);

        float kx = stickCx + stickDx * (stickRadius - knobRadius);
        float ky = stickCy + stickDy * (stickRadius - knobRadius);
        fill.setColor(0xCCFFFFFF);
        canvas.drawCircle(kx, ky, knobRadius, fill);
        fill.setColor(0x44FFFFFF);
        canvas.drawCircle(kx, ky, knobRadius * 0.6f, fill);
    }

    private void drawButtons(Canvas canvas) {
        String[][] labels = {
                {"BIG", "JUMP"}, {"SMALL", "JUMP"}, {"RAPID", "FIRE"}, {"SINGLE", "FIRE"}
        };
        for (int i = 0; i < 4; i++) {
            boolean down = buttonPointer[i] >= 0;
            fill.setColor(down ? 0x99E04040 : 0x55101010);
            canvas.drawCircle(buttonCx[i], buttonCy[i], buttonRadius, fill);
            stroke.setColor(down ? 0xFFFFFFFF : 0x99FFFFFF);
            stroke.setStrokeWidth(dp(2f));
            canvas.drawCircle(buttonCx[i], buttonCy[i], buttonRadius, stroke);

            text.setColor(Color.WHITE);
            text.setTextSize(buttonRadius * 0.42f);
            float lineH = buttonRadius * 0.46f;
            float y = buttonCy[i] - lineH * (labels[i].length - 1) / 2f
                    + text.getTextSize() * 0.35f;
            for (String line : labels[i]) {
                canvas.drawText(line, buttonCx[i], y, text);
                y += lineH;
            }
        }
    }

    private void drawPills(Canvas canvas) {
        drawPill(canvas, startRect, "START", startPointer >= 0);
        drawPill(canvas, selectRect, "SELECT", selectPointer >= 0);
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

    private void drawShot(Canvas canvas) {
        if (shotX < 0) return;
        long age = System.currentTimeMillis() - shotTime;
        if (age > 260) {
            shotX = -1;
            return;
        }
        float r = dp(14f) * (1f - age / 400f) + dp(4f);
        canvas.drawCircle(shotX, shotY, r, shot);
        canvas.drawLine(shotX - r * 1.4f, shotY, shotX + r * 1.4f, shotY, shot);
        canvas.drawLine(shotX, shotY - r * 1.4f, shotX, shotY + r * 1.4f, shot);
        postInvalidateDelayed(40);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        switch (event.getActionMasked()) {
            case MotionEvent.ACTION_DOWN:
            case MotionEvent.ACTION_POINTER_DOWN: {
                int index = event.getActionIndex();
                int id = event.getPointerId(index);
                handleDown(id, event.getX(index), event.getY(index));
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
        float distStick = (float) Math.hypot(x - stickCx, y - stickCy);
        if (stickPointer < 0 && distStick <= stickRadius * 1.6f) {
            stickPointer = id;
            updateStick(x, y);
            return;
        }
        for (int i = 0; i < 4; i++) {
            if (buttonPointer[i] < 0
                    && Math.hypot(x - buttonCx[i], y - buttonCy[i]) <= buttonRadius * 1.25f) {
                buttonPointer[i] = id;
                pad.setButton(i, true);
                return;
            }
        }
        if (startPointer < 0 && startRect.contains(x, y)) {
            startPointer = id;
            pad.setStart(true);
            return;
        }
        if (selectPointer < 0 && selectRect.contains(x, y)) {
            selectPointer = id;
            pad.setSelect(true);
            return;
        }
        if (shootPointer < 0) {
            shootPointer = id;
            fire(x, y);
        }
    }

    private void handleMove(int id, float x, float y) {
        if (id == stickPointer) {
            updateStick(x, y);
        } else if (id == shootPointer) {
            /* dragging while holding the trigger just re-aims the gun */
            aim(x, y);
        }
    }

    private void handleUp(int id) {
        if (id == stickPointer) {
            stickPointer = -1;
            stickDx = stickDy = 0f;
            pad.setStick(0f, 0f);
        }
        for (int i = 0; i < 4; i++) {
            if (buttonPointer[i] == id) {
                buttonPointer[i] = -1;
                pad.setButton(i, false);
            }
        }
        if (startPointer == id) {
            startPointer = -1;
            pad.setStart(false);
        }
        if (selectPointer == id) {
            selectPointer = -1;
            pad.setSelect(false);
        }
        if (shootPointer == id) shootPointer = -1;
    }

    void releaseAll() {
        stickPointer = -1;
        stickDx = stickDy = 0f;
        pad.setStick(0f, 0f);
        for (int i = 0; i < 4; i++) {
            buttonPointer[i] = -1;
            pad.setButton(i, false);
        }
        startPointer = selectPointer = shootPointer = -1;
        pad.setStart(false);
        pad.setSelect(false);
    }

    private void updateStick(float x, float y) {
        float dx = (x - stickCx) / stickRadius;
        float dy = (y - stickCy) / stickRadius;
        float len = (float) Math.hypot(dx, dy);
        if (len > 1f) {
            dx /= len;
            dy /= len;
        }
        stickDx = dx;
        stickDy = dy;
        pad.setStick(dx, dy);
    }

    private void fire(float x, float y) {
        Rect r = gameView.imageRect();
        if (r.width() <= 0 || r.height() <= 0) return;
        int nx = ScreenMap.nesX(x, r.left, r.width());
        int ny = ScreenMap.nesY(y, r.top, r.height());
        pad.shoot(nx, ny);
        shotX = x;
        shotY = y;
        shotTime = System.currentTimeMillis();
    }

    private void aim(float x, float y) {
        Rect r = gameView.imageRect();
        if (r.width() <= 0 || r.height() <= 0) return;
        pad.aim(ScreenMap.nesX(x, r.left, r.width()),
                ScreenMap.nesY(y, r.top, r.height()));
        shotX = x;
        shotY = y;
    }
}
