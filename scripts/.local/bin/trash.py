#!/usr/bin/env python3
from __future__ import annotations
import shutil
import os
import os.path
import argparse


def main() -> int:
    
    parser = argparse.ArgumentParser()
    parser.add_argument("item")
    parser.add_argument("-t", "--trash", default=f"{os.path.expanduser('~')}/.trash")
    parser.add_argument("-d", "--dry-run", action="store_true", dest="is_dry_run")

    args = parser.parse_args()
    item_path = args.item
    trash_path = args.trash
    is_dry_run = args.is_dry_run

    if not os.path.exists(trash_path):
        os.mkdir(trash_path)

    if is_dry_run:
        print(f"mv {item_path} {trash_path}")
    else:
        shutil.move(item_path, trash_path)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

