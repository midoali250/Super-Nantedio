"""Make private in-game previews from ROMs already obtained by the caller.
No games, screenshots or game catalogs are included in the engine repository.
"""
import json,os,sys
from pathlib import Path
os.environ.setdefault('SDL_VIDEODRIVER','dummy');os.environ.setdefault('SDL_AUDIODRIVER','dummy')
import pygame
from libretro_host import LibretroHost
from game_session import frame_surface

def main():
    if len(sys.argv)!=5:raise SystemExit('usage: thumbnail_builder.py CATALOG ROM_DIR CORE_DIR OUTPUT_DIR')
    catalog,roms,cores,out=map(Path,sys.argv[1:]);rows=json.loads(catalog.read_text(encoding='utf8'))['games'];out.mkdir(parents=True,exist_ok=True)
    pygame.init();pygame.display.set_mode((1,1))
    suffix='.dll' if sys.platform=='win32' else '.dylib' if sys.platform=='darwin' else '.so'
    for i,row in enumerate(rows,1):
        system=row['system'];ext='.nes' if system=='NES' else '.smc' if system=='SNES' else None
        if not ext:raise ValueError('unsupported game')
        core=cores/(('fceumm_libretro' if system=='NES' else 'snes9x_libretro')+suffix)
        rom=roms/(row['source_id']+ext)
        with LibretroHost(core,rom) as host:
            if host.game_hash!=row['rom_sha256']:raise ValueError('wrong game hash')
            best=None;best_score=-1
            # Prefer a varied visible frame over a blank intro. This is a heuristic,
            # not a claim that every screenshot shows gameplay or box art.
            for n in range(720):
                host.buttons={3} if n in (120,360,600) else set();host.run_frame()
                if n in (119,239,359,479,599,719):
                    candidate=frame_surface(host)
                    if candidate is not None:
                        reduced=pygame.transform.scale(candidate,(32,24))
                        raw=pygame.image.tobytes(reduced,'RGB')
                        colors={raw[j:j+3] for j in range(0,len(raw),3)}
                        score=len(colors)+sum(raw)/(len(raw)*255)
                        if score>best_score:best_score=score;best=candidate
            if best is None:raise RuntimeError('no video for '+row['source_id'])
            pygame.image.save(best,str(out/(row['source_id']+'.png')))
        print('Generated in-game screenshot',i,'/',len(rows),flush=True)
    pygame.quit()
if __name__=='__main__':main()
