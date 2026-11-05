#!/usr/bin/env python3
"""Super Mario Bros. desktop frontend, FCEUmm core."""
import ctypes as C
import hashlib,json,os,re,subprocess,sys,tempfile,threading,time,urllib.request
from pathlib import Path
import pygame
VERSION='1.4.0'
CATALOG='https://raw.githubusercontent.com/midoali250/bitvault-engine/refs/heads/main/updates/desktop/super-mario-world.json'
ROOT=Path(getattr(sys,'_MEIPASS',Path(__file__).resolve().parent))
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


def update_check(result):
    try:
        req=urllib.request.Request(CATALOG,headers={'Cache-Control':'no-cache','User-Agent':'BitVaultEngineDesktop/1'})
        with urllib.request.urlopen(req,timeout=10) as response: d=json.load(response)
        entry=d['platforms']['windows' if sys.platform=='win32' else ('macos' if sys.platform=='darwin' else 'linux')]
        def ver(s): return tuple(int(x) for x in s.split('.'))
        url=entry['release_url']
        if not url.startswith(('https://github.com/midoali250/bitvault-engine/releases/tag/','https://github.com/midoali250/bitvault-engine/releases/tag/')):
            raise ValueError('invalid update URL')
        if ver(entry['version'])>ver(VERSION): result.update(text='Update '+entry['version']+' available: select Download update',url=url,entry=entry)
        else: result.update(text='You have the latest version',url='')
    except Exception: result.update(text='Update check unavailable; retry in Settings',url='')

def system_notification(version):
    """Best effort OS notification; the game banner is independent."""
    if not re.fullmatch(r'[0-9]+(?:\.[0-9]+){1,3}',version):return False
    title='Super Mario World update';message='Version '+version+' is available. Open game settings to download.'
    env=os.environ.copy()
    if sys.platform.startswith('linux'):
        if 'LD_LIBRARY_PATH_ORIG' in env:env['LD_LIBRARY_PATH']=env['LD_LIBRARY_PATH_ORIG']
        else:env.pop('LD_LIBRARY_PATH',None)
        import shutil
        if shutil.which('notify-send'):
            cmd=['notify-send','--app-name=Mario World','--expire-time=10000',title,message]
        elif shutil.which('gdbus'):
            cmd=['gdbus','call','--session','--dest','org.freedesktop.Notifications','--object-path','/org/freedesktop/Notifications','--method','org.freedesktop.Notifications.Notify','BitVaultEngine','0','',title,message,'[]','{}','10000']
        else:return False
    elif sys.platform=='darwin':cmd=['osascript','-e','display notification "'+message+'" with title "'+title+'"']
    elif sys.platform=='win32':
        script=r"""$ErrorActionPreference = 'Stop'
[Windows.UI.Notifications.ToastNotificationManager,Windows.UI.Notifications,ContentType=WindowsRuntime] > $null
[Windows.Data.Xml.Dom.XmlDocument,Windows.Data.Xml.Dom.XmlDocument,ContentType=WindowsRuntime] > $null
$xml=New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml('<toast><visual><binding template="ToastGeneric"><text>Super Mario World update</text><text>Version VERSION is available. Open game settings to download.</text></binding></visual></toast>')
$toast=[Windows.UI.Notifications.ToastNotification]::new($xml)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe').Show($toast)
""".replace('VERSION',version)
        cmd=['powershell.exe','-NoProfile','-NonInteractive','-Command',script]
    else:return False
    try:
        result=subprocess.run(cmd,env=env,stdout=subprocess.DEVNULL,stderr=subprocess.DEVNULL,stdin=subprocess.DEVNULL,timeout=8,creationflags=getattr(subprocess,'CREATE_NO_WINDOW',0) if sys.platform=='win32' else 0)
        return result.returncode==0
    except (OSError,subprocess.SubprocessError):return False

class UpdateMonitor:
    """Check at launch and every five minutes while the game is running."""
    def __init__(self,status=None,checker=update_check,notifier=system_notification,interval=300):
        self.status=status if status is not None else {'text':'Checking for updates...', 'url':''}
        self.checker=checker;self.notifier=notifier;self.interval=interval;self.next_check=0
        self.banner_until=0;self.notified=set();self.busy=False;self.lock=threading.Lock();self.thread=None
    def check(self):
        with self.lock:
            if self.busy:return False
            self.busy=True;self.next_check=time.monotonic()+self.interval
        def run():
            result={}
            try:
                self.checker(result);self.status.update(result)
                entry=result.get('entry',{})
                version=entry.get('version','') if result.get('url') else ''
                if version and version not in self.notified:
                    self.notified.add(version);self.banner_until=time.monotonic()+15;self.notifier(version)
            finally:
                with self.lock:self.busy=False
        self.thread=threading.Thread(target=run,name='update-check',daemon=True);self.thread.start();return True
    def poll(self):
        if time.monotonic()>=self.next_check:self.check()

