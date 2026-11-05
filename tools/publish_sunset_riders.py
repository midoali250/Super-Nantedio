#!/usr/bin/env python3
"""Update رعاة البقر (Sunset Riders) release manifests and RELEASE-ARCHIVE from built CI artifacts."""
import datetime as dt
import hashlib
import json
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ART = Path("/tmp/sr-artifacts")

apk = ART / "sunset-riders-android" / "Sunset-Riders-1.0.apk"
win = ART / "Sunset-Riders-Windows-x64" / "Sunset-Riders-Windows-x64.exe"
lin = ART / "Sunset-Riders-linux-x86_64" / "Sunset-Riders-Linux-x86_64.AppImage"
mac = ART / "Sunset-Riders-macos-arm64" / "Sunset-Riders-macOS-arm64.zip"


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
        "game_id": "sunset-riders",
        "game_name": "رعاة البقر (Sunset Riders)",
        "package_name": "com.midoali.snes.sunsetriders",
        "version_code": 1,
        "version_name": "1.0",
        "min_android_sdk": 26,
        "apk_url": "https://github.com/midoali250/bitvault-engine/releases/download/sunset-riders-v1.0/Sunset-Riders-1.0.apk",
        "apk_sha256": apk_sha,
        "apk_size_bytes": apk_size,
        "release_url": "https://github.com/midoali250/bitvault-engine/releases/tag/sunset-riders-v1.0",
        "published_at": now_utc,
        "release_notes_ar": "إصدار لعبة رعاة البقر (Sunset Riders) بجودة صورة فائقة 2x HD Scale2x، وشاشة عريضة بعرض شاشة الموبايل، وعصاية تحكم حرة 360°، وقائمة أكواد الغش (Cheats)، وزر About داخل الضبط.",
        "required": False,
    }
    (ROOT / "updates/games/sunset-riders.json").write_text(
        json.dumps(android_manifest, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )

    desktop_manifest = {
        "game": "sunset-riders-desktop",
        "platforms": {
            "windows": {
                "version": "1.0.0",
                "release_url": "https://github.com/midoali250/bitvault-engine/releases/tag/sunset-riders-desktop-v1.0.0",
                "download_url": "https://github.com/midoali250/bitvault-engine/releases/download/sunset-riders-desktop-v1.0.0/Sunset-Riders-Windows-x64.exe",
                "size": win_size,
                "sha256": win_sha,
            },
            "linux": {
                "version": "1.0.0",
                "release_url": "https://github.com/midoali250/bitvault-engine/releases/tag/sunset-riders-desktop-v1.0.0",
                "download_url": "https://github.com/midoali250/bitvault-engine/releases/download/sunset-riders-desktop-v1.0.0/Sunset-Riders-Linux-x86_64.AppImage",
                "size": lin_size,
                "sha256": lin_sha,
            },
            "macos": {
                "version": "1.0.0",
                "release_url": "https://github.com/midoali250/bitvault-engine/releases/tag/sunset-riders-desktop-v1.0.0",
                "download_url": "https://github.com/midoali250/bitvault-engine/releases/download/sunset-riders-desktop-v1.0.0/Sunset-Riders-macOS-arm64.zip",
                "size": mac_size,
                "sha256": mac_sha,
            },
        },
    }
    (ROOT / "updates/desktop/sunset-riders.json").write_text(
        json.dumps(desktop_manifest, indent=2) + "\n",
        encoding="utf-8",
    )

    archives = [
        ("Android", "1.0", apk, apk_sha, apk_size),
        ("Windows", "1.0.0", win, win_sha, win_size),
        ("Linux", "1.0.0", lin, lin_sha, lin_size),
        ("macOS", "1.0.0", mac, mac_sha, mac_size),
    ]
    for os_name, ver, src, sha, sz in archives:
        dest_dir = ROOT / "RELEASE-ARCHIVE" / os_name / "Sunset-Riders" / ver
        dest_dir.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src, dest_dir / src.name)
        if src.suffix == ".AppImage":
            (dest_dir / src.name).chmod(0o755)
        (dest_dir / "SHA256SUMS.txt").write_text(
            f"{sha}  {src.name}  ({sz} bytes)\n", encoding="utf-8"
        )
        print(f"Archived {os_name}: {src.name} ({sz} bytes, sha256={sha})")


if __name__ == "__main__":
    main()
