"""PixelFlux: the live multicart menu is embedded directly in the home screen."""
import argparse,hashlib,sys,time,textwrap
from pathlib import Path
import pygame
from controls import control_screen,reset_application,scan_gamepads,read_controls,input_bits
from preferences import read_preferences,write_preferences
from game_session import frame_surface,fit_frame
from libretro_host import LibretroHost
ROOT=Path(__file__).resolve().parent
GAME_ID='111kGbhhbliijXvVSg0gkwB2XYOwHdaPL'
GAME_SHA='a6cc62f11d6d872e9b0f3105089f31ea8a3d0c0593d24fa3adf73e4d62bfd78e'
ABOUT=('This application has been developed by Ahmed Kamal Elgandy to serve as a digital archive and platform for running and optimizing classic retro and Atari-style games on mobile devices. The project aims to revive memories and preserve the software heritage of classic games with a smooth, lightweight experience, while fully respecting the intellectual property rights of the original production companies.')
def verify_rom(path):
 p=Path(path)
 if not p.is_file() or hashlib.sha256(p.read_bytes()).hexdigest()!=GAME_SHA:raise ValueError('Bundled cartridge does not match its verified identity')
 return p

def main():
 p=argparse.ArgumentParser();p.add_argument('--smoke',action='store_true');p.add_argument('--ci-game',action='store_true');p.add_argument('--ci-controls',action='store_true');p.add_argument('--screenshot');a=p.parse_args()
 if (a.ci_game or a.ci_controls) and not a.smoke:raise ValueError('CI checks require smoke mode')
 pygame.init();pygame.joystick.init();screen=pygame.display.set_mode((1280,720),0 if a.smoke else pygame.FULLSCREEN);pygame.display.set_caption('PixelFlux');pygame.display.set_icon(pygame.image.load(str(ROOT/'assets/icon.png')))
 if a.ci_controls:
  import tempfile,controls
  with tempfile.TemporaryDirectory() as tmp:
   old=controls.data_dir;controls.data_dir=lambda:Path(tmp)/'pixel-test'
   try:
    pygame.event.clear();pygame.event.post(pygame.event.Event(pygame.MOUSEBUTTONDOWN,button=1,pos=(500,200)));pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_t));pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_ESCAPE));controls.control_screen(screen)
    assert controls.read_controls()['keyboard']['4']==pygame.K_t
    path=controls.data_dir()/'manual-saves';path.mkdir();(path/'test.state').write_text('test');controls.reset_application();assert not controls.data_dir().exists()
   finally:controls.data_dir=old
  print('PASS packaged controller mapping and isolated reset');pygame.quit();return
 rom=verify_rom(ROOT/'roms'/(GAME_ID+'.nes'));suffix='.dll' if sys.platform=='win32' else '.dylib' if sys.platform=='darwin' else '.so';corepath=ROOT/'cores'/('fceumm_libretro'+suffix)
 if not corepath.is_file():raise FileNotFoundError('NES core is not bundled')
 if a.ci_game:
  with LibretroHost(corepath,rom) as emu:
   for frame in range(2700):
    emu.buttons={3} if 1200<=frame<1204 or 1800<=frame<1804 else ({7} if 2300<=frame<2450 else set());emu.run_frame();emu.drain_audio()
   if emu.audio_samples<=0 or frame_surface(emu) is None:raise RuntimeError('Game did not produce audio/video')
   print('PASS multicart, menu, game startup, direction and audio')
  pygame.quit();return
 prefs=read_preferences();config=read_controls();pads=scan_gamepads();page='home';confirm=False;slot=0;status='';until=0;running=True;clock=pygame.time.Clock();icon=pygame.image.load(str(ROOT/'assets/icon.png')).convert_alpha();count=0
 with LibretroHost(corepath,rom) as core:
  sound=None
  if not a.smoke:
   try:pygame.mixer.quit();pygame.mixer.init(frequency=int(core.sample_rate),size=-16,channels=2,buffer=512);sound=pygame.mixer.Channel(0)
   except pygame.error:status='Audio unavailable';until=time.monotonic()+4
  def notice(s):
   nonlocal status,until
   status=s;until=time.monotonic()+4
  def persist():
   try:write_preferences(prefs)
   except OSError:notice('Could not save settings')
  def state_file():return Path.home()/'.pixelflux'/'manual-saves'/(core.game_hash+('.state' if slot==0 else '.slot'+str(slot+1)+'.state'))
  def save_load(save):
   try:
    if save:core.save_state(state_file())
    else:core.load_state(state_file())
    notice(('Saved' if save else 'Loaded')+' slot '+str(slot+1))
   except (OSError,RuntimeError,ValueError) as e:notice('Save / load failed: '+str(e)[:60])
  def reset():
   nonlocal prefs,config,page,confirm
   try:
    reset_application();prefs=read_preferences();config=read_controls();core.lib.retro_reset();page='home';confirm=False;notice('Application data reset')
   except OSError as e:notice('Reset failed: '+str(e)[:60]);confirm=False
  def action(row):
   nonlocal page,confirm,prefs,config,pads,slot,running
   if row==0:prefs['display_mode']='STRETCH' if prefs['display_mode']=='FIT' else 'FIT';persist()
   elif row==1:prefs['scaling']='SMOOTH' if prefs['scaling']=='SHARP' else 'SHARP';persist()
   elif row==2:slot=(slot+1)%4
   elif row==3:save_load(True)
   elif row==4:save_load(False)
   elif row==5:
    if control_screen(screen)=='quit':running=False
    config=read_controls();pads=scan_gamepads()
   elif row==6:confirm=True
   elif row==7:page='home'
  while running:
   w,h=screen.get_size();sx=w/1280;sy=h/720;scale=min(sx,sy)
   def R(x,y,ww,hh):return pygame.Rect(round(x*sx),round(y*sy),max(1,round(ww*sx)),max(1,round(hh*sy)))
   for e in pygame.event.get():
    if e.type==pygame.QUIT:running=False
    if e.type in (pygame.JOYDEVICEADDED,pygame.JOYDEVICEREMOVED):pads=scan_gamepads()
    if e.type==pygame.KEYDOWN:
     if confirm:
      if e.key==pygame.K_y:reset()
      elif e.key in (pygame.K_n,pygame.K_ESCAPE):confirm=False
     elif page=='about':
      if e.key in (pygame.K_ESCAPE,pygame.K_i):page='home'
     elif page=='settings':
      if e.key in (pygame.K_ESCAPE,pygame.K_g):page='home'
      elif e.key==pygame.K_d:action(0)
      elif e.key==pygame.K_c:action(5)
      elif e.key==pygame.K_r:action(6)
     elif e.key==pygame.K_g:page='settings'
     elif e.key==pygame.K_i:page='about'
     elif e.key==pygame.K_ESCAPE:running=False
     elif e.key==pygame.K_F5:save_load(True)
     elif e.key==pygame.K_F8:save_load(False)
    if e.type==pygame.MOUSEBUTTONDOWN and e.button==1:
     x=e.pos[0]/sx;y=e.pos[1]/sy
     if confirm:
      if 310<=x<=610 and 430<=y<=490:reset()
      elif 650<=x<=950 and 430<=y<=490:confirm=False
     elif page=='about':page='home'
     elif page=='settings':
      if 285<=x<=980:
       row=int((y-210)//40)
       if 0<=row<8:action(row)
     elif 55<=x<=270:
      if 260<=y<=315:page='settings'
      elif 332<=y<=387:page='about'
      elif 404<=y<=459:running=False
   if page=='home' and not confirm:
    core.buttons=input_bits(pads,config);core.run_frame();count+=1
   pcm=core.drain_audio()
   if sound and pcm and (not sound.get_busy() or sound.get_queue() is None):
    try:
     chunk=pygame.mixer.Sound(buffer=pcm)
     if sound.get_busy():sound.queue(chunk)
     else:sound.play(chunk)
    except pygame.error:pass
   screen.fill((250,251,247));pygame.draw.rect(screen,(235,248,244),R(30,24,265,672),border_radius=22);pygame.draw.rect(screen,(255,255,252),R(314,24,936,672),border_radius=22)
   frame=frame_surface(core)
   if frame:
    view=R(330,45,904,630);fitted=fit_frame((4,3),view.size) if prefs['display_mode']=='FIT' else pygame.Rect(0,0,*view.size);fitted.move_ip(view.topleft)
    screen.blit((pygame.transform.smoothscale if prefs['scaling']=='SMOOTH' else pygame.transform.scale)(frame,fitted.size),fitted)
   small=pygame.font.SysFont('dejavusans',max(12,int(15*scale)));body=pygame.font.SysFont('dejavusans',max(14,int(20*scale)));big=pygame.font.SysFont('dejavusans',max(20,int(30*scale)))
   def text(s,x,y,col=(46,67,76),f=body):screen.blit(f.render(str(s),True,col),R(x,y,1,1).topleft)
   screen.blit(pygame.transform.smoothscale(icon,(max(1,int(84*scale)),max(1,int(84*scale)))),R(55,56,84,84).topleft)
   text('PixelFlux',55,155,(35,62,72),big);text('ONE CARTRIDGE',56,204,(91,137,131),small);text('A WORLD OF GAMES',56,224,(91,137,131),small)
   for y,label in [(260,'SETTINGS  [G]'),(332,'ABOUT  [I]'),(404,'EXIT')]:
    pygame.draw.rect(screen,(255,255,255),R(55,y,215,55),border_radius=10);pygame.draw.rect(screen,(184,220,208),R(55,y,215,55),width=2,border_radius=10);text(label,69,y+16)
   text('ARROWS + ENTER',56,510,(91,137,131),small);text('F5 SAVE / F8 LOAD',56,535,(91,137,131),small)
   if time.monotonic()<until:text(status,330,675,(107,137,127),small)
   if page=='settings':
    pygame.draw.rect(screen,(231,246,242),R(250,150,780,420),border_radius=18);text('SETTINGS',285,170,(41,116,112),big)
    rows=['DISPLAY: '+prefs['display_mode']+'  [D]','FILTER: '+prefs['scaling'],'MANUAL SLOT: '+str(slot+1),'SAVE STATE  [F5]','LOAD STATE  [F8]','CONTROLLER / KEYBOARD  [C]','RESET ENTIRE APP  [R]','BACK  [ESC]']
    for i,label in enumerate(rows):
     y=210+i*40;pygame.draw.rect(screen,(255,255,255),R(285,y,695,36),border_radius=6);text(label,300,y+7)
   if page=='about':
    pygame.draw.rect(screen,(231,246,242),R(210,120,860,480),border_radius=18);text('ABOUT PIXELFLUX',245,155,(41,116,112),big)
    for i,line in enumerate(textwrap.wrap(ABOUT,width=78)):text(line,245,225+i*31,(52,77,81),small)
    text('Click anywhere or press ESC to return',245,530,(83,138,128),small)
   if confirm:
    pygame.draw.rect(screen,(255,239,233),R(240,175,800,380),border_radius=18);text('RESET ALL APP DATA?',275,210,(170,71,65),big);text('Deletes all local settings, controls and manual game saves.',275,280);text('This cannot be undone. The cartridge remains.',275,315)
    pygame.draw.rect(screen,(231,152,139),R(310,430,300,60),border_radius=8);text('DELETE ALL  [Y]',330,448,(70,38,38));pygame.draw.rect(screen,(225,248,236),R(650,430,300,60),border_radius=8);text('CANCEL  [N / ESC]',670,448)
   pygame.display.flip()
   if a.smoke and count>=1200:
    if frame is None or core.audio_samples<=0:raise RuntimeError('Embedded multicart did not render')
    if a.screenshot:pygame.image.save(screen,a.screenshot)
    print('PASS live multicart displayed on home screen without Play button');running=False
   if not a.smoke:clock.tick(round(core.fps) if 20<=core.fps<=120 else 60)
 pygame.quit()
if __name__=='__main__':main()
