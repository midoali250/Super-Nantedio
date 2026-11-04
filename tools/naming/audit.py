import os,re,subprocess,json
p=re.compile(b"(?i)"+b"nan"+b"tedio")
arabic=re.compile((r"(?:"+"نان"+"تيدو|"+"نان"+"تديو"+r")").encode())
def hit(b):return bool(p.search(b) or arabic.search(b))
paths=subprocess.check_output(["git","ls-files","-z"]).decode().split("\0");found=[]
for path in paths:
 if not path or not os.path.isfile(path):continue
 if hit(path.encode()):found.append(path+" (path)")
 if os.path.getsize(path)>2000000:continue
 data=open(path,"rb").read()
 if b"\0" not in data and hit(data):found.append(path+" (content)")
print("Naming matches:",len(found))
for p in found:print(p)
with open("brand-audit.json","w") as f:json.dump({"matches":found},f,indent=2)
if found:raise SystemExit("Naming audit failed")
