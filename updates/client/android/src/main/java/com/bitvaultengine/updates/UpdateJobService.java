package com.bitvaultengine.updates;

import android.app.job.JobParameters;
import android.app.job.JobService;

/** Scheduled check can run when the app is closed; Android controls exact timing. */
public final class UpdateJobService extends JobService {
    private volatile boolean stopped;
    @Override public boolean onStartJob(JobParameters params) {
        stopped = false;
        new Thread(() -> {
            try {
                UpdateClient.Release r = UpdateClient.fetch(getApplicationContext());
                if (!stopped && r.code > UpdateClient.installed(getApplicationContext()))
                    UpdateClient.notifyUpdate(getApplicationContext(), r);
            } catch (Exception ignored) { }
            if (!stopped) jobFinished(params, false);
        }, "update-job").start();
        return true;
    }
    @Override public boolean onStopJob(JobParameters params) { stopped = true; return false; }
}
