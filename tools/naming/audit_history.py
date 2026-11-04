import subprocess,re,sys
pattern=re.compile(rb'(?i)'+b'nan'+b'tedio')
arabic=re.compile((r'(?:'+'نان'+'تيدو|'+ 'نان'+'تديو'+')').encode())
def found(data):return bool(pattern.search(data) or arabic.search(data))
def out(*args):return subprocess.check_output(args)
objects=out('git','rev-list','--objects','--all')
if found(objects):raise SystemExit('Naming match in reachable paths')
if found(out('git','log','--all','--format=%B%n%an%n%ae%n%cn%n%ce')):raise SystemExit('Naming match in commit metadata')
if found(out('git','for-each-ref','--format=%(refname)')):raise SystemExit('Naming match in ref names')
sha=[line.split(b' ',1)[0] for line in objects.splitlines()]
check=subprocess.run(['git','cat-file','--batch-check=%(objectname) %(objecttype) %(objectsize)'],input=b'\n'.join(sha)+b'\n',stdout=subprocess.PIPE,check=True).stdout
blobs=[];large=0
for line in check.splitlines():
 p=line.split()
 if len(p)==3 and p[1]==b'blob':
  if int(p[2])<3000000:blobs.append((p[0],int(p[2])))
  else:large+=1
proc=subprocess.Popen(['git','cat-file','--batch'],stdin=subprocess.PIPE,stdout=subprocess.PIPE)
for sha,size in blobs:
 proc.stdin.write(sha+b'\n');proc.stdin.flush();header=proc.stdout.readline().split();data=proc.stdout.read(size);proc.stdout.read(1)
 if len(header)<3 or len(data)!=size:raise SystemExit('Cannot read historical blob')
 if b'\0' not in data and found(data):raise SystemExit('Naming match in historical text blob '+sha.decode())
proc.stdin.close();proc.wait()
if proc.returncode:raise SystemExit('Object scan failed')
print('PASS reachable history: commits',out('git','rev-list','--all','--count').decode().strip(),'small blobs checked',len(blobs),'large binary blobs not inspected',large)
