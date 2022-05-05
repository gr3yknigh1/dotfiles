#!/usr/bin/env python3
from __future__ import annotations
import os
import sys
import shutil


def get_extentions() -> list[str]:
    buf: str = ""
    with open("./extentions.txt") as f:
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


extentions: list[str] = get_extentions()
editor: str | None = None


if shutil.which("nvim"):
    editor = "nvim"
elif shutil.which("vim"):
    editor = "vim"
else:
    raise FileExistsError("nvim or vim not in PATH")


formated_ext_list = format_list(extentions)
cmd = f"{editor} -c 'CocInstall -sync {formated_ext_list}|q'"

print(cmd)

