package com.midoali.snes;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Typeface;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.style.StyleSpan;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.ScrollView;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;

import com.bitvaultengine.updates.UpdateClient;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

public final class MainActivity extends Activity {
    private static final String ROM_ASSET = "sunsetriders.bin";

    public static final String ABOUT_RAW_MARKDOWN =
            "This application has been developed by **Ahmed Kamal Elgandy** to serve as a digital archive and platform for running and optimizing classic retro and Atari-style games on mobile devices. The project aims to revive memories and preserve the software heritage of classic games with a smooth, lightweight experience, while fully respecting the intellectual property rights of the original production companies.";

    public static final String ABOUT_PLAIN_TEXT =
            "This application has been developed by Ahmed Kamal Elgandy to serve as a digital archive and platform for running and optimizing classic retro and Atari-style games on mobile devices. The project aims to revive memories and preserve the software heritage of classic games with a smooth, lightweight experience, while fully respecting the intellectual property rights of the original production companies.";

    private static final int[] CHEAT_FLAGS = {
            SnesCore.CHEAT_INF_LIVES,
            SnesCore.CHEAT_INVINCIBLE,
            SnesCore.CHEAT_MAX_FIREPOWER,
            SnesCore.CHEAT_INF_CREDITS,
            SnesCore.CHEAT_ONE_HIT_BOSS,
            SnesCore.CHEAT_INF_LIVES_P2,
    };

