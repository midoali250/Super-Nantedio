package com.midoali.nes;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.SharedPreferences;
import android.content.Intent;
import com.bitvaultengine.updates.UpdateClient;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.TextView;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public final class MainActivity extends Activity {
    private static final String ROM_ASSET = "mario.nes";

    private Emulator emulator;
    private GameView gameView;
    private TextView status;
    private VirtualPad pad;
    private ControlsView controls;
    private SharedPreferences prefs;
    private boolean settingsOpen;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        hideSystemUi();

        FrameLayout root = new FrameLayout(this);
        root.setBackgroundColor(0xFF000000);

        gameView = new GameView(this);
        root.addView(gameView, new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT));

        pad = new VirtualPad();
        controls = new ControlsView(this, pad, gameView);
        root.addView(controls, new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT));

        prefs = getSharedPreferences("settings", MODE_PRIVATE);
        // Enable all three cheats once when upgrading to v1.1 or installing it.
        // The marker prevents overriding a player's later manual choices.
        if (!prefs.getBoolean("v11_cheats_initialized", false)) {
            prefs.edit().putBoolean("lives", true)
                    .putBoolean("invincible", true)
                    .putBoolean("pit", true)
                    .putBoolean("v11_cheats_initialized", true).apply();
        }
        applySettings();
        Button settings = new Button(this);
        settings.setText("⚙ الإعدادات");
        settings.setAllCaps(false);
        settings.setOnClickListener(v -> showSettings());
        FrameLayout.LayoutParams menuParams = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT,
                Gravity.TOP | Gravity.LEFT);
        root.addView(settings, menuParams);

        status = new TextView(this);
        status.setTextColor(0xFFFFFFFF);
        status.setTextSize(18f);
        status.setGravity(Gravity.CENTER);
        status.setText("Loading…");
        root.addView(status, new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT,
                Gravity.CENTER));

        setContentView(root);
        UpdateClient.schedule(this);
        UpdateClient.requestNotificationPermission(this);
        if (!UpdateClient.consumeNotificationIntent(this, getIntent()))
            UpdateClient.checkInBackground(this);

        final Handler main = new Handler(Looper.getMainLooper());
        new Thread(() -> {
            byte[] rom;
            try {
                rom = readAsset(ROM_ASSET);
            } catch (IOException e) {
                main.post(() -> status.setText("ROM missing: " + e.getMessage()));
                return;
            }
            main.post(() -> {
                status.setVisibility(View.GONE);
                emulator = new Emulator(MainActivity.this, rom, gameView, pad);
                applySettings();
                emulator.start();
            });
        }, "nes-rom-loader").start();
    }


    private void applySettings() {
        controls.setControlScale(prefs.getInt("size", 100) / 100f);
        controls.setAlpha(prefs.getInt("opacity", 75) / 100f);
        gameView.setStretch(prefs.getBoolean("stretch", false));
        if (emulator != null) emulator.setMarioCheats(prefs.getBoolean("lives", false),
                prefs.getBoolean("invincible", false), prefs.getBoolean("pit", false));
    }

    private void showSettings() {
        settingsOpen = true;
        controls.releaseAll();
        if (emulator != null) emulator.setPaused(true);
        LinearLayout box = new LinearLayout(this);
        box.setOrientation(LinearLayout.VERTICAL);
        int padding = (int)(20 * getResources().getDisplayMetrics().density);
        box.setPadding(padding, padding, padding, padding);
        CheckBox lives = new CheckBox(this);
        lives.setText("أرواح غير محدودة لماريو");
        lives.setChecked(prefs.getBoolean("lives", false));
        lives.setOnCheckedChangeListener((v, checked) -> {
            prefs.edit().putBoolean("lives", checked).apply(); applySettings();
        });
        box.addView(lives);
        CheckBox invincible = new CheckBox(this);
        invincible.setText("حماية ماريو من الأعداء (قوة النجمة)");
        invincible.setChecked(prefs.getBoolean("invincible", false));
        invincible.setOnCheckedChangeListener((v, checked) -> {
            prefs.edit().putBoolean("invincible", checked).apply(); applySettings();
        });
        box.addView(invincible);
        CheckBox pit = new CheckBox(this);
        pit.setText("حماية من الحفر: يرجع ينط لما يقع");
        pit.setChecked(prefs.getBoolean("pit", false));
        pit.setOnCheckedChangeListener((v, checked) -> {
            prefs.edit().putBoolean("pit", checked).apply(); applySettings();
        });
        box.addView(pit);
        Button checkUpdate = new Button(this);
        checkUpdate.setText("التحديث");
        checkUpdate.setAllCaps(false);
        checkUpdate.setOnClickListener(v -> UpdateClient.checkNow(this));
        box.addView(checkUpdate);
        CheckBox stretch = new CheckBox(this);
        stretch.setText("ملء عرض الشاشة (الصورة تتمدد بدون قص)");
        stretch.setChecked(prefs.getBoolean("stretch", false));
        stretch.setOnCheckedChangeListener((v, checked) -> {
            prefs.edit().putBoolean("stretch", checked).apply(); applySettings();
        });
        box.addView(stretch);
        addSlider(box, "حجم الأزرار والعصاية", "size", 70, 120, 100);
        addSlider(box, "وضوح الأزرار", "opacity", 25, 100, 75);
        TextView hint = new TextView(this);
        hint.setText("الغش اختياري ولا يوقف عداد الوقت. بعض مخارج السحاب تتطلب السقوط. الصورة الأصلية ٤:٣ بدون قص؛ خيار الملء يمدد الصورة.");
        box.addView(hint);
        ScrollView scroll = new ScrollView(this);
        scroll.addView(box);
        AlertDialog dialog = new AlertDialog.Builder(this).setTitle("إعدادات اللعبة")
                .setView(scroll).setPositiveButton("تم", (d, w) -> {}).create();
        dialog.setOnDismissListener(d -> {
            settingsOpen = false;
            if (emulator != null && hasWindowFocus()) emulator.setPaused(false);
        });
        dialog.show();
    }

    private void addSlider(LinearLayout box, String title, String key, int min, int max, int def) {
        TextView label = new TextView(this);
        box.addView(label);
        SeekBar bar = new SeekBar(this);
        bar.setMax(max - min);
        int initial = Math.max(min, Math.min(max, prefs.getInt(key, def)));
        bar.setProgress(initial - min);
        label.setText(title + "  " + initial + "%");
        bar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            public void onProgressChanged(SeekBar b, int value, boolean fromUser) {
                int actual = value + min;
                label.setText(title + "  " + actual + "%");
                if (fromUser) { prefs.edit().putInt(key, actual).apply(); applySettings(); }
            }
            public void onStartTrackingTouch(SeekBar b) { }
            public void onStopTrackingTouch(SeekBar b) { }
        });
        box.addView(bar);
    }

    private byte[] readAsset(String name) throws IOException {
        try (InputStream in = getAssets().open(name);
             ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            byte[] buf = new byte[64 * 1024];
            int n;
            while ((n = in.read(buf)) > 0) out.write(buf, 0, n);
            return out.toByteArray();
        }
    }

    private void hideSystemUi() {
        getWindow().getDecorView().setSystemUiVisibility(
                View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY
                        | View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                        | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                        | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                        | View.SYSTEM_UI_FLAG_FULLSCREEN);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        UpdateClient.consumeNotificationIntent(this, intent);
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if (hasFocus) { hideSystemUi(); if (!settingsOpen && emulator != null) emulator.setPaused(false); }
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (emulator != null) emulator.setPaused(true);
    }

    @Override
    protected void onResume() {
        super.onResume();
        UpdateClient.resumePendingInstall(this);
        hideSystemUi();
        if (emulator != null && !settingsOpen) emulator.setPaused(false);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (emulator != null) emulator.stop();
    }
}
