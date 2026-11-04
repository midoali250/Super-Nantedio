#!/usr/bin/env python3
"""Validate update manifests; optionally download and hash release assets."""
import argparse
import datetime as dt
import hashlib
import json
from pathlib import Path
import re
import sys
from urllib.parse import urlparse
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parents[1]
MANIFESTS = ROOT / 'updates' / 'games'
GAME_ID = re.compile(r'^[a-z0-9]+(?:-[a-z0-9]+)*$')
PACKAGE = re.compile(r'^[a-zA-Z][a-zA-Z0-9_]*(?:\.[a-zA-Z][a-zA-Z0-9_]*)+$')
HASH = re.compile(r'^[0-9a-f]{64}$')


def validate(path, check_downloads):
    d = json.loads(path.read_text(encoding='utf-8'))
    assert isinstance(d, dict) and d.get('schema_version') == 1, 'invalid schema_version'
    game_id = d.get('game_id', '')
    assert isinstance(game_id, str) and GAME_ID.fullmatch(game_id) and path.stem == game_id, 'invalid game_id'
    for name in ('game_name', 'version_name', 'release_notes_ar'):
        assert isinstance(d.get(name), str) and d[name].strip(), f'invalid {name}'
    assert isinstance(d.get('package_name'), str) and PACKAGE.fullmatch(d['package_name']), 'invalid package_name'
    for name in ('version_code', 'min_android_sdk', 'apk_size_bytes'):
        assert type(d.get(name)) is int and d[name] > 0, f'invalid {name}'
    assert d['apk_size_bytes'] <= 500_000_000, 'apk too large'
    assert isinstance(d.get('apk_sha256'), str) and HASH.fullmatch(d['apk_sha256']), 'invalid apk_sha256'
    assert type(d.get('required')) is bool, 'invalid required'
    for name in ('apk_url', 'release_url'):
        assert isinstance(d.get(name), str), f'invalid {name}'
        u = urlparse(d[name])
        assert u.scheme == 'https' and u.hostname == 'github.com' and not u.username and not u.password, f'invalid {name}'
        assert u.path.startswith('/midoali250/bitvault-engine/releases/'), f'unexpected {name} path'
    assert d['apk_url'].endswith('.apk'), 'apk_url must point to an APK'
    date = d.get('published_at', '')
    assert isinstance(date, str) and date.endswith('Z'), 'published_at must be UTC'
    dt.datetime.fromisoformat(date[:-1] + '+00:00')
    if check_downloads:
        req = Request(d['apk_url'], headers={'User-Agent': 'BitVaultEngine-update-validator/1'})
        sha = hashlib.sha256()
        size = 0
        with urlopen(req, timeout=60) as response:
            while chunk := response.read(1024 * 1024):
                size += len(chunk)
                assert size <= d['apk_size_bytes'], 'download exceeds declared size'
                sha.update(chunk)
        assert size == d['apk_size_bytes'], 'size mismatch'
        assert sha.hexdigest() == d['apk_sha256'], 'SHA-256 mismatch'
    return d['package_name']


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check-downloads', action='store_true')
    args = parser.parse_args()
    files = sorted(MANIFESTS.glob('*.json'))
    if not files:
        sys.exit('No game manifests found')
    packages = set()
    for path in files:
        try:
            package = validate(path, args.check_downloads)
            if package in packages:
                raise ValueError('duplicate package_name')
            packages.add(package)
            print('OK', path.relative_to(ROOT))
        except Exception as e:
            sys.exit(f'ERROR {path.name}: {e}')


if __name__ == '__main__':
    main()
