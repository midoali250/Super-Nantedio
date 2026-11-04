package com.bitvaultengine.nes;

import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebSettings;
import android.webkit.JavascriptInterface;
import android.widget.Button;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import java.io.InputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import android.util.Base64;

public class MainActivity extends AppCompatActivity {

    private WebView webView;
    private TextView statusText;
    private String romBase64 = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        webView = findViewById(R.id.nes_webview);
        statusText = findViewById(R.id.status_text);

        WebSettings webSettings = webView.getSettings();
        webSettings.setJavaScriptEnabled(true);
        webSettings.setDomStorageEnabled(true);
        webSettings.setAllowFileAccessFromFileURLs(true);
        webSettings.setAllowUniversalAccessFromFileURLs(false);
        webSettings.setCacheMode(WebSettings.LOAD_NO_CACHE);
        webSettings.setAllowContentAccess(true);

        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                return false;
            }
        });

        webView.addJavascriptInterface(new NESInterface(), "NES");

        // Load ROM from assets into base64
        loadROMFromAssets();

        // Load the emulator HTML from assets
        webView.loadUrl("file:///android_asset/emulator.html");

        // Button listeners
        Button btnLoad = findViewById(R.id.btn_load);
        Button btnPlay = findViewById(R.id.btn_play);
        Button btnPause = findViewById(R.id.btn_pause);
        Button btnReset = findViewById(R.id.btn_reset);

        btnLoad.setOnClickListener(v -> {
            statusText.setText(getString(R.string.rom_loaded));
            webView.loadUrl("javascript:nesLoadROM()");
        });
        btnPlay.setOnClickListener(v -> webView.loadUrl("javascript:nesPlay()"));
        btnPause.setOnClickListener(v -> webView.loadUrl("javascript:nesPause()"));
        btnReset.setOnClickListener(v -> webView.loadUrl("javascript:nesReset()"));
    }

    private void loadROMFromAssets() {
        try {
            byte[] romBytes;
            try (InputStream is = getAssets().open("mario.nes");
                 ByteArrayOutputStream out = new ByteArrayOutputStream()) {
                byte[] buffer = new byte[8192];
                int n;
                while ((n = is.read(buffer)) != -1) out.write(buffer, 0, n);
                romBytes = out.toByteArray();
            }
            romBase64 = Base64.encodeToString(romBytes, Base64.NO_WRAP);
            statusText.setText("تم تحميل الروم من الأصول - Super Mario Bros.");
        } catch (IOException e) {
            e.printStackTrace();
            statusText.setText("فشل في قراءة الروم من الأصول");
        }
    }

    public class NESInterface {
        @JavascriptInterface
        public void onStatus(String status) {
            runOnUiThread(() -> statusText.setText(status));
        }

        @JavascriptInterface
        public String getROMBase64() {
            return romBase64;
        }

        @JavascriptInterface
        public void onROMLoaded(boolean success) {
            romBase64 = null; // free memory after loading
            runOnUiThread(() -> {
                if (success) {
                    statusText.setText(getString(R.string.rom_loaded));
                } else {
                    statusText.setText(getString(R.string.rom_error));
                }
            });
        }
    }
}