def download_update(result):
    try:
        entry=result['entry']; url=entry['download_url']; digest=entry['sha256'].lower(); size=int(entry['size'])
        if not url.startswith(('https://github.com/midoali250/bitvault-engine/releases/download/','https://github.com/midoali250/bitvault-engine/releases/download/')) or not re.fullmatch(r'[0-9a-f]{64}',digest) or not 0<size<=536870912:
            raise ValueError('invalid update metadata')
        filename=url.rsplit('/',1)[-1]
        if not re.fullmatch(r'[A-Za-z0-9._-]+',filename): raise ValueError('invalid filename')
        folder=Path.home()/'Downloads';folder.mkdir(parents=True,exist_ok=True)
        fd,tmp=tempfile.mkstemp(prefix='.bitvault-engine-',suffix='.part',dir=str(folder)); done=0; h=hashlib.sha256()
        try:
            with os.fdopen(fd,'wb') as out, urllib.request.urlopen(urllib.request.Request(url,headers={'User-Agent':'BitVaultEngineDesktop/1'}),timeout=30) as response:
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

# Controls are grouped by device so changing a gamepad does not erase a keyboard binding.
ACTIONS=['UP','DOWN','LEFT','RIGHT','SMALL JUMP (repeat)','BIG JUMP','SINGLE FIRE','AUTO FIRE','START','SELECT']
GROUPS=['Keyboard','Gamepad','Mouse']
DEFAULTS={
 'UP':{'key':[pygame.K_UP],'pad':[['axis',1,-1],['hat',0,0,1]],'mouse':[]},
 'DOWN':{'key':[pygame.K_DOWN],'pad':[['axis',1,1],['hat',0,0,-1]],'mouse':[]},
 'LEFT':{'key':[pygame.K_LEFT],'pad':[['axis',0,-1],['hat',0,-1,0]],'mouse':[]},
 'RIGHT':{'key':[pygame.K_RIGHT],'pad':[['axis',0,1],['hat',0,1,0]],'mouse':[]},
 'SMALL JUMP (repeat)':{'key':[pygame.K_a],'pad':[['button',0]],'mouse':[]},
 'BIG JUMP':{'key':[pygame.K_s],'pad':[['button',1]],'mouse':[1]},
 'SINGLE FIRE':{'key':[pygame.K_z],'pad':[['button',2]],'mouse':[3]},
 'AUTO FIRE':{'key':[pygame.K_x],'pad':[['button',3]],'mouse':[]},
 'START':{'key':[pygame.K_RETURN],'pad':[['button',7]],'mouse':[]},
 'SELECT':{'key':[pygame.K_RSHIFT],'pad':[['button',6]],'mouse':[]}}

def home_dir():
    if sys.platform=='win32': root=Path(os.environ.get('APPDATA',Path.home()))
    elif sys.platform=='darwin': root=Path.home()/'Library'/'Application Support'
    else: root=Path(os.environ.get('XDG_CONFIG_HOME',Path.home()/'.config'))
    p=root/'bitvault-engine'/'MarioWorld';p.mkdir(parents=True,exist_ok=True);return p

def read_json(path):
    try:
        data=json.loads(path.read_text(encoding='utf8'))
        return data if isinstance(data,dict) else {}
    except (OSError,ValueError): return {}

def write_atomic(path,data):
    fd,tmp=tempfile.mkstemp(prefix='.saving-',dir=str(path.parent))
    try:
        with os.fdopen(fd,'wb') as f: f.write(data);f.flush();os.fsync(f.fileno())
        os.replace(tmp,path)
    finally:
        if os.path.exists(tmp): os.unlink(tmp)

class SaveWorker:
    """Only byte snapshots cross threads; the emulator stays on the main thread."""
    def __init__(self,path,writer=write_atomic):
        self.path=path;self.writer=writer;self.condition=threading.Condition();self.pending=None;self.closed=False;self.error=None
        self.thread=threading.Thread(target=self._run,name='save-writer',daemon=True);self.thread.start()
    def submit(self,data):
        with self.condition:
            if self.closed:raise RuntimeError('Save worker closed')
            self.pending=data # coalesce outdated snapshots while a disk write is running
            self.condition.notify()
    def _run(self):
        while True:
            with self.condition:
                while self.pending is None and not self.closed:self.condition.wait()
                if self.pending is None and self.closed:return
                data=self.pending;self.pending=None
            try:self.writer(self.path,data);self.error=None
            except (OSError,ValueError,RuntimeError) as exc:self.error=exc
    def close(self,timeout=3):
        with self.condition:self.closed=True;self.condition.notify()
        self.thread.join(timeout)
        return not self.thread.is_alive() and self.error is None

