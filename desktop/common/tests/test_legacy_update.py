"""Exercise the exact published 1.0.0 desktop updater against the live catalog."""
import hashlib,importlib.util,os,pathlib,tempfile,urllib.request
with tempfile.TemporaryDirectory() as tmp:
    os.environ['HOME']=tmp
    os.environ['USERPROFILE']=tmp
    url='https://raw.githubusercontent.com/midoali250/bitvault-engine/3dcb56ad581bf5cca7e5b00619d25212e1927a01/desktop/common/app.py'
    src=urllib.request.urlopen(url,timeout=30).read()
    p=pathlib.Path(tmp)/'legacy.py';p.write_bytes(src)
    spec=importlib.util.spec_from_file_location('legacy',p);legacy=importlib.util.module_from_spec(spec);spec.loader.exec_module(legacy)
    assert legacy.VERSION=='1.0.0'
    result={};legacy.update_check(result)
    assert result.get('url') and result.get('entry',{}).get('version')=='1.1.0',result
    entry=result['entry'];legacy.download_update(result)
    assert result['text'].startswith('Verified update saved in Downloads:'),result
    files=list((pathlib.Path(tmp)/'Downloads').iterdir());assert len(files)==1
    data=files[0].read_bytes();assert len(data)==entry['size'] and hashlib.sha256(data).hexdigest()==entry['sha256']
    print('PASS: published 1.0.0 updater found and downloaded verified 1.1.0:',files[0].name)
