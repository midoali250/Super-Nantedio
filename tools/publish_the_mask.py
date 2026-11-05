#!/usr/bin/env python3
"""Update The Mask (SNES) release manifests and RELEASE-ARCHIVE from built CI artifacts."""
import datetime as dt
import hashlib
import json
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ART = Path("/tmp/mask-artifacts")

apk = ART / "the-mask-android" / "The-Mask-SNES-1.0.apk"
win = ART / "The-Mask-Windows-x64" / "The-Mask-Windows-x64.exe"
lin = ART / "The-Mask-linux-x86_64" / "The-Mask-Linux-x86_64.AppImage"
mac = ART / "The-Mask-macos-arm64" / "The-Mask-macOS-arm64.zip"


def info(p: Path):
    if not p.is_file():
        raise FileNotFoundError(f"Missing artifact: {p}")
    b = p.read_bytes()
    return len(b), hashlib.sha256(b).hexdigest()


def main():
    apk_size, apk_sha = info(apk)
    win_size, win_sha = info(win)
    lin_size, lin_sha = info(lin)
    mac_size, mac_sha = info(mac)

    now_utc = dt.datetime.now(dt.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

    android_manifest = {
        "schema_version": 1,
        "game_id": "the-mask",
        "game_name": "The Mask (SNES)",
        "package_name": "com.midoali.snes.themask",
        "version_code": 1,
        "version_name": "1.0",
        "min_android_sdk": 26,
        "apk_url": "https://github.com/midoali250/bitvault-engine/releases/download/the-mask-v1.0/The-Mask-SNES-1.0.apk",
        "apk_sha256": apk_sha,
        "apk_size_bytes": apk_size,
        "release_url": "https://github.com/midoali250/bitvault-engine/releases/tag/the-mask-v1.0",
        "published_at": now_utc,
        "release_notes_ar": "الإصدار الأول 1.0 للعبة The Mask (SNES) على أندرويد مع أيقونة مخصصة ودعم مركز تحديثات BitVaultEngine.",
        "required": False,
    }
    (ROOT / "updates/games/the-mask.json").write_text(
        json.dumps(android_manifest, ensure_ascii=False, indent=2) + "
", encoding="utf-8"
    )

    desktop_manifest = {
        "game": "the-mask-desktop",
        "platforms": {
            "windows": {
                "version": "1.0.0",
                "release_url": "https://github.com/midoali250/bitvault-engine/releases/tag/the-mask-desktop-v1.0.0",
                "download_url": "https://github.com/midoali250/bitvault-engine/releases/download/the-mask-desktop-v1.0.0/The-Mask-Windows-x64.exe",
                "size": win_size,
                "sha256": win_sha,
            },
            "linux": {
                "version": "1.0.0",
                "release_url": "https://github.com/midoali250/bitvault-engine/releases/tag/the-mask-desktop-v1.0.0",
                "download_url": "https://github.com/midoali250/bitvault-engine/releases/download/the-mask-desktop-v1.0.0/The-Mask-Linux-x86_64.AppImage",
                "size": lin_size,
                "sha256": lin_sha,
            },
            "macos": {
                "version": "1.0.0",
                "release_url": "https://github.com/midoali250/bitvault-engine/releases/tag/the-mask-desktop-v1.0.0",
                "download_url": "https://github.com/midoali250/bitvault-engine/releases/download/the-mask-desktop-v1.0.0/The-Mask-macOS-arm64.zip",
                "size": mac_size,
                "sha256": mac_sha,
            },
        },
    }
    (ROOT / "updates/desktop/the-mask.json").write_text(
        json.dumps(desktop_manifest, indent=2) + "
", encoding="utf-8"
    )

    archives = [
        ("Android", "1.0", apk, apk_sha, apk_size),
        ("Windows", "1.0.0", win, win_sha, win_size),
        ("Linux", "1.0.0", lin, lin_sha, lin_size),
        ("macOS", "1.0.0", mac, mac_sha, mac_size),
    ]
    for os_name, ver, src, sha, sz in archives:
        dest_dir = ROOT / "RELEASE-ARCHIVE" / os_name / "The-Mask" / ver
        dest_dir.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dest_dir / src.name)
        if src.suffix == ".AppImage":
            (dest_dir / src.name).chmod(0o755)
        (dest_dir / "SHA256SUMS.txt").write_text(f"{sha}  {src.name}  ({sz} bytes)
", encoding="utf-8")
        print(f"Archived {os_name}: {src.name} ({sz} bytes, sha256={sha})")


if __name__ == "__main__":
    main()
