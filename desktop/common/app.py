#!/usr/bin/env python3
"""Standalone Super Mario Bros. (World) desktop frontend, powered by FCEUmm."""
import ctypes as C
import json
import hashlib
import re
import os
from pathlib import Path
import sys
import tempfile
import threading
import time
import urllib.request
import webbrowser

import pygame

VERSION = '1.0.0'
CATALOG = 'https://raw.githubusercontent.com/midoali250/bitvault-engine/main/updates/desktop/super-mario-world.json'
ROOT = Path(getattr(sys, '_MEIPASS', Path(__file__).resolve().parent))
ACTIONS = ['UP', 'DOWN', 'LEFT', 'RIGHT', 'JUMP', 'FIRE', 'START', 'SELECT']
BITS = {'UP':4,'DOWN':5,'LEFT':6,'RIGHT':7,'JUMP':8,'FIRE':0,'START':3,'SELECT':2}
DEFAULTS = {'UP':[('key',pygame.K_UP),('key',pygame.K_w)], 'DOWN':[('key',pygame.K_DOWN),('key',pygame.K_s)],
 'LEFT':[('key',pygame.K_LEFT),('key',pygame.K_a)], 'RIGHT':[('key',pygame.K_RIGHT),('key',pygame.K_d)],
 'JUMP':[('key',pygame.K_z),('key',pygame.K_SPACE),('mouse',1),('joy',0)],
 'FIRE':[('key',pygame.K_x),('key',pygame.K_LCTRL),('mouse',3),('joy',1),('joy',2)],
 'START':[('key',pygame.K_RETURN),('joy',7)], 'SELECT':[('key',pygame.K_RSHIFT),('joy',6)]}

class Core:
    def __init__(self):
        library = ('libnesapp_host.dll' if (ROOT / 'libnesapp_host.dll').exists() else 'nesapp_host.dll') if sys.platform == 'win32' else ('libnesapp_host.dylib' if sys.platform == 'darwin' else 'libnesapp_host.so')
        self.lib = C.CDLL(str(ROOT / library))
        self.lib.host_start.argtypes=[C.c_char_p,C.c_int]; self.lib.host_start.restype=C.c_int
        self.lib.host_video.argtypes=[C.c_void_p,C.c_int]; self.lib.host_video.restype=C.c_int
        self.lib.host_input.argtypes=[C.c_int,C.c_int,C.c_int,C.c_int]
        self.lib.host_read_audio.argtypes=[C.POINTER(C.c_int16),C.c_int]
        self.lib.host_read_audio.restype=C.c_int
        self.lib.Java_com_midoali_nes_NesCore_nativeMarioProtection.argtypes=[C.c_void_p,C.c_void_p,C.c_int]
        self.tempdir=tempfile.TemporaryDirectory(prefix='bitvault-engine-')
        os.environ['SUPER_NES_TEMP']=self.tempdir.name
        data=(ROOT / 'mario.nes').read_bytes()
        if not self.lib.host_start(data,len(data)): raise RuntimeError('Could not start ROM')
        self.w=self.lib.host_width(); self.h=self.lib.host_height()
        self.video=C.create_string_buffer(self.w*self.h*2);self.audio=(C.c_int16*4096)()
    def frame(self, mask, cheats):
        self.lib.host_input(mask,0,0,0)
        self.lib.Java_com_midoali_nes_NesCore_nativeMarioProtection(None,None,cheats)
        self.lib.host_frame()
    def framebuffer(self):
        size=self.lib.host_video(self.video,len(self.video))
        if size != self.w*self.h*2: raise RuntimeError('No frame')
        return self.video.raw[:size]
    def samples(self):
        n=self.lib.host_read_audio(self.audio,2048)
        return C.string_at(self.audio,n*4) if n>0 else b''

def config_path():
    if sys.platform=='win32': root=Path(os.environ.get('APPDATA',Path.home()))
    elif sys.platform=='darwin': root=Path.home()/'Library'/'Application Support'
    else: root=Path(os.environ.get('XDG_CONFIG_HOME',Path.home()/'.config'))
    p=root/'bitvaultengine'/'MarioWorld';p.mkdir(parents=True,exist_ok=True)
    return p/'settings.json'

def read_config():
    try:
        d=json.loads(config_path().read_text(encoding='utf8'))
        return d if isinstance(d,dict) else {}
    except (OSError,ValueError): return {}

def save_config(d):
    try: config_path().write_text(json.dumps(d,indent=2),encoding='utf8')
    except OSError: pass

