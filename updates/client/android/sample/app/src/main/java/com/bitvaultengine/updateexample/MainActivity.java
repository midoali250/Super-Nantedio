package com.bitvaultengine.updateexample;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import com.bitvaultengine.updates.UpdateClient;

/** Integration example only; example-game has no published update manifest. */
public class MainActivity extends Activity {
    @Override protected void onCreate(Bundle state) {
        super.onCreate(state);
        Button button = new Button(this);
        button.setText("التحقق من تحديث اللعبة");
        button.setOnClickListener(v -> UpdateClient.checkNow(this));
        setContentView(button);
        UpdateClient.schedule(this);
        UpdateClient.requestNotificationPermission(this);
        if (!UpdateClient.consumeNotificationIntent(this, getIntent())) UpdateClient.checkInBackground(this);
    }
    @Override protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        UpdateClient.consumeNotificationIntent(this, intent);
    }
}
