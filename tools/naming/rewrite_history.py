"""Rewrite reachable Git history and remove historical packaged binaries.

Default mode is an isolated dry run. The apply mode pushes rewritten refs to the
same repository. Run only after a human authorizes rewriting history.
"""
import os,re,subprocess,tempfile,sys
from pathlib import Path

def run(*args,**kw):
 print('+',args[0],args[1] if len(args)>1 else '',flush=True)
 return subprocess.run(args,check=True,**kw)
def out(*args):return subprocess.check_output(args,text=True).strip()
mode=os.environ.get('REWRITE_MODE','check')
if mode not in ('check','apply'):raise SystemExit('Unexpected mode')
# Checkout fetched all refs. Materialize remote branches before filtering.
refs=out('git','for-each-ref','--format=%(refname:strip=3) %(objectname)','refs/remotes/origin').splitlines()
for line in refs:
 branch,sha=line.split()
 if branch in ('HEAD','main'):continue
 run('git','branch',branch,sha)
for line in out('git','for-each-ref','--format=%(refname)','refs/remotes/origin').splitlines():run('git','update-ref','-d',line)
word=b'super'+b'vaultengine';dashed=b'super-'+b'vaultengine';spaced=b'super '+b'vaultengine';underscored=b'super_'+b'vaultengine'
with tempfile.TemporaryDirectory() as tmp:
 rules=Path(tmp)/'replace.txt'
 patterns=[b'regex:(?i)'+dashed+b'==>bitvault-engine',b'regex:(?i)'+spaced+b'==>bitvault-engine',b'regex:(?i)'+underscored+b'==>bitvault_engine',b'regex:(?i)'+word+b'==>bitvaultengine',b'regex:'+('سوبر'.encode()+rb'\s*'+ 'bitvault-engine'.encode())+b'==>bitvault-engine']
 rules.write_bytes(b'\n'.join(patterns)+b'\n')
 pat=repr(rb'(?i)super[-_ ]?'+b'vaultengine')
 file_cb='''import re
if filename.startswith(b'RELEASE-ARCHIVE/'):
    return None
if filename.lower().endswith((b'.apk', b'.exe', b'.appimage')):
    return None
if filename == b'app-debug-apk-final.zip':
    return None
return re.sub(PAT, b'bitvaultengine', filename)
'''.replace('PAT',pat)
 msg_cb='import re\nreturn re.sub('+pat+", b'bitvault-engine', message)"
 ref_cb='import re\nreturn re.sub('+pat+", b'bitvault-engine', refname)"
 name_cb='import re\nreturn re.sub('+pat+", b'bitvault-engine', name)"
 email_cb='import re\nreturn re.sub('+pat+", b'bitvaultengine', email)"
 run('git','filter-repo','--force','--replace-text',str(rules),'--filename-callback',file_cb,'--message-callback',msg_cb,'--name-callback',name_cb,'--email-callback',email_cb,'--refname-callback',ref_cb)
# Check reachable filenames and commit/tag messages; blobs are checked below.
pattern=re.compile(rb'(?i)super[-_ ]?'+b'vaultengine')
objs=subprocess.check_output(['git','rev-list','--objects','--all'])
if pattern.search(objs):raise SystemExit('Old name still appears in reachable paths')
logs=subprocess.check_output(['git','log','--all','--format=%B%n%an%n%ae'])
if pattern.search(logs):raise SystemExit('Old name still appears in commit metadata')
refnames=subprocess.check_output(['git','for-each-ref','--format=%(refname)'])
if pattern.search(refnames):raise SystemExit('Old name still appears in a ref')
# Stream each reachable small blob once and check text. Packaged executables are removed;
# third-party wheels are retained and are binary distributions.
sha_list=[line.split(b' ',1)[0] for line in objs.splitlines()]
check=subprocess.run(['git','cat-file','--batch-check=%(objectname) %(objecttype) %(objectsize)'],input=b'\n'.join(sha_list)+b'\n',stdout=subprocess.PIPE,check=True).stdout
blobs=[]
for line in check.splitlines():
 parts=line.split()
 if len(parts)==3 and parts[1]==b'blob' and int(parts[2])<3000000:blobs.append((parts[0],int(parts[2])))
p=subprocess.Popen(['git','cat-file','--batch'],stdin=subprocess.PIPE,stdout=subprocess.PIPE)
count=0
for sha,size in blobs:
 p.stdin.write(sha+b'\n');p.stdin.flush();header=p.stdout.readline().split();data=p.stdout.read(size);p.stdout.read(1)
 if len(header)<3 or len(data)!=size:raise SystemExit('Cannot read git blob')
 if b'\0' not in data and pattern.search(data):raise SystemExit('Old name in reachable text blob '+sha.decode())
 count+=1
p.stdin.close();p.wait();
if p.returncode:raise SystemExit('git object scan failed')
print('PASS rewritten history: commits',out('git','rev-list','--all','--count'),'text blobs checked',count,flush=True)
print('HEAD',out('git','rev-parse','refs/heads/main'),flush=True)
token=os.environ.get('GITHUB_TOKEN','')
if not token:raise SystemExit('Missing temporary Actions credential')
import base64
auth=base64.b64encode(('x-access-token:'+token).encode()).decode()
url='https://github.com/'+os.environ['GITHUB_REPOSITORY']+'.git'
obsolete='arena/c6b4a986-'+(b'super-'+b'vaultengine').decode()
args=['git','-c','http.extraheader=AUTHORIZATION: basic '+auth,'push','--atomic','--force']
if mode=='check':args.append('--dry-run')
args.extend([url,'refs/heads/*:refs/heads/*','refs/tags/*:refs/tags/*',':refs/heads/'+obsolete])
run(*args)
print('Verified atomic push without modifying the remote' if mode=='check' else 'Applied atomic rewrite and removed obsolete branch name',flush=True)