def active(binding, keys, mouse, joysticks):
    try:
        kind,n=binding
        if kind=='key': return bool(keys[n])
        if kind=='mouse': return 1<=n<=len(mouse) and bool(mouse[n-1])
        if kind=='joy': return any(n<j.get_numbuttons() and j.get_button(n) for j in joysticks)
    except (IndexError,TypeError,ValueError,pygame.error): pass
    return False

def mask_from_inputs(bindings, keys, mouse, joysticks):
    mask=0
    for action in ACTIONS:
        if any(active(b,keys,mouse,joysticks) for b in bindings[action]): mask |= 1<<BITS[action]
    for j in joysticks:
        try:
            if j.get_numaxes()>=2:
                x,y=j.get_axis(0),j.get_axis(1)
                if x < -.25: mask |= 1<<BITS['LEFT']
                if x >  .25: mask |= 1<<BITS['RIGHT']
                if y < -.25: mask |= 1<<BITS['UP']
                if y >  .25: mask |= 1<<BITS['DOWN']
            if j.get_numhats():
                x,y=j.get_hat(0)
                if x<0: mask |= 1<<BITS['LEFT']
                if x>0: mask |= 1<<BITS['RIGHT']
                if y>0: mask |= 1<<BITS['UP']
                if y<0: mask |= 1<<BITS['DOWN']
        except pygame.error: continue
    return mask

def devices():
    result=[]
    for i in range(pygame.joystick.get_count()):
        try:
            j=pygame.joystick.Joystick(i);j.init();result.append(j)
        except pygame.error: pass
    return result

def update_check(result):
    try:
        req=urllib.request.Request(CATALOG,headers={'Cache-Control':'no-cache','User-Agent':'bitvaultengineDesktop/1'})
        with urllib.request.urlopen(req,timeout=10) as response: d=json.load(response)
        entry=d['platforms']['windows' if sys.platform=='win32' else ('macos' if sys.platform=='darwin' else 'linux')]
        def ver(s): return tuple(int(x) for x in s.split('.'))
        url=entry['release_url']
        if not url.startswith('https://github.com/midoali250/bitvault-engine/releases/tag/'):
            raise ValueError('invalid update URL')
        if ver(entry['version'])>ver(VERSION): result.update(text='Update '+entry['version']+' available: press U to download',url=url,entry=entry)
        else: result.update(text='You have the latest version',url='')
    except Exception: result.update(text='Update check unavailable; retry in Settings',url='')