    private static final String[] CHEAT_LABELS = {
            "أرواح لا نهائية - 9 أرواح (Infinite Lives P1)",
            "عدم التأثر بالرصاص والأعداء (Invincibility / Untouchable)",
            "أقصى قوة سلاح: مسدسين + طلقات سريعة (2X Guns + Rapid Fire)",
            "محاولات لا نهائية - 9 محاولات (Infinite Credits)",
            "قتل الزعماء والبراميل بطلقة واحدة (1-Hit Kill Bosses)",
            "أرواح لا نهائية للاعب الثاني (Infinite Lives P2)",
    };

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
        controls = new ControlsView(this, pad);
        root.addView(controls, new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.MATCH_PARENT));

        prefs = getSharedPreferences("settings", MODE_PRIVATE);
        applySettings();

        LinearLayout topMenuBar = new LinearLayout(this);
        topMenuBar.setOrientation(LinearLayout.HORIZONTAL);
        Button settings = new Button(this);
        settings.setText("⚙ الضبط");
        settings.setAllCaps(false);
        settings.setOnClickListener(v -> showSettings());
        topMenuBar.addView(settings);

        Button cheatsQuick = new Button(this);
        cheatsQuick.setText("🎮 الغش");
        cheatsQuick.setAllCaps(false);
        cheatsQuick.setOnClickListener(v -> showCheatsDialog());
        topMenuBar.addView(cheatsQuick);

        Button aboutQuick = new Button(this);
        aboutQuick.setText("About");
        aboutQuick.setAllCaps(false);
        aboutQuick.setOnClickListener(v -> showAboutDialog());
        topMenuBar.addView(aboutQuick);

        FrameLayout.LayoutParams menuParams = new FrameLayout.LayoutParams(
                FrameLayout.LayoutParams.WRAP_CONTENT, FrameLayout.LayoutParams.WRAP_CONTENT,
                Gravity.TOP | Gravity.LEFT);
        root.addView(topMenuBar, menuParams);

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
        }, "snes-rom-loader").start();
    }

    private void applySettings() {
        controls.setControlScale(prefs.getInt("size", 100) / 100f);
        controls.setAlpha(prefs.getInt("opacity", 75) / 100f);
        controls.setFreeStick(prefs.getBoolean("free_stick", true));
        gameView.setStretch(prefs.getBoolean("stretch", true));
        int vf = prefs.getInt("video_filter", SnesCore.VIDEO_FILTER_HD_CRISP);
        gameView.setSmoothFilter(vf != SnesCore.VIDEO_FILTER_RAW_PIXEL);
        if (emulator != null) {
            emulator.setCheats(prefs.getInt("cheats", 0));
            emulator.setVideoFilter(vf);
        }
    }

    private void showSettings() {
        settingsOpen = true;
        controls.releaseAll();
        if (emulator != null) emulator.setPaused(true);
        LinearLayout box = new LinearLayout(this);
        box.setOrientation(LinearLayout.VERTICAL);
        int padding = (int) (20 * getResources().getDisplayMetrics().density);
        box.setPadding(padding, padding, padding, padding);

        TextView vfTitle = new TextView(this);
        vfTitle.setText("جودة الصورة (HD Video Quality):");
        vfTitle.setTypeface(Typeface.DEFAULT_BOLD);
        box.addView(vfTitle);

        RadioGroup vfGroup = new RadioGroup(this);
        String[] vfLabels = {
                "فائق الوضوح HD Crisp (2x Scale2x + تنعيم الألوان)",
                "ناعم فائق السلاسة Ultra Smooth (2x Bilinear)",
                "بيكسل أصلي حاد Raw Pixel (1x)",
        };
        int currentVf = prefs.getInt("video_filter", SnesCore.VIDEO_FILTER_HD_CRISP);
        for (int i = 0; i < vfLabels.length; i++) {
            final int mode = i;
            RadioButton rb = new RadioButton(this);
            rb.setId(1000 + i);
            rb.setText(vfLabels[i]);
            rb.setChecked(currentVf == i);
            rb.setOnClickListener(v -> {
                prefs.edit().putInt("video_filter", mode).apply();
                applySettings();
            });
            vfGroup.addView(rb);
        }
        box.addView(vfGroup);

        CheckBox stretch = new CheckBox(this);
        stretch.setText("شاشة عريضة بعرض شاشة الموبايل (Widescreen)");
        stretch.setChecked(prefs.getBoolean("stretch", true));
        stretch.setOnCheckedChangeListener((v, checked) -> {
            prefs.edit().putBoolean("stretch", checked).apply();
            applySettings();
        });
        box.addView(stretch);

        CheckBox freeStick = new CheckBox(this);
        freeStick.setText("عصاية تحكم حرة الحركة 360° (Free-Floating Joystick)");
        freeStick.setChecked(prefs.getBoolean("free_stick", true));
        freeStick.setOnCheckedChangeListener((v, checked) -> {
            prefs.edit().putBoolean("free_stick", checked).apply();
            applySettings();
        });
        box.addView(freeStick);

        Button cheatsBtn = new Button(this);
        cheatsBtn.setText("🎮 أكواد الغش (Cheats)");
        cheatsBtn.setAllCaps(false);
        cheatsBtn.setOnClickListener(v -> showCheatsDialog());
        box.addView(cheatsBtn);

        Button checkUpdate = new Button(this);
        checkUpdate.setText("التحديث");
        checkUpdate.setAllCaps(false);
        checkUpdate.setOnClickListener(v -> UpdateClient.checkNow(this));
        box.addView(checkUpdate);

        Button aboutBtn = new Button(this);
        aboutBtn.setText("About");
        aboutBtn.setAllCaps(false);
        aboutBtn.setOnClickListener(v -> showAboutDialog());
        box.addView(aboutBtn);

        addSlider(box, "حجم الأزرار والعصاية", "size", 70, 120, 100);
        addSlider(box, "وضوح الأزرار", "opacity", 25, 100, 75);

        TextView hint = new TextView(this);
        hint.setText("رعاة البقر (Sunset Riders) — جودة صورة HD مضاعفة (Scale2x) + عصاية تحكم حرة 360° + شاشة عريضة + أكواد غش مدمجة.");
        box.addView(hint);

        ScrollView scroll = new ScrollView(this);
        scroll.addView(box);
        AlertDialog dialog = new AlertDialog.Builder(this).setTitle("الضبط والإعدادات — رعاة البقر")
                .setView(scroll).setPositiveButton("تم", (d, w) -> {}).create();
        dialog.setOnDismissListener(d -> {
            settingsOpen = false;
            if (emulator != null && hasWindowFocus()) emulator.setPaused(false);
        });
        dialog.show();
    }

    private void showCheatsDialog() {
        settingsOpen = true;
        controls.releaseAll();
        if (emulator != null) emulator.setPaused(true);

        LinearLayout box = new LinearLayout(this);
        box.setOrientation(LinearLayout.VERTICAL);
        int padding = (int) (18 * getResources().getDisplayMetrics().density);
        box.setPadding(padding, padding, padding, padding);

        final CheckBox[] boxes = new CheckBox[CHEAT_FLAGS.length];
        int currentMask = prefs.getInt("cheats", 0);

        for (int i = 0; i < CHEAT_FLAGS.length; i++) {
            final int flag = CHEAT_FLAGS[i];
            CheckBox cb = new CheckBox(this);
            cb.setText(CHEAT_LABELS[i]);
            cb.setChecked((currentMask & flag) != 0);
            cb.setOnCheckedChangeListener((v, checked) -> {
                int m = prefs.getInt("cheats", 0);
                if (checked) m |= flag;
                else m &= ~flag;
                prefs.edit().putInt("cheats", m).apply();
                applySettings();
            });
            boxes[i] = cb;
            box.addView(cb);
        }

        LinearLayout actions = new LinearLayout(this);
        actions.setOrientation(LinearLayout.HORIZONTAL);
        Button enableAll = new Button(this);
        enableAll.setText("تفعيل الكل");
        enableAll.setAllCaps(false);
        enableAll.setOnClickListener(v -> {
            prefs.edit().putInt("cheats", SnesCore.CHEAT_ALL).apply();
            for (CheckBox cb : boxes) cb.setChecked(true);
            applySettings();
        });
        actions.addView(enableAll);

        Button disableAll = new Button(this);
        disableAll.setText("إيقاف الكل");
        disableAll.setAllCaps(false);
        disableAll.setOnClickListener(v -> {
            prefs.edit().putInt("cheats", 0).apply();
            for (CheckBox cb : boxes) cb.setChecked(false);
            if (emulator != null) emulator.applyCheatCode(0, false, null);
            applySettings();
        });
        actions.addView(disableAll);
        box.addView(actions);

        TextView customLabel = new TextView(this);
        customLabel.setText("إدخال كود Game Genie (XXXX-XXXX) أو Action Replay (FFXXXX:YYYY):");
        box.addView(customLabel);

        final EditText customCode = new EditText(this);
        customCode.setHint("مثال: REFA-C6VL أو FFB098:0009");
        customCode.setSingleLine(true);
        customCode.setText(prefs.getString("custom_cheat", ""));
        box.addView(customCode);

        Button applyCodeBtn = new Button(this);
        applyCodeBtn.setText("تطبيق الكود المخصص");
        applyCodeBtn.setAllCaps(false);
        applyCodeBtn.setOnClickListener(v -> {
            String code = customCode.getText().toString().trim().toUpperCase();
            prefs.edit().putString("custom_cheat", code).apply();
            if (emulator != null && !code.isEmpty()) {
                emulator.applyCheatCode(0, true, code);
                Toast.makeText(this, "تم تفعيل الكود: " + code, Toast.LENGTH_SHORT).show();
            }
        });
        box.addView(applyCodeBtn);

        ScrollView scroll = new ScrollView(this);
        scroll.addView(box);
        AlertDialog dialog = new AlertDialog.Builder(this)
                .setTitle("🎮 أكواد الغش — رعاة البقر")
                .setView(scroll)
                .setPositiveButton("عودة للعبة", (d, w) -> {})
                .create();
        dialog.setOnDismissListener(d -> {
            settingsOpen = false;
            if (emulator != null && hasWindowFocus()) emulator.setPaused(false);
        });
        dialog.show();
    }

    private void showAboutDialog() {
        settingsOpen = true;
        controls.releaseAll();
        if (emulator != null) emulator.setPaused(true);

        LinearLayout box = new LinearLayout(this);
        box.setOrientation(LinearLayout.VERTICAL);
        int padding = (int) (22 * getResources().getDisplayMetrics().density);
        box.setPadding(padding, padding, padding, padding);

        TextView body = new TextView(this);
        body.setTextSize(16f);
        SpannableString span = new SpannableString(ABOUT_PLAIN_TEXT);
        int nameIdx = ABOUT_PLAIN_TEXT.indexOf("Ahmed Kamal Elgandy");
        if (nameIdx >= 0) {
            span.setSpan(new StyleSpan(Typeface.BOLD),
                    nameIdx, nameIdx + "Ahmed Kamal Elgandy".length(),
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
        }
        body.setText(span);
        box.addView(body);

        ScrollView scroll = new ScrollView(this);
        scroll.addView(box);
        AlertDialog dialog = new AlertDialog.Builder(this)
                .setTitle("About")
                .setView(scroll)
                .setPositiveButton("OK", (d, w) -> {})
                .create();
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
                        | View.SYSTEM_UI_FLAG_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                        | View.SYSTEM_UI_FLAG_FULLSCREEN);
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
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        UpdateClient.consumeNotificationIntent(this, intent);
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