def save_config(config):
    write_atomic(home_dir()/'settings-v2.json',json.dumps(config,indent=2).encode())

def load_config():
    cfg=read_json(home_dir()/'settings-v2.json')
    if not cfg:
        old=read_json(home_dir()/'settings.json')
        cfg={'cheats':old.get('cheats',{})}
    valid={}
    incoming=cfg.get('controls',{})
    if not isinstance(incoming,dict): incoming={}
    for action in ACTIONS:
        d=incoming.get(action,{})
        valid[action]={}
        for key in ('key','pad','mouse'):
            val=d.get(key,DEFAULTS[action][key]) if isinstance(d,dict) else DEFAULTS[action][key]
            valid[action][key]=val if isinstance(val,list) else DEFAULTS[action][key]
    cfg['controls']=valid
    if not isinstance(cfg.get('cheats'),dict):cfg['cheats']={}
    for k in ('lives','enemy','pit'):cfg['cheats'].setdefault(k,True)
    if cfg.get('display') not in ('fit','fill'): cfg['display']='fill'
    if cfg.get('filter') not in ('sharp','smooth'):cfg['filter']='sharp'
    return cfg

def configure_state_api(core):
    core.lib.retro_serialize_size.argtypes=[];core.lib.retro_serialize_size.restype=C.c_size_t
    core.lib.retro_serialize.argtypes=[C.c_void_p,C.c_size_t];core.lib.retro_serialize.restype=C.c_bool
    core.lib.retro_unserialize.argtypes=[C.c_void_p,C.c_size_t];core.lib.retro_unserialize.restype=C.c_bool

def snapshot(core):
    configure_state_api(core);n=core.lib.retro_serialize_size()
    if n<16 or n>4000000:raise RuntimeError('Invalid save size')
    buf=C.create_string_buffer(n)
    if not core.lib.retro_serialize(buf,n):raise RuntimeError('Could not save game')
    return buf.raw

def restore(core,data):
    configure_state_api(core)
    if not 16<=len(data)<=4000000:raise ValueError('Invalid save file')
    buf=C.create_string_buffer(data,len(data))
    if not core.lib.retro_unserialize(buf,len(data)):raise ValueError('Could not load save')

def save_game(core):write_atomic(home_dir()/'autosave.state',snapshot(core))
def load_game(core):
    path=home_dir()/'autosave.state'
    if not path.exists():return False
    restore(core,path.read_bytes());return True

def devices():
    result=[]
    for i in range(pygame.joystick.get_count()):
        try:
            j=pygame.joystick.Joystick(i);j.init();result.append(j)
        except pygame.error:pass
    return result

def pressed(entry,keys,mouse,pads):
    try:
        if any(keys[k] for k in entry['key']):return True
        if any(1<=n<=len(mouse) and mouse[n-1] for n in entry['mouse']):return True
        for j in pads:
            for b in entry['pad']:
                if b[0]=='button' and b[1]<j.get_numbuttons() and j.get_button(b[1]):return True
                if b[0]=='axis' and b[1]<j.get_numaxes() and j.get_axis(b[1])*b[2]>.5:return True
                if b[0]=='hat' and b[1]<j.get_numhats() and tuple(j.get_hat(b[1]))==tuple(b[2:4]):return True
    except (IndexError,TypeError,ValueError,pygame.error):pass
    return False

def input_mask(controls,keys,mouse,pads,tick):
    p={a:pressed(controls[a],keys,mouse,pads) for a in ACTIONS};mask=0
    for action,bit in [('UP',4),('DOWN',5),('LEFT',6),('RIGHT',7),('START',3),('SELECT',2)]:
        if p[action]:mask|=1<<bit
    # Repeated small jumps and autofire pulse while the input is held.
    if p['BIG JUMP'] or (p['SMALL JUMP (repeat)'] and tick%12<5):mask|=1<<8
    if p['SINGLE FIRE'] or (p['AUTO FIRE'] and tick%8<4):mask|=1
    return mask