def download_update(result):
    try:
        entry=result['entry']; url=entry['download_url']; digest=entry['sha256'].lower(); size=int(entry['size'])
        if not url.startswith('https://github.com/midoali250/bitvault-engine/releases/download/') or not re.fullmatch(r'[0-9a-f]{64}',digest) or not 0<size<=536870912:
            raise ValueError('invalid update metadata')
        filename=url.rsplit('/',1)[-1]
        if not re.fullmatch(r'[A-Za-z0-9._-]+',filename): raise ValueError('invalid filename')
        folder=Path.home()/'Downloads';folder.mkdir(parents=True,exist_ok=True)
        fd,tmp=tempfile.mkstemp(prefix='.bitvault-engine-',suffix='.part',dir=str(folder)); done=0; h=hashlib.sha256()
        try:
            with os.fdopen(fd,'wb') as out, urllib.request.urlopen(urllib.request.Request(url,headers={'User-Agent':'bitvaultengineDesktop/1'}),timeout=30) as response:
                while True:
                    chunk=response.read(262144)
                    if not chunk: break
                    done+=len(chunk)
                    if done>size: raise ValueError('download too large')
                    h.update(chunk);out.write(chunk)
                    result['text']='Downloading update: %d%%' % (done*100//size)
            if done!=size or h.hexdigest()!=digest: raise ValueError('update verification failed')
            destination=folder/filename
            if destination.exists(): destination=folder/(str(int(time.time()))+'-'+filename)
            os.replace(tmp,destination)
            if sys.platform!='win32' and destination.suffix=='.AppImage': destination.chmod(0o755)
            result.update(text='Verified update saved in Downloads: '+destination.name,url='')
        finally:
            if os.path.exists(tmp): os.unlink(tmp)
    except Exception:
        result.update(text='Update download or verification failed; retry',url='')

def self_test():
    os.environ['SDL_VIDEODRIVER']='dummy';os.environ['SDL_AUDIODRIVER']='dummy'
    pygame.init();pygame.display.set_mode((256,240))
    core=Core()
    def run(n,mask=0):
        for _ in range(n): core.frame(mask,0);core.samples()
    run(120);run(12,1<<3);run(350)
    core.lib.retro_get_memory_data.argtypes=[C.c_uint];core.lib.retro_get_memory_data.restype=C.POINTER(C.c_uint8)
    r=core.lib.retro_get_memory_data(2)
    assert r[0x770]==1 and r[0x0e]==8, 'Game did not start'
    x=r[0x86]; run(60,1<<7); assert r[0x86]>x, 'Player did not move'
    y=r[0xce];run(12,(1<<7)|(1<<8));assert r[0xce]<y, 'Player did not jump'
    data=core.framebuffer();assert len(data)==256*240*2 and any(data), 'Video frame missing'
    surface=pygame.Surface((256,240),0,16,(0xf800,0x07e0,0x001f,0))
    surface.get_buffer().write(data)
    pygame.display.get_surface().blit(surface,(0,0));pygame.display.flip()
    assert pygame.transform.scale(surface,(2880,2160)).get_size()==(2880,2160), '4K scaling failed'
    class Keys:
        def __getitem__(self,key): return key == pygame.K_SPACE
    assert mask_from_inputs(DEFAULTS, Keys(), (False,False,False,False,False), []) & (1<<8), 'Keyboard jump missing'
    class NoKeys:
        def __getitem__(self,key): return False
    assert mask_from_inputs(DEFAULTS, NoKeys(), (True,False,False,False,False), []) & (1<<8), 'Mouse jump missing'
    class FakePad:
        def get_numbuttons(self): return 10
        def get_button(self,n): return n==1
        def get_numaxes(self): return 2
        def get_axis(self,n): return 0.8 if n==0 else 0
        def get_numhats(self): return 0
    mask=mask_from_inputs(DEFAULTS, NoKeys(), (False,False,False,False,False), [FakePad()])
    assert mask & (1<<7) and mask & 1, 'Gamepad axis or fire missing'
    print('PASS: startup, world 1-1, movement, jump, video, keyboard, mouse, gamepad')
    pygame.quit()

def main():
    ui_test = "--ui-test" in sys.argv
    if ui_test:
        os.environ["SDL_VIDEODRIVER"]="dummy"; os.environ["SDL_AUDIODRIVER"]="dummy"
    pygame.mixer.pre_init(48000,-16,2,512)
    pygame.init();pygame.joystick.init()
    screen=pygame.display.set_mode((1024,768),pygame.RESIZABLE)
    pygame.display.set_caption('Super Mario Bros. — bitvaultengine')
    font=pygame.font.Font(None,27); small=pygame.font.Font(None,23)
    core=Core(); frame=pygame.Surface((core.w,core.h),0,16,(0xf800,0x07e0,0x001f,0))
    clock=pygame.time.Clock(); config=read_config()
    bindings={k:[tuple(v) for v in config.get('bindings',{}).get(k,DEFAULTS[k])] for k in ACTIONS}
    cheat=config.get('cheats',{'lives':True,'enemy':True,'pit':True})
    if not isinstance(cheat,dict): cheat={'lives':True,'enemy':True,'pit':True}
    joysticks=devices(); menu=False; selected=0; waiting=None; fullscreen=False
    rows=ACTIONS+['INFINITE LIVES','ENEMY PROTECTION','PIT RESCUE','CHECK UPDATES','RESET CONTROLS','CLOSE SETTINGS']
    notice={'text':'Checking updates...', 'url':''}
    if not ui_test: threading.Thread(target=update_check,args=(notice,),daemon=True).start()
    channel=pygame.mixer.Channel(0) if pygame.mixer.get_init() else None
    running=True; ui_frame=0
    while running:
        if ui_test:
            ui_frame += 1
            if ui_frame==5: pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_F1))
            if ui_frame==7:
                assert menu, 'Settings did not open'
                pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_RETURN))
            if ui_frame==9:
                assert waiting=='UP', 'Binding selection did not open'
                pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_w))
            if ui_frame==11:
                assert bindings['UP']==[('key',pygame.K_w)], 'Key remapping failed'
                pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_ESCAPE))
            if ui_frame==15:
                assert not menu, 'Settings did not close'
                pygame.event.post(pygame.event.Event(pygame.QUIT))
        for event in pygame.event.get():
            if event.type==pygame.QUIT: running=False
            elif event.type in (pygame.JOYDEVICEADDED,pygame.JOYDEVICEREMOVED): joysticks=devices()
            elif event.type==pygame.KEYDOWN and event.key==pygame.K_F11:
                fullscreen=not fullscreen
                screen=pygame.display.set_mode((0,0) if fullscreen else (1024,768),pygame.FULLSCREEN if fullscreen else pygame.RESIZABLE)
            elif waiting is not None:
                binding=None
                if event.type==pygame.KEYDOWN and event.key==pygame.K_ESCAPE: waiting=None;continue
                if event.type==pygame.KEYDOWN: binding=('key',event.key)
                if event.type==pygame.MOUSEBUTTONDOWN: binding=('mouse',event.button)
                if event.type==pygame.JOYBUTTONDOWN: binding=('joy',event.button)
                if binding:
                    bindings[waiting]=[binding];waiting=None
                    config['bindings']=bindings;save_config(config)
            elif event.type==pygame.KEYDOWN and event.key in (pygame.K_ESCAPE,pygame.K_F1): menu=not menu
            elif event.type==pygame.MOUSEBUTTONDOWN and event.button==2: menu=not menu
            elif event.type==pygame.JOYBUTTONDOWN and event.button==9: menu=not menu
            elif menu:
                if event.type==pygame.KEYDOWN and event.key in (pygame.K_UP,pygame.K_DOWN): selected=(selected+(-1 if event.key==pygame.K_UP else 1))%len(rows)
                if event.type==pygame.MOUSEBUTTONDOWN and event.button==1:
                    _,h=screen.get_size(); top=max(55,(h-len(rows)*29)//2)
                    row=(event.pos[1]-top)//29
                    if 0<=row<len(rows): selected=row;event=pygame.event.Event(pygame.KEYDOWN,key=pygame.K_RETURN)
                if event.type==pygame.KEYDOWN and event.key==pygame.K_u and notice.get('url'):
                    notice.update(text='Starting download...',url='');threading.Thread(target=download_update,args=(notice,),daemon=True).start()
                if event.type==pygame.KEYDOWN and event.key in (pygame.K_RETURN,pygame.K_KP_ENTER):
                    item=rows[selected]
                    if item in ACTIONS: waiting=item
                    elif item in ('INFINITE LIVES','ENEMY PROTECTION','PIT RESCUE'):
                        k={'INFINITE LIVES':'lives','ENEMY PROTECTION':'enemy','PIT RESCUE':'pit'}[item];cheat[k]=not cheat.get(k,False);config['cheats']=cheat;save_config(config)
                    elif item=='CHECK UPDATES': notice.update(text='Checking updates...',url='');threading.Thread(target=update_check,args=(notice,),daemon=True).start()
                    elif item=='RESET CONTROLS': bindings={k:list(v) for k,v in DEFAULTS.items()};config['bindings']=bindings;save_config(config)
                    else: menu=False
        if not menu:
            mask=mask_from_inputs(bindings,pygame.key.get_pressed(),pygame.mouse.get_pressed(5),joysticks)
            flags=(1 if cheat.get('lives') else 0)|(2 if cheat.get('enemy') else 0)|(4 if cheat.get('pit') else 0)
            core.frame(mask,flags)
            raw=core.framebuffer()
            frame.get_buffer().write(raw)
            audio=core.samples()
            if channel and audio:
                try:
                    sound=pygame.mixer.Sound(buffer=audio)
                    if not channel.get_busy(): channel.play(sound)
                    elif channel.get_queue() is None: channel.queue(sound)
                except pygame.error: pass
        w,h=screen.get_size(); screen.fill((0,0,0))
        dw=min(w,int(h*4/3));dh=min(h,int(dw*3/4))
        screen.blit(pygame.transform.scale(frame,(dw,dh)),((w-dw)//2,(h-dh)//2))
        if menu:
            shade=pygame.Surface((w,h),pygame.SRCALPHA);shade.fill((0,0,0,215));screen.blit(shade,(0,0))
            title=font.render('SETTINGS — Enter / Click to configure    Esc: Resume',True,(255,255,255));screen.blit(title,(25,15))
            top=max(55,(h-len(rows)*29)//2)
            for i,item in enumerate(rows):
                suffix=''
                if item in ACTIONS:
                    vals=[]
                    for kind,n in bindings[item]:
                        vals.append(pygame.key.name(n) if kind=='key' else (kind+' '+str(n)))
                    suffix=': '+', '.join(vals)
                if item in ('INFINITE LIVES','ENEMY PROTECTION','PIT RESCUE'):
                    k={'INFINITE LIVES':'lives','ENEMY PROTECTION':'enemy','PIT RESCUE':'pit'}[item];suffix=': '+('ON' if cheat.get(k) else 'OFF')
                label=small.render(('> ' if i==selected else '  ')+item+suffix,True,(255,225,80) if i==selected else (230,230,230));screen.blit(label,(25,top+i*29))
            msg=('Press a key, mouse button or controller button (Esc cancels)' if waiting else f'Detected controllers: {len(joysticks)} | '+notice['text'])
            screen.blit(small.render(msg,True,(120,220,255)),(25,h-32))
        pygame.display.flip();clock.tick(60)
    pygame.quit()

if __name__=='__main__':
    try:
        if '--self-test' in sys.argv: self_test()
        else: main()
    except Exception as e:
        print('Fatal:',e,file=sys.stderr)
        sys.exit(1)
