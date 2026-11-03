package com.bitvaultengine.nes;

import android.app.Activity;
import android.content.ContentValues;
import android.content.Context;
import android.content.pm.ActivityInfo;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.webkit.ConsoleMessage;
import android.webkit.JavascriptInterface;
import android.webkit.RenderProcessGoneDetail;
import android.webkit.WebChromeClient;
import android.webkit.WebResourceRequest;
import android.webkit.WebResourceResponse;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.FrameLayout;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

/**
 * bitvaultengine — the single Activity of the app.
 *
 * The emulator + UI live in HTML5/WASM under assets/ (identical to the
 * emulator/www/ tree in the repo, which is what the automated test-suite
 * exercises). This class is a thin, hardened host:
 *
 *   • assets are served from a secure asset origin (an https:// URL that this
 *     WebViewClient answers from the APK itself), so fetch(), WebAssembly,
 *     AudioContext and localStorage all work. The previous build loaded
 *     file:///android_asset/emulator.html, where fetch() is blocked — that is
 *     exactly why the ROM never loaded and the app stayed on a black screen.
 *   • every request outside that origin is refused: the game is fully offline.
 *   • save states and screenshots are bridged to Android storage.
 */
public class MainActivity extends Activity {

    private static final String TAG = "bitvaultengine";

    /** Virtual https origin that maps onto the APK's assets/ folder. */
    static final String ASSET_HOST = "appassets.androidplatform.net";
    static final String START_URL = "https://" + ASSET_HOST + "/assets/index.html";

    private static final String PREFS = "bitvaultengine";
    private static final String STATE_KEY = "save_state_b64";

