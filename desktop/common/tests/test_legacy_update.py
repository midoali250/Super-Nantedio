"""Exercise the exact published updaters against the live catalog after the repository rename."""
import hashlib,importlib.util,os,pathlib,tempfile,urllib.request
versions=[('1.0.0','3dcb56ad581bf5cca7e5b00619d25212e1927a01'),('1.1.0','f2c8473328296716dd63436724bd7a28c7020d88'),('1.2.0','ac975d717ca1e90e44c5ce0482c704f0c306bd7b'),('1.3.0','5d6398afc16dc9ebe6f0cd35ba92c56361942014')]
expected=os.environ.get('EXPECTED_VERSION','1.3.1')
for version,commit in versions:
    with tempfile.TemporaryDirectory() as tmp:
        os.environ['HOME']=tmp;os.environ['USERPROFILE']=tmp
        url=f'https://raw.githubusercontent.com/midoali250/bitvault-engine/{commit}/desktop/common/app.py'
        src=urllib.request.urlopen(url,timeout=30).read()
        p=pathlib.Path(tmp)/'legacy.py';p.write_bytes(src)
        spec=importlib.util.spec_from_file_location('legacy_'+version.replace('.','_'),p);legacy=importlib.util.module_from_spec(spec);spec.loader.exec_module(legacy)
        assert legacy.VERSION==version
        result={};legacy.update_check(result)
        assert result.get('url') and result.get('entry',{}).get('version')==expected,result
        entry=result['entry'];legacy.download_update(result)
        assert result['text'].startswith('Verified update saved in Downloads:'),result
        files=list((pathlib.Path(tmp)/'Downloads').iterdir());assert len(files)==1
        data=files[0].read_bytes();assert len(data)==entry['size'] and hashlib.sha256(data).hexdigest()==entry['sha256']
        print('PASS: published',version,'updater found and verified',expected,files[0].name)
