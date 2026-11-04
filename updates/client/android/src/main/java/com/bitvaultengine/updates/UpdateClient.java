package com.bitvaultengine.updates;

import android.Manifest;
import android.app.Activity;
import android.app.AlertDialog;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.job.JobInfo;
import android.app.job.JobScheduler;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.widget.Toast;
import org.json.JSONObject;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/** Optional update checks. Each game sets its own game_id in its manifest. */
public final class UpdateClient {
    static final String CHANNEL = "game_updates";
    static final String EXTRA_OPEN = "com.bitvaultengine.updates.OPEN";
    private static final int JOB_ID = 132701;
    private static final int NOTIFICATION_ID = 132702;
    /* The repository a game's release is published under. A game that lives in
     * another account of the project sets com.bitvaultengine.UPDATE_OWNER in
     * its manifest; everything else falls back to the original owner. */
    private static final String DEFAULT_OWNER = "midoali250";
    private static final String REPO = "bitvault-engine";
    private static final ExecutorService IO = Executors.newSingleThreadExecutor();
    private UpdateClient() { }

    private static String gameId(Context c) throws Exception {
        String id = c.getPackageManager().getApplicationInfo(c.getPackageName(),
                PackageManager.GET_META_DATA).metaData.getString("com.bitvaultengine.GAME_ID");
        if (id == null || !id.matches("[a-z0-9]+(?:-[a-z0-9]+)*"))
            throw new IllegalArgumentException("Invalid game ID");
        return id;
    }

