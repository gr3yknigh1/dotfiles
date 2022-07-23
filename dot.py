#!/usr/bin/env python
from __future__ import annotations
from typing import TYPE_CHECKING
if TYPE_CHECKING:
    from typing import Callable
    from typing import Generator

    LinkFunction = Callable[[str, str, ...], None]
import os
import os.path
import glob
import argparse
import yaml


HOME_DIR = os.path.expanduser("~")

DEFAULT_PKGS_DIR = os.path.join(HOME_DIR, ".dotfiles")


def make_link(src: str, dst: str, link_function: LinkFunction=os.link) -> None:
    link_function(src, dst)


def get_package_item_path(item: str, package_path: str) -> str:
    return os.path.join(package_path, item)


def walk_dir(start_dir: str, exclude: list[str]=None) -> Generator[str, None, None]:
    if exclude is None:
        exclude = []
   
    exclude_globes = []
    for ex in exclude:
        exclude_globes.extend(glob.glob(os.path.join(start_dir, ex)))
    exclude = exclude_globes

    start_dir = os.path.abspath(start_dir)
    directories = [start_dir]
    for directory in directories:
        for item in os.listdir(directory):
            item_path = os.path.join(directory, item)
            
            if item_path in exclude:
                continue

            if os.path.isdir(item_path):
                directories.append(item_path)
            yield item_path


def get_config(package_path: str) -> dict:
    configs = glob.glob(os.path.join(package_path, "*", "*.dotpkg")) \
            + glob.glob(os.path.join(package_path, ".dotpkg"))
    print(configs)
    return load_config(configs[0]) 


def is_config(path: str) -> bool:
    return os.path.isfile(path) and os.path.basename(path) == ".dotpkg"


def load_config(path: str) -> Config:
    with open(path) as f:
        return yaml.safe_load(f)


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("pkg")
    parser.add_argument("-R", "--root-dir", default=HOME_DIR, dest="root_dir")
    parser.add_argument("-P", "--pkg-dir", default=DEFAULT_PKGS_DIR, dest="package_dir")
    parser.add_argument("-n", "--dry-run", default=False, action="store_true", dest="is_dry_run")

    args = parser.parse_args()

    package_name = args.pkg
    packages_dir = args.package_dir
    package_path = os.path.join(packages_dir, package_name)
    is_dry_run = args.is_dry_run

    if not os.path.exists(package_path):
        raise FileExistsError(f"Can't find package with name: '{package_name}'")

    root_dir = args.root_dir

    if not os.path.exists(root_dir):
        raise FileExistsError(f"Can't find root directory: '{root_dir}'")


    config = get_config(package_path)
    print(config)


    for item in walk_dir(package_path, exclude=[".dotpkg"]):
        if os.path.isdir(item):
            continue
        print(">> ", item)

    # for item in walk_dir(package_path):
    #     if os.path.isdir(item):
    #         continue
    #     item_relative_path = item.removeprefix(package_path)[1:]
    #     item_dest_path = os.path.join(root_dir, item_relative_path)
    #     print("-- ", item_dest_path)

    # for item in os.listdir(package_path):
    #     item_path = get_package_item_path(item, package_path)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