    private EmulatorWebView webView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
            getWindow().getAttributes().layoutInDisplayCutoutMode =
                    WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
        }
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR_LANDSCAPE);

        FrameLayout root = new FrameLayout(this);
        root.setBackgroundColor(Color.BLACK);
        root.setLayoutParams(new ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));

        webView = new EmulatorWebView(this);
        webView.setLayoutParams(new FrameLayout.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        webView.setBackgroundColor(Color.BLACK);
        root.addView(webView);
        setContentView(root);

        configureWebView();
        hideSystemUi();
        webView.loadUrl(START_URL);
    }

    /* ---------------------------------------------------------------- WebView */

    @SuppressWarnings("SetJavaScriptEnabled")
    private void configureWebView() {
        WebSettings s = webView.getSettings();
        s.setJavaScriptEnabled(true);
        s.setDomStorageEnabled(true);
        s.setAllowFileAccess(false);          // assets are served over the virtual origin
        s.setAllowContentAccess(false);
        s.setMediaPlaybackRequiresUserGesture(false);
        s.setLoadWithOverviewMode(true);
        s.setUseWideViewPort(true);
        s.setTextZoom(100);
        s.setSupportZoom(false);
        s.setBuiltInZoomControls(false);
        s.setDisplayZoomControls(false);
        s.setCacheMode(WebSettings.LOAD_DEFAULT);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            s.setMixedContentMode(WebSettings.MIXED_CONTENT_NEVER_ALLOW);
        }

        webView.addJavascriptInterface(new Bridge(), "AndroidBridge");

        webView.setWebChromeClient(new WebChromeClient() {
            @Override
            public boolean onConsoleMessage(ConsoleMessage msg) {
                Log.d(TAG, "JS " + msg.lineNumber() + ": " + msg.message());
                return true;
            }
        });

        webView.setWebViewClient(new WebViewClient() {
            @Override
            public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {
                Uri uri = request.getUrl();
                if (uri == null || !ASSET_HOST.equals(uri.getHost())) return blocked();
                return serveAsset(uri);
            }

            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                return true;    // never navigate away from the game
            }

            @Override
            public void onPageFinished(WebView view, String url) {
                Log.i(TAG, "loaded " + url);
                diagnostics();
            }

            @Override
            public boolean onRenderProcessGone(WebView view, RenderProcessGoneDetail detail) {
                Log.e(TAG, "WebView renderer died, recreating");
                recreate();
                return true;
            }
        });
    }

    private WebResourceResponse blocked() {
        return new WebResourceResponse("text/plain", "utf-8",
                new ByteArrayInputStream(new byte[0]));
    }

    /** https://appassets.androidplatform.net/assets/&lt;path&gt;  →  assets/&lt;path&gt; */
    private WebResourceResponse serveAsset(Uri uri) {
        String path = uri.getPath();
        if (path == null) return blocked();
        if (path.startsWith("/assets/")) path = path.substring("/assets/".length());
        else if (path.startsWith("/")) path = path.substring(1);

        String mime;
        if (path.endsWith(".html")) mime = "text/html";
        else if (path.endsWith(".js")) mime = "application/javascript";
        else if (path.endsWith(".css")) mime = "text/css";
        else if (path.endsWith(".wasm")) mime = "application/wasm";
        else if (path.endsWith(".png")) mime = "image/png";
        else mime = "application/octet-stream";

        try {
            InputStream in = getAssets().open(path);
            Map<String, String> headers = new HashMap<>();
            headers.put("Cache-Control", "no-store");
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                return new WebResourceResponse(mime, "utf-8", 200, "OK", headers, in);
            }
            return new WebResourceResponse(mime, "utf-8", in);
        } catch (IOException e) {
            Log.e(TAG, "missing asset " + path);
            return blocked();
        }
    }

    private void diagnostics() {
        webView.evaluateJavascript(
                "(function(){try{var a=window.SNESApp;return JSON.stringify({"
                        + "app:!!a,status:a?a.status():null,frames:a?a.frameCount():0,"
                        + "error:a?a.error():null});}catch(e){return JSON.stringify({error:String(e)});}})()",
                value -> Log.i(TAG, "diagnostics " + value));
    }

    /* ----------------------------------------------------------------- bridge */

    /** Exposed to JavaScript as window.AndroidBridge. */
    public class Bridge {

        @JavascriptInterface
        public void saveState(String base64State) {
            getSharedPreferences(PREFS, Context.MODE_PRIVATE)
                    .edit().putString(STATE_KEY, base64State).apply();
        }

        @JavascriptInterface
        public String loadState() {
            return getSharedPreferences(PREFS, Context.MODE_PRIVATE).getString(STATE_KEY, null);
        }

        @JavascriptInterface
        public void saveScreenshot(String dataUrl) {
            try {
                byte[] png = android.util.Base64.decode(
                        dataUrl.substring(dataUrl.indexOf(',') + 1), android.util.Base64.DEFAULT);
                String name = "bitvaultengine-" + System.currentTimeMillis() + ".png";
                OutputStream out = null;
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    ContentValues values = new ContentValues();
                    values.put(MediaStore.Images.Media.DISPLAY_NAME, name);
                    values.put(MediaStore.Images.Media.MIME_TYPE, "image/png");
                    values.put(MediaStore.Images.Media.RELATIVE_PATH,
                            Environment.DIRECTORY_PICTURES + "/bitvaultengine");
                    Uri uri = getContentResolver()
                            .insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values);
                    if (uri != null) out = getContentResolver().openOutputStream(uri);
                }
                if (out == null) {
                    File dir = new File(getExternalFilesDir(Environment.DIRECTORY_PICTURES),
                            "bitvaultengine");
                    if (!dir.exists() && !dir.mkdirs()) return;
                    out = new FileOutputStream(new File(dir, name));
                }
                out.write(png);
                out.close();
                Log.i(TAG, "screenshot saved " + name);
            } catch (Exception e) {
                Log.e(TAG, "screenshot failed", e);
            }
        }

        @JavascriptInterface
        public void vibrate(int millis) {
            try {
                android.os.Vibrator v =
                        (android.os.Vibrator) getSystemService(Context.VIBRATOR_SERVICE);
                if (v != null) v.vibrate(millis);
            } catch (Exception ignored) { }
        }

        @JavascriptInterface
        public String appVersion() {
            try {
                return getPackageManager().getPackageInfo(getPackageName(), 0).versionName;
            } catch (Exception e) {
                return "2.0";
            }
        }
    }

    /* -------------------------------------------------------------- lifecycle */

    private void hideSystemUi() {
        getWindow().getDecorView().setSystemUiVisibility(
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                        | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                        | View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_HIDE_NAVIGATION
                        | View.SYSTEM_UI_FLAG_FULLSCREEN
                        | View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY);
    }

    @Override
    public void onWindowFocusChanged(boolean hasFocus) {
        super.onWindowFocusChanged(hasFocus);
        if (hasFocus) hideSystemUi();
    }

    @Override
    protected void onPause() {
        super.onPause();
        if (webView != null) webView.onPause();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (webView != null) {
            webView.onResume();
            hideSystemUi();
        }
    }

    @Override
    public void onBackPressed() {
        // Back pauses instead of killing the game.
        if (webView != null) {
            webView.evaluateJavascript(
                    "window.SNESApp&&window.SNESApp.releaseAll&&window.SNESApp.releaseAll();", null);
        }
        moveTaskToBack(true);
    }

    @Override
    protected void onDestroy() {
        if (webView != null) {
            webView.loadUrl("about:blank");
            webView.destroy();
            webView = null;
        }
        super.onDestroy();
    }
}
