#!/bin/env python3
from __future__ import annotations
import argparse
import datetime
import logging
import os
import os.path
import shutil
from dataclasses import dataclass

from PIL import Image
from tqdm import tqdm


logging.basicConfig(
    format="%(name)s :: [%(levelname)s]: %(message)s",
    level=int(os.environ.get("LOG_LEVEL", logging.DEBUG)),
)
logging.getLogger("PIL").setLevel(logging.ERROR)
log = logging.getLogger("photobox")


@dataclass
class GlobalArgs:
    is_dry_run: bool

@dataclass
class Mv2DirsArgs(GlobalArgs):
    files: list[str]


def _get_image_dest(file_path: str, is_dry_run: bool) -> str:
    with Image.open(file_path) as image:
        date = image.getexif()[306]

    folder_name = datetime.datetime.strptime(date, '%Y:%m:%d %H:%M:%S').strftime('%Y.%m')
    folder_path = os.path.join(os.curdir, folder_name)

    if not os.path.exists(folder_path):

        if is_dry_run:
            log.debug(f">> mkdir: {folder_path}")
        else:
            os.makedirs(folder_path, exist_ok=True)

    return os.path.join(folder_path, os.path.basename(file_path))


def _mv2dirs_subcmd(args: Mv2DirsArgs) -> int:

    if len(args.files) == 0:
        log.error("No files provided")
        return 1

    already_moved = []

    if args.is_dry_run:
        files_iter = lambda items: (item for item in items)
    else:
        files_iter = tqdm

    for file_path in files_iter(args.files):

        image_dest = _get_image_dest(file_path, args.is_dry_run)

        if os.path.exists(image_dest):
            already_moved.append(image_dest)
            continue

        if args.is_dry_run:
            log.debug(f">> mv {file_path!r} -> {image_dest!r}")
        else:
            shutil.move(file_path, image_dest)

    if len(already_moved) != 0:
        log.warning(f"Already moved: {already_moved!r}")

    return 0


parser = argparse.ArgumentParser()
parser.add_argument("-n", "--dry-run", action="store_true", dest="is_dry_run")

_subparsers = parser.add_subparsers(required=True)

_mv2dirs_parser = _subparsers.add_parser("mv2dirs")
_mv2dirs_parser.add_argument("files", type=str, nargs="*")
_mv2dirs_parser.set_defaults(func=_mv2dirs_subcmd)

_renamebydate_parser = _subparsers.add_parser("rename")

def main() -> int:
    args = parser.parse_args()
    log.debug(f"Args: {args!r}")

    try:
        ret: int = args.func(args)
    except Exception:
        return 1
    return ret


if __name__ == "__main__":
    raise SystemExit(main())
