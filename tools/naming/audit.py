import os,re,subprocess,json,collections
patterns=[re.compile(b'super[-_ ]?vaultengine',re.I),re.compile('سوبر\\s*bitvault-engine'.encode())]
def hit(b):return any(p.search(b) for p in patterns)
paths=subprocess.check_output(['git','ls-files','-z']).decode().split('\0');report=[];binary=[]
for path in paths:
 if not path or not os.path.isfile(path):continue
 size=os.path.getsize(path); p=hit(path.encode());
 if size>2000000:
  if p:report.append({'path':path,'match':'path','size':size})
  continue
 try:data=open(path,'rb').read()
 except OSError:continue
 if b'\0' in data:
  if p or hit(data):binary.append({'path':path,'path_match':p,'content_match':hit(data),'size':size})
 elif p or hit(data):
  matches=[]
  for i,line in enumerate(data.splitlines(),1):
   if hit(line):matches.append(i)
  report.append({'path':path,'path_match':p,'lines':matches[:25],'size':size})
print('TEXT_OR_PATH_MATCHES',len(report));print('SMALL_BINARY_MATCHES',len(binary))
for x in report:print(json.dumps(x,ensure_ascii=False))
for x in binary:print('BINARY',json.dumps(x,ensure_ascii=False))
with open('brand-audit.json','w',encoding='utf8') as f:json.dump({'text_or_path':report,'binary':binary},f,ensure_ascii=False,indent=2)