    /** GitHub account that hosts this game's manifest and release. */
    private static String owner(Context c) throws Exception {
        String o = c.getPackageManager().getApplicationInfo(c.getPackageName(),
                PackageManager.GET_META_DATA).metaData.getString("com.bitvaultengine.UPDATE_OWNER");
        if (o == null) o = DEFAULT_OWNER;
        if (!o.matches("[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?"))
            throw new IllegalArgumentException("Invalid update owner");
        return o;
    }
    static final class Release {
        String name, notes, apkUrl, apkSha256;
        long code, apkSize;
    }
    static Release fetch(Context context) throws Exception {
        String id = gameId(context);
        String owner = owner(context);
        URL url = new URL("https://raw.githubusercontent.com/" + owner + "/" + REPO +
                "/main/updates/games/" + id + ".json");
        HttpURLConnection c = (HttpURLConnection) url.openConnection();
        c.setConnectTimeout(10000); c.setReadTimeout(10000);
        c.setInstanceFollowRedirects(false);
        c.setRequestProperty("Cache-Control", "no-cache");
        try {
            if (c.getResponseCode() != 200) throw new IllegalStateException("HTTP " + c.getResponseCode());
            ByteArrayOutputStream bytes = new ByteArrayOutputStream();
            try (InputStream in = c.getInputStream()) {
                byte[] buf = new byte[4096]; int n;
                while ((n = in.read(buf)) != -1) {
                    if (bytes.size() + n > 65536) throw new IllegalStateException("Manifest too large");
                    bytes.write(buf, 0, n);
                }
            }
            JSONObject o = new JSONObject(bytes.toString("UTF-8"));
            if (o.getInt("schema_version") != 1 || !id.equals(o.getString("game_id")) ||
                    !context.getPackageName().equals(o.getString("package_name")))
                throw new IllegalStateException("Manifest does not belong to this game");
            if (o.getInt("min_android_sdk") > Build.VERSION.SDK_INT)
                throw new IllegalStateException("Update requires a newer Android version");
            Uri apk = Uri.parse(o.getString("apk_url"));
            String path = apk.getPath();
            if (!"https".equals(apk.getScheme()) || !"github.com".equals(apk.getHost()) ||
                    apk.getPort() != -1 || apk.getUserInfo() != null || apk.getQuery() != null ||
                    path == null || !path.startsWith("/" + owner + "/" + REPO + "/releases/download/") ||
                    !path.endsWith(".apk")) throw new IllegalStateException("Invalid APK URL");
            Release r = new Release();
            r.code = o.getLong("version_code");
            if (r.code <= 0) throw new IllegalStateException("Invalid version");
            r.name = o.getString("version_name");
            r.notes = o.optString("release_notes_ar", "");
            r.apkUrl = apk.toString();
            r.apkSha256 = o.getString("apk_sha256");
            r.apkSize = o.getLong("apk_size_bytes");
            if (!r.apkSha256.matches("[0-9a-f]{64}") || r.apkSize <= 0 || r.apkSize > 500_000_000L)
                throw new IllegalStateException("Invalid APK integrity metadata");
            return r;
        } finally { c.disconnect(); }
    }
    static long installed(Context c) throws Exception {
        android.content.pm.PackageInfo p = c.getPackageManager().getPackageInfo(c.getPackageName(), 0);
        return Build.VERSION.SDK_INT >= 28 ? p.getLongVersionCode() : p.versionCode;
    }
    public static void schedule(Context c) {
        NotificationManager nm = (NotificationManager)c.getSystemService(Context.NOTIFICATION_SERVICE);
        nm.createNotificationChannel(new NotificationChannel(CHANNEL, "تحديثات الألعاب", NotificationManager.IMPORTANCE_DEFAULT));
        JobScheduler scheduler = (JobScheduler)c.getSystemService(Context.JOB_SCHEDULER_SERVICE);
        JobInfo job = new JobInfo.Builder(JOB_ID, new ComponentName(c, UpdateJobService.class))
                .setRequiredNetworkType(JobInfo.NETWORK_TYPE_ANY)
                .setPeriodic(6L * 60 * 60 * 1000).setPersisted(true).build();
        scheduler.schedule(job);
    }
    public static void requestNotificationPermission(Activity activity) {
        if (Build.VERSION.SDK_INT >= 33 && activity.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS)
                != PackageManager.PERMISSION_GRANTED &&
                !activity.getPreferences(Context.MODE_PRIVATE).getBoolean("update_notice_asked", false)) {
            activity.getPreferences(Context.MODE_PRIVATE).edit().putBoolean("update_notice_asked", true).apply();
            activity.requestPermissions(new String[]{Manifest.permission.POST_NOTIFICATIONS}, 1346);
        }
    }
    public static void checkInBackground(Context c) {
        Context app = c.getApplicationContext();
        IO.execute(() -> { try { Release r = fetch(app); if (r.code > installed(app)) notifyUpdate(app, r); } catch (Exception ignored) { } });
    }
    static void notifyUpdate(Context c, Release release) {
        if (Build.VERSION.SDK_INT >= 33 && c.checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) return;
        Intent launch = c.getPackageManager().getLaunchIntentForPackage(c.getPackageName());
        if (launch == null) return;
        launch.putExtra(EXTRA_OPEN, true).addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);
        PendingIntent pending = PendingIntent.getActivity(c, 0, launch, PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        Notification n = new Notification.Builder(c, CHANNEL)
                .setSmallIcon(android.R.drawable.stat_sys_download_done)
                .setContentTitle("تحديث جديد للعبة")
                .setContentText("الإصدار " + release.name + " متاح؛ اضغط لمعرفة التفاصيل")
                .setAutoCancel(true).setContentIntent(pending).build();
        ((NotificationManager)c.getSystemService(Context.NOTIFICATION_SERVICE)).notify(NOTIFICATION_ID, n);
    }
    /** Called by an in-game button or an update-notification tap. */
    public static void checkNow(Activity activity) {
        Toast.makeText(activity, "جاري التحقق من التحديثات…", Toast.LENGTH_SHORT).show();
        IO.execute(() -> {
            try {
                Release r = fetch(activity.getApplicationContext());
                boolean newer = r.code > installed(activity);
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (activity.isFinishing() || activity.isDestroyed()) return;
                    if (!newer) { new AlertDialog.Builder(activity).setTitle("التحديثات")
                            .setMessage("أنت تستخدم أحدث إصدار متاح.").setPositiveButton("تمام", null).show(); return; }
                    new AlertDialog.Builder(activity).setTitle("تحديث اختياري: " + r.name)
                            .setMessage(r.notes + "\n\nالتحميل والتثبيت اختياريان، وسيطلب أندرويد موافقتك.")
                            .setNegativeButton("لاحقًا", null)
                            .setPositiveButton("تحميل التحديث", (dialog, which) -> {
                                InAppUpdater.start(activity, r);
                            }).show();
                });
            } catch (Exception e) {
                new Handler(Looper.getMainLooper()).post(() -> {
                    if (!activity.isFinishing() && !activity.isDestroyed())
                        new AlertDialog.Builder(activity).setTitle("التحديثات")
                                .setMessage("تعذر التحقق الآن. تأكد من اتصال الإنترنت وحاول مرة أخرى.")
                                .setPositiveButton("تمام", null).show();
                });
            }
        });
    }
    public static void resumePendingInstall(Activity activity) {
        InAppUpdater.resumePendingInstall(activity);
    }
    public static boolean consumeNotificationIntent(Activity activity, Intent intent) {
        if (intent == null || !intent.getBooleanExtra(EXTRA_OPEN, false)) return false;
        intent.removeExtra(EXTRA_OPEN);
        checkNow(activity);
        return true;
    }
}
