import sys,zipfile,hashlib,pathlib
needle=(b'nan'+b'tedio').lower()
for filename in sys.argv[1:]:
 path=pathlib.Path(filename);hits=[]
 with zipfile.ZipFile(path) as z:
  for n in z.namelist():
   b=z.read(n).lower()
   if needle in b or needle.decode().encode('utf-16le') in b or needle in n.lower().encode():hits.append(n)
 if hits:raise SystemExit('Brand strings found in '+str(path)+': '+str(hits))
 print('PASS APK content audit',path.name,'bytes',path.stat().st_size,'SHA256',hashlib.sha256(path.read_bytes()).hexdigest())