def describe(entry,group):
    try:
        values=entry[['key','pad','mouse'][group]]
        if not values:return '—'
        if group==0:return ', '.join(pygame.key.name(k).upper() for k in values)
        if group==2:return ', '.join('Button '+str(k) for k in values)
        chunks=[]
        for p in values:
            if p[0]=='button':chunks.append('Button '+str(p[1]))
            elif p[0]=='axis':chunks.append('Axis '+str(p[1])+('+' if p[2]>0 else '-'))
            elif p[0]=='hat':chunks.append('D-pad')
        return ' / '.join(chunks)
    except (KeyError,IndexError,TypeError,ValueError):return '?'

def self_test():
    os.environ['SDL_VIDEODRIVER']='dummy';os.environ['SDL_AUDIODRIVER']='dummy'
    pygame.init();pygame.display.set_mode((256,240));core=Core()
    def run(n,mask=0):
        for _ in range(n):core.frame(mask,0);core.samples()
    run(120);run(12,1<<3);run(350)
    core.lib.retro_get_memory_data.argtypes=[C.c_uint];core.lib.retro_get_memory_data.restype=C.POINTER(C.c_uint8)
    r=core.lib.retro_get_memory_data(2)
    assert r[0x770]==1 and r[0x0e]==8,'Game did not start'
    x=r[0x86];run(60,1<<7);assert r[0x86]>x,'Player did not move'
    y=r[0xce];run(12,(1<<7)|(1<<8));assert r[0xce]<y,'Player did not jump'
    state=snapshot(core); before=(r[0x86],r[0xce]);run(30,1<<7)
    with tempfile.TemporaryDirectory() as folder:
        path=Path(folder)/'autosave.state';write_atomic(path,state);restore(core,path.read_bytes())
    assert (r[0x86],r[0xce])==before,'Saved file restore failed'
    frame=pygame.Surface((256,240),0,16,(0xf800,0x07e0,0x001f,0));frame.get_buffer().write(core.framebuffer());assert pygame.transform.scale(frame,(2880,2160)).get_size()==(2880,2160)
    scaled=pygame.Surface((320,240),0,16,(0xf800,0x07e0,0x001f,0));pygame.transform.scale(frame,(320,240),scaled)
    smooth=pygame.Surface((320,240)).convert();pygame.transform.smoothscale(frame.convert(),(320,240),smooth)
    with tempfile.TemporaryDirectory() as folder:
        path=Path(folder)/'thread-save.state'
        def slow_write(path,data):time.sleep(.25);write_atomic(path,data)
        worker=SaveWorker(path,slow_write);t=time.perf_counter();worker.submit(b'first');worker.submit(b'latest')
        assert time.perf_counter()-t<.15,'Save submission blocked on disk'
        assert worker.close(timeout=3) and path.read_bytes()==b'latest','Background save failed'
    class Keys:
        def __getitem__(self,k):return k in (pygame.K_a,pygame.K_x)
    assert input_mask(DEFAULTS,Keys(),(False,)*5,[],0)&(1<<8)
    assert input_mask(DEFAULTS,Keys(),(False,)*5,[],0)&1
    assert not input_mask(DEFAULTS,Keys(),(False,)*5,[],7)&(1<<8)
    assert not input_mask(DEFAULTS,Keys(),(False,)*5,[],7)&1
    class Empty:
        def __getitem__(self,k):return False
    assert input_mask(DEFAULTS,Empty(),(True,False,False,False,False),[],0)&(1<<8)
    class Pad:
        def get_numbuttons(self):return 10
        def get_button(self,n):return n==2
        def get_numaxes(self):return 2
        def get_axis(self,n):return .8 if n==0 else 0
        def get_numhats(self):return 0
    m=input_mask(DEFAULTS,Empty(),(False,)*5,[Pad()],0);assert m&(1<<7) and m&1
    # Check native notification command construction without relying on a desktop session.
    import shutil
    original_run=subprocess.run;original_which=shutil.which;calls=[]
    class Success:returncode=0
    try:
        subprocess.run=lambda cmd,**kw:(calls.append(cmd) or Success())
        shutil.which=lambda name:'/fake/'+name
        assert system_notification('9.0.0') and calls,'Native notification command not dispatched'
        if sys.platform=='win32':assert r'\WindowsPowerShell\v1.0\powershell.exe' in calls[0][-1],'Windows notification ID invalid'
        if sys.platform.startswith('linux'):assert calls[0][0]=='notify-send'
        if sys.platform=='darwin':assert calls[0][0]=='osascript'
    finally:subprocess.run=original_run;shutil.which=original_which
    seen=[];fake_version=['9.0.0']
    def fake_check(out):out.update(text='new',url='https://example.test',entry={'version':fake_version[0]})
    monitor=UpdateMonitor(checker=fake_check,notifier=lambda v:seen.append(v),interval=0)
    monitor.check();monitor.thread.join(3);assert seen==['9.0.0'] and monitor.banner_until>time.monotonic()
    monitor.poll();monitor.thread.join(3);assert seen==['9.0.0'],'Duplicate notification'
    fake_version[0]='9.1.0';monitor.poll();monitor.thread.join(3);assert seen==['9.0.0','9.1.0'],'New update notification missing'
    print('PASS: gameplay, save/restore, 4K scaling, keyboard/mouse/gamepad, repeated actions')
    pygame.quit()
