package com.bitvaultengine.retrocollection;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

public final class MainActivity extends Activity {
 static final String GAME="111kGbhhbliijXvVSg0gkwB2XYOwHdaPL";
 static final String ABOUT="This application has been developed by Ahmed Kamal Elgandy to serve as a digital archive and platform for running and optimizing classic retro and Atari-style games on mobile devices. The project aims to revive memories and preserve the software heritage of classic games with a smooth, lightweight experience, while fully respecting the intellectual property rights of the original production companies.";
 int dp(int x){return Math.round(x*getResources().getDisplayMetrics().density);}
 GradientDrawable shape(int bg,int border){GradientDrawable d=new GradientDrawable();d.setColor(bg);d.setCornerRadius(dp(12));d.setStroke(dp(1),border);return d;}
 Button button(String title){Button b=new Button(this);b.setText(title);b.setTextColor(Color.rgb(41,63,85));b.setAllCaps(false);b.setTextSize(16);b.setBackground(shape(Color.WHITE,Color.rgb(170,213,209)));return b;}
 void play(boolean smoke){Intent i=new Intent(this,PlayerActivity.class);i.putExtra("game_id",GAME);if(smoke)i.putExtra("akg_ci_smoke",true);startActivity(i);}
 @Override public void onCreate(Bundle state){super.onCreate(state);getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_IMMERSIVE_STICKY|View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION|View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
  if((getApplicationInfo().flags & android.content.pm.ApplicationInfo.FLAG_DEBUGGABLE)!=0 && getIntent().getBooleanExtra("pixel_ci_smoke",false)){play(true);finish();return;}
  LinearLayout outer=new LinearLayout(this);outer.setOrientation(LinearLayout.HORIZONTAL);outer.setPadding(dp(24),dp(16),dp(24),dp(16));outer.setBackgroundColor(Color.rgb(251,251,247));
  LinearLayout side=new LinearLayout(this);side.setOrientation(LinearLayout.VERTICAL);side.setPadding(dp(14),dp(14),dp(14),dp(14));side.setBackground(shape(Color.rgb(239,249,246),Color.rgb(208,232,227)));
  TextView title=new TextView(this);title.setText("PixelFlux");title.setTextColor(Color.rgb(35,56,77));title.setTypeface(null,Typeface.BOLD);title.setTextSize(26);side.addView(title);
  TextView note=new TextView(this);note.setText("ONE CARTRIDGE\nA WORLD OF GAMES");note.setTextColor(Color.rgb(100,138,139));note.setTextSize(11);LinearLayout.LayoutParams n=new LinearLayout.LayoutParams(-1,-2);n.setMargins(0,dp(4),0,dp(15));side.addView(note,n);
  Button play=button("▶  Play");play.setOnClickListener(v->play(false));side.addView(play,new LinearLayout.LayoutParams(-1,dp(48)));
  Button settings=button("Settings");settings.setOnClickListener(v->PlayerActivity.libraryControls(this,GAME));LinearLayout.LayoutParams sp=new LinearLayout.LayoutParams(-1,dp(48));sp.topMargin=dp(8);side.addView(settings,sp);
  Button about=button("About");about.setOnClickListener(v->new AlertDialog.Builder(this).setTitle("About PixelFlux").setMessage(ABOUT).setPositiveButton("Close",null).show());LinearLayout.LayoutParams ap=new LinearLayout.LayoutParams(-1,dp(48));ap.topMargin=dp(8);side.addView(about,ap);
  Button exit=button("Exit");exit.setOnClickListener(v->finish());LinearLayout.LayoutParams ep=new LinearLayout.LayoutParams(-1,dp(48));ep.topMargin=dp(8);side.addView(exit,ep);
  outer.addView(side,new LinearLayout.LayoutParams(dp(205),-1));View canvas=new View(this);canvas.setBackground(shape(Color.rgb(255,255,252),Color.rgb(234,242,235)));LinearLayout.LayoutParams cp=new LinearLayout.LayoutParams(0,-1,1);cp.leftMargin=dp(16);outer.addView(canvas,cp);setContentView(outer);
 }
}
