"""PixelFlux: light, single-multicart frontend using the BitVault engine."""
import argparse,hashlib,json,sys
from pathlib import Path
import pygame
from controls import control_screen,reset_application,scan_gamepads
from preferences import read_preferences,write_preferences
from game_session import run_session,frame_surface
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
 pygame.init();pygame.joystick.init();screen=pygame.display.set_mode((1280,720),0 if a.smoke else pygame.FULLSCREEN);pygame.display.set_caption('PixelFlux')
 pygame.display.set_icon(pygame.image.load(str(ROOT/'assets/icon.png')))
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
 rom=verify_rom(ROOT/'roms'/(GAME_ID+'.nes'));suffix='.dll' if sys.platform=='win32' else '.dylib' if sys.platform=='darwin' else '.so';core=ROOT/'cores'/('fceumm_libretro'+suffix)
 if not core.is_file():raise FileNotFoundError('NES core is not bundled')
 if a.ci_game:
  with LibretroHost(core,rom) as emu:
   for frame in range(1300):
    emu.buttons={3} if 1200<=frame<1204 else set();emu.run_frame();emu.drain_audio()
   if emu.audio_samples<=0 or frame_surface(emu) is None:raise RuntimeError('Game did not produce audio/video')
   print('PASS multicart core boot, menu frames, audio and Start input')
  pygame.quit();return
 prefs=read_preferences();saved=prefs.copy();display=prefs['display_mode'];page='home';confirm=False;status='';running=True;clock=pygame.time.Clock();icon=pygame.image.load(str(ROOT/'assets/icon.png')).convert_alpha()
 while running:
  w,h=screen.get_size();sx=w/1280;sy=h/720;scale=min(sx,sy)
  def R(x,y,ww,hh):return pygame.Rect(round(x*sx),round(y*sy),max(1,round(ww*sx)),max(1,round(hh*sy)))
  def do_reset():
   nonlocal prefs,saved,display,status,page,confirm
   try:reset_application();prefs=read_preferences();saved=prefs.copy();display=prefs['display_mode'];status='Application data reset. The cartridge remains.';page='home';confirm=False
   except OSError as e:status='Reset failed: '+str(e)[:80];page='home';confirm=False
  def play():
   nonlocal running,prefs,saved,display,status
   try:
    result=run_session(screen,core,rom,Path.home()/'.pixelflux'/'manual-saves',display_mode=display,verified_cheats=[])
    if result=='quit':running=False
    prefs=read_preferences();saved=prefs.copy();display=prefs['display_mode'];status='Returned from cartridge'
   except (OSError,ValueError,RuntimeError) as e:status='Game error: '+str(e)[:90]
  for e in pygame.event.get():
   if e.type==pygame.QUIT:running=False
   if e.type==pygame.KEYDOWN:
    if confirm:
     if e.key==pygame.K_y:do_reset()
     elif e.key in (pygame.K_n,pygame.K_ESCAPE):confirm=False
    elif page=='about':
     if e.key in (pygame.K_ESCAPE,pygame.K_i):page='home'
    elif page=='settings':
     if e.key in (pygame.K_ESCAPE,pygame.K_g):page='home'
     elif e.key==pygame.K_d:display='STRETCH' if display=='FIT' else 'FIT'
     elif e.key==pygame.K_c:
      if control_screen(screen)=='quit':running=False
     elif e.key==pygame.K_r:confirm=True
    elif e.key in (pygame.K_RETURN,pygame.K_SPACE):play()
    elif e.key==pygame.K_g:page='settings'
    elif e.key==pygame.K_i:page='about'
    elif e.key==pygame.K_ESCAPE:running=False
   if e.type==pygame.MOUSEBUTTONDOWN and e.button==1:
    x=e.pos[0]/sx;y=e.pos[1]/sy
    if confirm:
     if 310<=x<=610 and 430<=y<=490:do_reset()
     elif 650<=x<=950 and 430<=y<=490:confirm=False
    elif page=='about':page='home'
    elif page=='settings':
     if 285<=x<=980:
      if 235<=y<=283:display='STRETCH' if display=='FIT' else 'FIT'
      elif 295<=y<=343:
       if control_screen(screen)=='quit':running=False
      elif 355<=y<=403:confirm=True
      elif 415<=y<=463:page='home'
    elif 55<=x<=270:
     if 260<=y<=315:play()
     elif 332<=y<=387:page='settings'
     elif 404<=y<=459:page='about'
     elif 476<=y<=531:running=False
  prefs['display_mode']=display
  if prefs!=saved and not a.smoke:
   try:write_preferences(prefs);saved=prefs.copy()
   except OSError:status='Could not save settings'
  screen.fill((250,251,247));pygame.draw.rect(screen,(235,248,244),R(30,24,265,672),border_radius=22);pygame.draw.rect(screen,(255,255,252),R(314,24,936,672),border_radius=22)
  small=pygame.font.SysFont('dejavusans',max(12,int(15*scale)));body=pygame.font.SysFont('dejavusans',max(14,int(20*scale)));big=pygame.font.SysFont('dejavusans',max(20,int(30*scale)))
  def text(s,x,y,col=(46,67,76),f=body):screen.blit(f.render(str(s),True,col),R(x,y,1,1).topleft)
  screen.blit(pygame.transform.smoothscale(icon,(max(1,int(84*scale)),max(1,int(84*scale)))),R(55,56,84,84).topleft)
  text('PixelFlux',55,155,(35,62,72),big);text('ONE CARTRIDGE',56,204,(91,137,131),small);text('A WORLD OF GAMES',56,224,(91,137,131),small)
  for y,label in [(260,'PLAY  [ENTER]'),(332,'SETTINGS  [G]'),(404,'ABOUT  [I]'),(476,'EXIT')]:
   pygame.draw.rect(screen,(255,255,255),R(55,y,215,55),border_radius=10);pygame.draw.rect(screen,(184,220,208),R(55,y,215,55),width=2,border_radius=10);text(label,69,y+16,(46,88,91))
  if status:text(status,330,640,(107,137,127),small)
  if page=='settings':
   pygame.draw.rect(screen,(231,246,242),R(250,150,780,420),border_radius=18);text('SETTINGS',285,180,(41,116,112),big)
   for y,label in [(235,'DISPLAY: '+display+'  [D]'),(295,'CONTROLLER / KEYBOARD  [C]'),(355,'RESET ENTIRE APP  [R]'),(415,'BACK  [ESC]')]:pygame.draw.rect(screen,(255,255,255),R(285,y,695,48),border_radius=8);text(label,300,y+12)
  if page=='about':
   import textwrap
   pygame.draw.rect(screen,(231,246,242),R(210,120,860,480),border_radius=18);text('ABOUT PIXELFLUX',245,155,(41,116,112),big)
   for i,line in enumerate(textwrap.wrap(ABOUT,width=78)):text(line,245,225+i*31,(52,77,81),small)
   text('Click anywhere or press ESC to return',245,530,(83,138,128),small)
  if confirm:
   pygame.draw.rect(screen,(255,239,233),R(240,175,800,380),border_radius=18);text('RESET ALL APP DATA?',275,210,(170,71,65),big);text('Deletes all local settings, controls and manual game saves.',275,280);text('This cannot be undone. The cartridge remains.',275,315)
   pygame.draw.rect(screen,(231,152,139),R(310,430,300,60),border_radius=8);text('DELETE ALL  [Y]',330,448,(70,38,38));pygame.draw.rect(screen,(225,248,236),R(650,430,300,60),border_radius=8);text('CANCEL  [N / ESC]',670,448)
  pygame.display.flip()
  if a.screenshot:pygame.image.save(screen,a.screenshot)
  if a.smoke:running=False
  clock.tick(60)
 pygame.quit()
if __name__=='__main__':main()
