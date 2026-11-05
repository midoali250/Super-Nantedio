"""CI-only cross compilation from the engine's pinned core registry. No ROMs."""
import json,os,pathlib,shutil,subprocess,urllib.request
root=pathlib.Path.cwd();registry=json.loads((root/'engine-source/engine/cores/registry.json').read_text());ndk=pathlib.Path(os.environ['ANDROID_SDK_ROOT'])/'ndk/27.2.12479018';tool=ndk/'toolchains/llvm/prebuilt/linux-x86_64/bin'
for system in ('NES',):
 c=[v for v in registry['cores'] if v['system']==system];assert len(c)==1;c=c[0]
 for abi,triple in [('arm64-v8a','aarch64-linux-android'),('x86_64','x86_64-linux-android')]:
  dest=root/('core-'+system+'-'+abi);dest.mkdir()
  subprocess.run(['git','init','-q',str(dest)],check=True);subprocess.run(['git','-C',str(dest),'remote','add','origin','https://github.com/'+c['repository']+'.git'],check=True)
  subprocess.run(['git','-C',str(dest),'fetch','--depth=1','origin',c['revision']],check=True);subprocess.run(['git','-C',str(dest),'checkout','--detach','FETCH_HEAD'],check=True)
  if (dest/'.gitmodules').is_file():subprocess.run(['git','-C',str(dest),'submodule','update','--init','--recursive'],check=True)
  assert subprocess.check_output(['git','-C',str(dest),'rev-parse','HEAD'],text=True).strip()==c['revision']
  subprocess.run(['make','-C',str(dest/c['make_dir']),'-f',c['makefile'],'-j2','platform=unix','CC='+str(tool/(triple+'24-clang')),'CXX='+str(tool/(triple+'24-clang++')),'AR='+str(tool/'llvm-ar')],check=True)
  libs=list(dest.rglob('*_libretro.so'));assert len(libs)==1,libs
  out=root/'app/src/main/jniLibs'/abi;out.mkdir(parents=True,exist_ok=True);shutil.copy2(libs[0],out/('lib'+libs[0].name))
  runtime=ndk/'toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib'/triple/'libc++_shared.so';shutil.copy2(runtime,out/'libc++_shared.so')
  if system=='NES' and abi=='arm64-v8a':shutil.copy2(dest/'src/drivers/libretro/libretro-common/include/libretro.h',root/'app/src/main/cpp/libretro.h')
  notices=[p for p in dest.iterdir() if p.is_file() and p.name.lower().startswith(('license','copying'))];assert notices
  outnotice=root/'app/src/main/assets/third-party-notices';outnotice.mkdir(parents=True,exist_ok=True)
  for p in notices:shutil.copy2(p,outnotice/(system+'-'+p.name))
  (outnotice/(system+'-source.txt')).write_text(c['repository']+' @ '+c['revision']+'\n')
  print('Built',system,abi,c['revision'],flush=True)
