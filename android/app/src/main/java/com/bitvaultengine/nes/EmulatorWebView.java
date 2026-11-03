package com.bitvaultengine.nes;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.AttributeSet;
import android.view.HapticFeedbackConstants;
import android.view.MotionEvent;
import android.webkit.WebView;

/**
 * A WebView that behaves like a game surface.
 *
 * • Multi-touch is never turned into a scroll or a pinch, so the player can hold
 *   RIGHT with one thumb and tap A with the other.
 * • Long-press selection and context menus are disabled.
 * • Every touch-down gives a short haptic tick, like a real pad.
 */
public class EmulatorWebView extends WebView {

    private long lastHapticAt = 0L;

    public EmulatorWebView(Context context) {
        super(context);
        init();
    }

    public EmulatorWebView(Context context, AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public EmulatorWebView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init();
    }

    @SuppressLint("ClickableViewAccessibility")
    private void init() {
        setFocusable(true);
        setFocusableInTouchMode(true);
        setHapticFeedbackEnabled(true);
        setLongClickable(false);
        setOnLongClickListener(v -> true);
        setVerticalScrollBarEnabled(false);
        setHorizontalScrollBarEnabled(false);
        setOverScrollMode(OVER_SCROLL_NEVER);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        switch (event.getActionMasked()) {
            case MotionEvent.ACTION_DOWN:
            case MotionEvent.ACTION_POINTER_DOWN:
                maybeHaptic();
                break;
            default:
                break;
        }
        return super.onTouchEvent(event);
    }

    private void maybeHaptic() {
        long now = System.currentTimeMillis();
        if (now - lastHapticAt < 45) return;   // no buzzing during fast taps
        lastHapticAt = now;
        try {
            performHapticFeedback(HapticFeedbackConstants.VIRTUAL_KEY);
        } catch (Throwable ignored) {
            // emulators and some devices have no vibrator
        }
    }
}
