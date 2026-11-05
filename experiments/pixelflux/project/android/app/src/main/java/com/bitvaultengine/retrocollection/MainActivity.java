package com.bitvaultengine.retrocollection;
import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

/** Starts the live embedded cartridge; there is no separate Play page. */
public final class MainActivity extends Activity {
 static final String GAME="111kGbhhbliijXvVSg0gkwB2XYOwHdaPL";
 static final String ABOUT="This application has been developed by Ahmed Kamal Elgandy to serve as a digital archive and platform for running and optimizing classic retro and Atari-style games on mobile devices. The project aims to revive memories and preserve the software heritage of classic games with a smooth, lightweight experience, while fully respecting the intellectual property rights of the original production companies.";
 @Override public void onCreate(Bundle state){super.onCreate(state);Intent i=new Intent(this,PlayerActivity.class);i.putExtra("game_id",GAME);if((getApplicationInfo().flags & android.content.pm.ApplicationInfo.FLAG_DEBUGGABLE)!=0 && getIntent().getBooleanExtra("pixel_ci_smoke",false))i.putExtra("akg_ci_smoke",true);startActivity(i);finish();}
}
