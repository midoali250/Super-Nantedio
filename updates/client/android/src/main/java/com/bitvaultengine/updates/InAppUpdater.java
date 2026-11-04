package com.bitvaultengine.updates;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;
import android.widget.Toast;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;

/** User-initiated download: verify exact size, SHA-256, package and signer. */
final class InAppUpdater {
    private static final String PREF = "update_install_state";
    private static final String PENDING = "pending_unknown_sources";
    private InAppUpdater() { }
    static File apkFile(Activity a) { return new File(new File(a.getFilesDir(), "updates"), "download.apk"); }
    private static boolean alive(Activity a) { return !a.isFinishing() && !a.isDestroyed(); }
    static void start(Activity a, UpdateClient.Release release) {
        ProgressDialog progress = new ProgressDialog(a);
        progress.setTitle("تنزيل التحديث");
        progress.setMessage("جاري تنزيل الإصدار " + release.name);
        progress.setProgressStyle(ProgressDialog.STYLE_HORIZONTAL);
        progress.setMax(100); progress.setProgress(0); progress.setCancelable(false);
        AtomicBoolean canceled = new AtomicBoolean(false);
        progress.setButton(ProgressDialog.BUTTON_NEGATIVE, "إلغاء", (d, w) -> canceled.set(true));
        progress.show();
        Handler main = new Handler(Looper.getMainLooper());
        new Thread(() -> {
            File target = apkFile(a);
            File part = new File(target.getParentFile(), "download-part.apk");
            try {
                if (!target.getParentFile().exists() && !target.getParentFile().mkdirs()) throw new Exception("directory");
                download(release, part, canceled, p -> main.post(() -> {
                    if (alive(a) && progress.isShowing()) progress.setProgress(p);
                }));
                if (canceled.get()) return;
                verifyApk(a, part, release.code);
                if (target.exists() && !target.delete()) throw new Exception("old file");
                if (!part.renameTo(target)) throw new Exception("file move");
                main.post(() -> {
                    if (!alive(a)) return;
                    if (progress.isShowing()) progress.dismiss();
                    ready(a);
                });
            } catch (Exception e) {
                part.delete();
                main.post(() -> {
                    if (!alive(a)) return;
                    if (progress.isShowing()) progress.dismiss();
                    if (!canceled.get()) new AlertDialog.Builder(a).setTitle("تعذر تنزيل التحديث")
                            .setMessage("حصلت مشكلة في الاتصال أو التحقق من الملف. حاول مرة أخرى.")
                            .setPositiveButton("تمام", null).show();
                });
            }
        }, "game-update-download").start();
    }
    interface Progress { void onProgress(int p); }
    private static void download(UpdateClient.Release r, File part, AtomicBoolean canceled, Progress progress) throws Exception {
        URL url = new URL(r.apkUrl);
        HttpURLConnection c = null;
        try {
            for (int redirects = 0; redirects < 6; redirects++) {
                String host = url.getHost();
                if (!"https".equalsIgnoreCase(url.getProtocol()) || url.getUserInfo() != null ||
                    url.getPort() != -1 || !("github.com".equalsIgnoreCase(host) ||
                    "release-assets.githubusercontent.com".equalsIgnoreCase(host))) throw new Exception("unsafe URL");
                c = (HttpURLConnection)url.openConnection();
                c.setConnectTimeout(15000); c.setReadTimeout(20000); c.setInstanceFollowRedirects(false);
                c.setRequestProperty("User-Agent", "bitvaultengine-Android-Updater/1");
                int status = c.getResponseCode();
                if (status == 301 || status == 302 || status == 303 || status == 307 || status == 308) {
                    String location = c.getHeaderField("Location");
                    if (location == null) throw new Exception("bad redirect");
                    url = new URL(url, location); c.disconnect(); c = null; continue;
                }
                if (status != 200) throw new Exception("HTTP " + status);
                MessageDigest hash = MessageDigest.getInstance("SHA-256");
                long size = 0;
                try (InputStream in = c.getInputStream(); FileOutputStream out = new FileOutputStream(part)) {
                    byte[] buffer = new byte[65536]; int n;
                    while ((n = in.read(buffer)) != -1) {
                        if (canceled.get()) throw new Exception("canceled");
                        size += n;
                        if (size > r.apkSize) throw new Exception("file too large");
                        hash.update(buffer, 0, n); out.write(buffer, 0, n);
                        progress.onProgress((int)(size * 100 / r.apkSize));
                    }
                }
                StringBuilder hex = new StringBuilder();
                for (byte b : hash.digest()) hex.append(String.format(java.util.Locale.ROOT, "%02x", b & 255));
                if (size != r.apkSize || !hex.toString().equals(r.apkSha256)) throw new Exception("checksum");
                return;
            }
            throw new Exception("too many redirects");
        } finally { if (c != null) c.disconnect(); }
    }
    private static Set<String> signers(PackageInfo p) {
        Signature[] signatures = Build.VERSION.SDK_INT >= 28 ?
                (p.signingInfo == null ? null : p.signingInfo.getApkContentsSigners()) : p.signatures;
        if (signatures == null || signatures.length == 0) throw new IllegalStateException("no signer");
        Set<String> result = new HashSet<>();
        for (Signature s : signatures) result.add(Arrays.toString(s.toByteArray()));
        return result;
    }
    private static void verifyApk(Activity a, File apk, long expectedCode) throws Exception {
        PackageManager pm = a.getPackageManager();
        int flags = Build.VERSION.SDK_INT >= 28 ? PackageManager.GET_SIGNING_CERTIFICATES : PackageManager.GET_SIGNATURES;
        PackageInfo archive = pm.getPackageArchiveInfo(apk.getAbsolutePath(), flags);
        PackageInfo current = pm.getPackageInfo(a.getPackageName(), flags);
        if (archive == null || !a.getPackageName().equals(archive.packageName)) throw new Exception("wrong package");
        long code = Build.VERSION.SDK_INT >= 28 ? archive.getLongVersionCode() : archive.versionCode;
        if (code != expectedCode || code <= UpdateClient.installed(a)) throw new Exception("wrong version");
        if (!signers(archive).equals(signers(current))) throw new Exception("signer mismatch");
    }
    private static void ready(Activity a) {
        new AlertDialog.Builder(a).setTitle("اكتمل تنزيل التحديث")
                .setMessage("الملف جاهز. اضغط تثبيت، ثم وافق في شاشة أندرويد.")
                .setNegativeButton("لاحقًا", null).setPositiveButton("تثبيت", (d,w) -> install(a)).show();
    }
    private static void install(Activity a) {
        if (!apkFile(a).isFile()) { Toast.makeText(a,"الملف غير موجود؛ أعد تنزيله",Toast.LENGTH_LONG).show(); return; }
        if (Build.VERSION.SDK_INT >= 26 && !a.getPackageManager().canRequestPackageInstalls()) {
            new AlertDialog.Builder(a).setTitle("السماح بتثبيت التحديث")
                .setMessage("أندرويد يحتاج إذنك لتثبيت تطبيقات من هذه اللعبة. بعد السماح ارجع للعبة لإكمال التثبيت.")
                .setNegativeButton("إلغاء", null).setPositiveButton("فتح الإعدادات", (d,w) -> {
                    try {
                        a.getSharedPreferences(PREF, 0).edit().putBoolean(PENDING,true).apply();
                        a.startActivity(new Intent(Settings.ACTION_MANAGE_UNKNOWN_APP_SOURCES, Uri.parse("package:"+a.getPackageName())));
                    } catch (Exception e) {
                        a.getSharedPreferences(PREF, 0).edit().putBoolean(PENDING,false).apply();
                        Toast.makeText(a,"تعذر فتح إعدادات التثبيت",Toast.LENGTH_LONG).show();
                    }
                }).show();
            return;
        }
        Uri uri = Uri.parse("content://" + a.getPackageName() + ".updatefiles/download.apk");
        Intent intent = new Intent(Intent.ACTION_VIEW).setDataAndType(uri, "application/vnd.android.package-archive")
                .addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION);
        try { a.startActivity(intent); }
        catch (Exception e) { Toast.makeText(a,"تعذر فتح مُثبّت أندرويد",Toast.LENGTH_LONG).show(); }
    }
    static void resumePendingInstall(Activity a) {
        if (!a.getSharedPreferences(PREF,0).getBoolean(PENDING,false)) return;
        a.getSharedPreferences(PREF,0).edit().putBoolean(PENDING,false).apply();
        if (a.getPackageManager().canRequestPackageInstalls() && apkFile(a).isFile()) ready(a);
        else Toast.makeText(a,"لم يُمنح إذن التثبيت؛ التحديث لم يُثبّت",Toast.LENGTH_LONG).show();
    }
}
