package com.bitvaultengine.nes;

import android.os.Bundle;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.webkit.WebSettings;
import android.webkit.JavascriptInterface;
import android.widget.Button;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {

    private WebView webView;
    private TextView statusText;
    private boolean romLoaded = false;

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
        webSettings.setAllowUniversalAccessFromFileURLs(true);
        webSettings.setCacheMode(WebSettings.LOAD_NO_CACHE);

        webView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                return false;
            }
        });

        webView.addJavascriptInterface(new NESInterface(), "NES");

        // Load the emulator HTML from assets
        webView.loadUrl("file:///android_asset/emulator.html");

        // Button listeners
        Button btnLoad = findViewById(R.id.btn_load);
        Button btnPlay = findViewById(R.id.btn_play);
        Button btnPause = findViewById(R.id.btn_pause);
        Button btnReset = findViewById(R.id.btn_reset);

        btnLoad.setOnClickListener(v -> loadROM());
        btnPlay.setOnClickListener(v -> webView.loadUrl("javascript:nesPlay()"));
        btnPause.setOnClickListener(v -> webView.loadUrl("javascript:nesPause()"));
        btnReset.setOnClickListener(v -> webView.loadUrl("javascript:nesReset()"));
    }

    private void loadROM() {
        if (!romLoaded) {
            // The ROM is pre-loaded in assets via emulator.html
            romLoaded = true;
            statusText.setText(getString(R.string.rom_loaded));
            webView.loadUrl("javascript:nesLoadROM()");
        }
    }

    private class NESInterface {
        @JavascriptInterface
        public void onStatus(String status) {
            runOnUiThread(() -> statusText.setText(status));
        }

        @JavascriptInterface
        public void onROMLoaded(boolean success) {
            romLoaded = success;
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