def update_network_test():
    # Exercise the packaged Python/SSL/catalog path as an older version.
    global VERSION
    actual=VERSION;VERSION='1.0.0';result={}
    try:
        update_check(result)
        assert result.get('url') and result.get('entry',{}).get('version') not in (None,'1.0.0'),result
        print('PASS: packaged update check found version',result['entry']['version'])
    finally:VERSION=actual

def main():
    ui_test='--ui-test' in sys.argv
    if ui_test:
        os.environ['SDL_VIDEODRIVER']='dummy';os.environ['SDL_AUDIODRIVER']='dummy'
        test_home=tempfile.TemporaryDirectory(prefix='mario-ui-test-')
        if sys.platform=='win32':os.environ['APPDATA']=test_home.name
        elif sys.platform=='darwin':os.environ['HOME']=test_home.name
        else:os.environ['XDG_CONFIG_HOME']=test_home.name
    pygame.mixer.pre_init(48000,-16,2,1024);pygame.init();pygame.joystick.init()
    screen=pygame.display.set_mode((0,0),pygame.FULLSCREEN)
    pygame.display.set_caption('Super Mario Bros. World')
    core=Core();frame=pygame.Surface((core.w,core.h),0,16,(0xf800,0x07e0,0x001f,0))
    cfg=load_config();controls=cfg['controls'];cheat=cfg['cheats'];pads=devices()
    notice={'text':'Checking for updates...', 'url':''};monitor=UpdateMonitor(status=notice)
    if not ui_test:monitor.check()
    message=''
    try:message='Previous game restored' if load_game(core) else 'New game'
    except (OSError,ValueError,RuntimeError):message='Save could not be loaded';
    clock=pygame.time.Clock();channel=pygame.mixer.Channel(0) if pygame.mixer.get_init() else None
    save_worker=SaveWorker(home_dir()/'autosave.state');pending_audio=bytearray();scaled=None;scaled_key=None
    fps_fn=core.lib.Java_com_midoali_nes_NesCore_nativeFps;fps_fn.argtypes=[C.c_void_p,C.c_void_p];fps_fn.restype=C.c_double
    core_fps=fps_fn(None,None);interval=1.0/(core_fps if 30<core_fps<120 else 60.0988);next_frame=time.perf_counter()
    page=None;selected=0;group=0;waiting=None;fullscreen=True;running=True;tick=0;ui_frame=0;last_save=time.monotonic();buttons=[]
    main_rows=['Resume game','Controls','Cheats','Video & display','Save now','Load saved game','Check for updates','Download update','Exit game']
    cheat_rows=['Infinite lives','Enemy protection','Pit rescue','Back']
    video_rows=['Screen:','Filter:','Toggle fullscreen','Back']
    def persist():
        try:save_config(cfg)
        except OSError:pass
    def save_now():
        nonlocal message,last_save
        try:save_worker.submit(snapshot(core));last_save=time.monotonic();message='Saving in background'
        except (OSError,ValueError,RuntimeError):message='Could not save game'
    def activate():
        nonlocal page,selected,group,waiting,running,screen,fullscreen,message
        if page=='main':
            choice=main_rows[selected]
            if choice=='Resume game':page=None
            elif choice=='Controls':page='controls';selected=0;group=0
            elif choice=='Cheats':page='cheats';selected=0
            elif choice=='Video & display':page='video';selected=0
            elif choice=='Save now':save_now()
            elif choice=='Load saved game':
                try:message='Saved game loaded' if load_game(core) else 'No saved game yet'
                except (OSError,ValueError,RuntimeError):message='Could not load save'
            elif choice=='Check for updates':
                if not monitor.busy:notice.update(text='Checking for updates...',url='');monitor.check()
            elif choice=='Download update':
                if notice.get('url'):notice.update(text='Starting download...',url='');threading.Thread(target=download_update,args=(notice,),daemon=True).start()
                else:message='Check for an available update first'
            elif choice=='Exit game':save_now();running=False
        elif page=='controls':
            if selected<len(ACTIONS):waiting=(ACTIONS[selected],group)
            elif selected==len(ACTIONS):
                cfg['controls']=json.loads(json.dumps(DEFAULTS));controls.clear();controls.update(cfg['controls']);cfg['controls']=controls;persist();message='Controls reset'
            else:page='main';selected=1
        elif page=='cheats':
            if selected==3:page='main';selected=2
            else:
                k=['lives','enemy','pit'][selected];cheat[k]=not cheat[k];persist()
        elif page=='video':
            if selected==0:cfg['display']='fit' if cfg['display']=='fill' else 'fill';persist()
            elif selected==1:cfg['filter']='smooth' if cfg['filter']=='sharp' else 'sharp';persist()
            elif selected==2:
                fullscreen=not fullscreen;screen=pygame.display.set_mode((0,0) if fullscreen else (1024,768),pygame.FULLSCREEN if fullscreen else pygame.RESIZABLE)
            else:page='main';selected=3
    def back():
        nonlocal page,selected,waiting
        if waiting is not None:waiting=None
        elif page=='main':page=None
        elif page:page='main';selected=0
        else:page='main';selected=0
    while running:
        if ui_test:
            ui_frame+=1
            if ui_frame==5:
                monitor.banner_until=time.monotonic()+15;notice['url']='https://example.test'
                pygame.event.post(pygame.event.Event(pygame.MOUSEBUTTONDOWN,button=1,pos=(screen.get_width()//2,20)))
            if ui_frame==7:
                assert page=='main' and selected==7, 'Update banner did not open download menu'
                selected=0;pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_DOWN))
            if ui_frame==8:pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_RETURN))
            if ui_frame==10:
                assert page=='controls';pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_RETURN))
            if ui_frame==12:
                assert waiting==('UP',0);pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_w))
            if ui_frame==14:
                assert controls['UP']['key']==[pygame.K_w];pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_ESCAPE))
            if ui_frame==16:
                assert page=='main';pygame.event.post(pygame.event.Event(pygame.KEYDOWN,key=pygame.K_ESCAPE))
            if ui_frame==18:
                assert page is None;pygame.event.post(pygame.event.Event(pygame.QUIT))
        for e in pygame.event.get():
            if e.type==pygame.QUIT:save_now();running=False;continue
            if e.type in (pygame.JOYDEVICEADDED,pygame.JOYDEVICEREMOVED):pads=devices();continue
            if waiting is not None:
                action,g=waiting; binding=None
                if e.type==pygame.KEYDOWN and e.key==pygame.K_ESCAPE:waiting=None;continue
                if g==0 and e.type==pygame.KEYDOWN:binding=[e.key]
                if g==2 and e.type==pygame.MOUSEBUTTONDOWN:binding=[e.button]
                if g==1 and e.type==pygame.JOYBUTTONDOWN:binding=[['button',e.button]]
                if g==1 and e.type==pygame.JOYAXISMOTION and abs(e.value)>.65:binding=[['axis',e.axis,1 if e.value>0 else -1]]
                if g==1 and e.type==pygame.JOYHATMOTION and e.value!=(0,0):binding=[['hat',e.hat,e.value[0],e.value[1]]]
                if binding is not None:controls[action][['key','pad','mouse'][g]]=binding;waiting=None;persist();message='Control saved'
                continue
            if e.type==pygame.KEYDOWN and e.key==pygame.K_F11:
                fullscreen=not fullscreen;screen=pygame.display.set_mode((0,0) if fullscreen else (1024,768),pygame.FULLSCREEN if fullscreen else pygame.RESIZABLE);continue
            if (e.type==pygame.KEYDOWN and e.key in (pygame.K_F1,pygame.K_ESCAPE)) or (e.type==pygame.JOYBUTTONDOWN and e.button==9):back();continue
            if e.type==pygame.MOUSEBUTTONDOWN and e.button==1:
                w,h=screen.get_size()
                if pygame.Rect(w-62,10,52,52).collidepoint(e.pos):back();continue
                if not page and time.monotonic()<monitor.banner_until and pygame.Rect(max(5,(w-560)//2),12,min(560,w-10),64).collidepoint(e.pos):
                    page='main';selected=7;continue
                if page:
                    for rect,row,col in buttons:
                        if rect.collidepoint(e.pos):
                            selected=row
                            if col is not None:group=col
                            activate();break
                    continue
            if not page:continue
            n={'main':len(main_rows),'controls':len(ACTIONS)+2,'cheats':len(cheat_rows),'video':len(video_rows)}[page]
            key=None
            if e.type==pygame.KEYDOWN:key=e.key
            elif e.type==pygame.JOYBUTTONDOWN:
                if e.button==0:key=pygame.K_RETURN
                elif e.button==1:key=pygame.K_BACKSPACE
            elif e.type==pygame.JOYHATMOTION:
                if e.value[1]>0:key=pygame.K_UP
                elif e.value[1]<0:key=pygame.K_DOWN
                elif e.value[0]<0:key=pygame.K_LEFT
                elif e.value[0]>0:key=pygame.K_RIGHT
            if key==pygame.K_UP:selected=(selected-1)%n
            elif key==pygame.K_DOWN:selected=(selected+1)%n
            elif key in (pygame.K_LEFT,pygame.K_RIGHT) and page=='controls':group=(group+(1 if key==pygame.K_RIGHT else -1))%3
            elif key in (pygame.K_RETURN,pygame.K_KP_ENTER):activate()
            elif key==pygame.K_BACKSPACE:back()
        if not running:break
        if not ui_test:monitor.poll()
        if not page:
            now=time.perf_counter()
            if now < next_frame:
                time.sleep(next_frame-now);now=time.perf_counter()
            # Catch up a few emulation frames if rendering was slow, without
            # repeatedly presenting intermediate frames. Limit runaway catch-up.
            steps=min(4,1+max(0,int((now-next_frame)/interval)))
            if now-next_frame>0.25:next_frame=now
            for _ in range(steps):
                tick+=1;mask=input_mask(controls,pygame.key.get_pressed(),pygame.mouse.get_pressed(5),pads,tick)
                flags=(1 if cheat.get('lives') else 0)|(2 if cheat.get('enemy') else 0)|(4 if cheat.get('pit') else 0)
                core.frame(mask,flags);pending_audio.extend(core.samples());next_frame+=interval
            frame.get_buffer().write(core.framebuffer())
            # Bound queued audio so a hiccup cannot create an ever-growing delay.
            if len(pending_audio)>19200:del pending_audio[:-19200]
            if channel and pending_audio and (not channel.get_busy() or channel.get_queue() is None):
                try:
                    sound=pygame.mixer.Sound(buffer=bytes(pending_audio));pending_audio.clear()
                    if not channel.get_busy():channel.play(sound)
                    else:channel.queue(sound)
                except pygame.error:pending_audio.clear()
            elif not channel:pending_audio.clear()
            if time.monotonic()-last_save>5:save_now()
        else:
            next_frame=time.perf_counter();pending_audio.clear()
        w,h=screen.get_size();screen.fill((7,10,18))
        if cfg['display']=='fill':dw,dh=w,h
        else:dw=min(w,int(h*4/3));dh=min(h,int(dw*3/4))
        dw=max(1,dw);dh=max(1,dh);key=(dw,dh,cfg['filter'])
        if key!=scaled_key:
            scaled=pygame.Surface((dw,dh),0,16,(0xf800,0x07e0,0x001f,0)) if cfg['filter']=='sharp' else pygame.Surface((dw,dh)).convert()
            scaled_key=key
        if cfg['filter']=='smooth':pygame.transform.smoothscale(frame.convert(),(dw,dh),scaled)
        else:pygame.transform.scale(frame,(dw,dh),scaled)
        screen.blit(scaled,((w-dw)//2,(h-dh)//2))
        # Persistent gear. No on-screen game controls.
        gear=pygame.Rect(w-62,10,52,52);pygame.draw.rect(screen,(21,29,46),gear,border_radius=14)
        if notice.get('url'):pygame.draw.circle(screen,(239,74,80),(gear.right-3,gear.top+3),8)
        cx,cy=gear.center;pygame.draw.circle(screen,(230,238,250),(cx,cy),14,4)
        for a in range(0,360,45):
            import math
            dx,dy=math.cos(math.radians(a)),math.sin(math.radians(a));pygame.draw.line(screen,(230,238,250),(cx+dx*13,cy+dy*13),(cx+dx*19,cy+dy*19),4)
        if page:
            shade=pygame.Surface((w,h),pygame.SRCALPHA);shade.fill((5,10,20,195));screen.blit(shade,(0,0))
            k=max(.48,min(w/1180,h/760,1.5));pw=min(w-20,int(1050*k));ph=min(h-20,int(700*k));panel=pygame.Rect((w-pw)//2,(h-ph)//2,pw,ph)
            pygame.draw.rect(screen,(19,28,46),panel,border_radius=max(6,int(18*k)));pygame.draw.rect(screen,(66,83,110),panel,2,border_radius=max(6,int(18*k)))
            font=pygame.font.Font(None,max(15,int(27*k)));small=pygame.font.Font(None,max(13,int(21*k)));title=pygame.font.Font(None,max(20,int(40*k)))
            def text(f,s,x,y,c=(230,237,248)):screen.blit(f.render(str(s),True,c),(int(x),int(y)))
            x=panel.x+24*k;top=panel.y+22*k;text(title,{'main':'PAUSED','controls':'CONTROLS','cheats':'CHEATS','video':'VIDEO & DISPLAY'}[page],x,top)
            text(small,'F1 / Esc: back    •    Arrows + Enter / click    •    F11: fullscreen',x,top+37*k,(143,165,190))
            start=panel.y+86*k;buttons=[]
            if page=='controls':
                rowh=43*k
                text(small,'ACTION',x,start,(117,147,181))
                for c,heading in enumerate(GROUPS):text(small,heading.upper(),panel.x+(360+c*205)*k,start,(117,147,181))
                start+=25*k
                for i,action in enumerate(ACTIONS):
                    y=start+i*rowh;rect=pygame.Rect(panel.x+14*k,y,pw-28*k,rowh-3*k)
                    if i==selected:pygame.draw.rect(screen,(35,53,77),rect,border_radius=max(3,int(7*k)))
                    text(small,action,x,y+10*k)
                    for c in range(3):
                        cell=pygame.Rect(panel.x+(350+c*205)*k,y,195*k,rowh-3*k);buttons.append((cell,i,c))
                        col=(103,224,235) if i==selected and c==group else (200,214,228)
                        text(small,describe(controls[action],c)[:20],cell.x+7*k,y+10*k,col)
                for offset,label in enumerate(['Reset all controls','Back']):
                    i=len(ACTIONS)+offset;y=start+i*rowh;rect=pygame.Rect(panel.x+14*k,y,pw-28*k,rowh-3*k);buttons.append((rect,i,None))
                    if i==selected:pygame.draw.rect(screen,(35,53,77),rect,border_radius=6)
                    text(small,label,x,y+10*k)
                footer=('Press '+GROUPS[waiting[1]]+' input now (Esc cancels)' if waiting else 'Choose a column with Left/Right, then Enter or click. Axes and D-pad supported.')
            else:
                rows=main_rows if page=='main' else cheat_rows if page=='cheats' else video_rows
                rowh=min(51*k,(ph-155*k)/len(rows))
                for i,label in enumerate(rows):
                    y=start+i*rowh;rect=pygame.Rect(panel.x+14*k,y,pw-28*k,rowh-4*k);buttons.append((rect,i,None))
                    if i==selected:pygame.draw.rect(screen,(35,69,92),rect,border_radius=max(3,int(7*k)))
                    if page=='cheats' and i<3:label+='     '+('ON' if cheat[['lives','enemy','pit'][i]] else 'OFF')
                    if page=='video' and i==0:label+='  '+('Fill screen (stretched, no crop)' if cfg['display']=='fill' else 'Original 4:3 (no crop)')
                    if page=='video' and i==1:label+='  '+cfg['filter'].capitalize()
                    text(font,label,x,y+8*k)
                footer=notice['text'] if page=='main' else message
            text(small,footer[:110],x,panel.bottom-35*k,(99,216,232))
        if not page and time.monotonic()<monitor.banner_until:
            bw=min(560,w-10);banner=pygame.Rect(max(5,(w-bw)//2),12,bw,64);pygame.draw.rect(screen,(23,54,78),banner,border_radius=10);pygame.draw.rect(screen,(78,191,209),banner,2,border_radius=10)
            banner_font=pygame.font.Font(None,24);banner_small=pygame.font.Font(None,20)
            screen.blit(banner_font.render('UPDATE AVAILABLE',True,(255,255,255)),(banner.x+14,banner.y+9))
            screen.blit(banner_small.render('Click here or use the gear to download',True,(175,230,237)),(banner.x+14,banner.y+34))
        pygame.display.flip()
        if ui_test and ui_frame==10 and os.environ.get('MARIO_UI_SCREENSHOT'):
            pygame.image.save(screen,os.environ['MARIO_UI_SCREENSHOT'])
        if page:clock.tick(30)
    completed=save_worker.close()
    if ui_test:assert completed and (home_dir()/'autosave.state').is_file(), 'Exit did not save game'
    pygame.quit()

if __name__=='__main__':
    try:
        if '--self-test' in sys.argv:self_test()
        elif '--update-test' in sys.argv:update_network_test()
        else:main()
    except Exception as e:
        print('Fatal:',e,file=sys.stderr);sys.exit(1)
