#!/usr/bin/env python3
from __future__ import annotations
import os
import sys
import shutil
import argparse


def get_extentions(path: str) -> list[str]:
    buf: str = ""
    with open(path) as f:
       buf = f.read() 
    return buf.splitlines()


def format_list(ls: list, sep=" ", end="") -> str:
    result = ""

    for i, item in enumerate(ls):
        if i == len(ls) - 1:
            result += str(item) + end
            continue
        result += str(item) + sep

    return result


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("extentions", dest="ext_path")
    parser.add_argument("-d", "--dry-run", action="store_true", dest="is_dry_run")
    args = parser.parse_args()
    is_dry_run = args.is_dry_run
    list_path = args.ext_path

    extentions: list[str] = get_extentions(list_path)
    editor: str | None = None


    if shutil.which("nvim"):
        editor = "nvim"
    elif shutil.which("vim"):
        editor = "vim"
    else:
        raise FileExistsError("nvim or vim not in PATH")

    formated_ext_list = format_list(extentions)
    cmd = f"{editor} -c 'CocInstall -sync {formated_ext_list}|q'"
    action = print if is_dry_run else os.system

    return action(cmd)


if __name__ == "__main__":
    raise SystemExit(main())

