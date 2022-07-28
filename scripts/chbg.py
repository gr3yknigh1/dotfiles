#!/usr/bin/env python
import sys
import os
import os.path


def main():
    argv = sys.argv
    if len(argv) != 2:
        raise Exception("[Error]: Povide path to image")

    image_path = os.path.abspath(argv[1])

    if not os.path.exists(image_path):
        raise FileExistsError(f"File doesn't exists: {image_path}")

    cmd = f"feh --no-fehbg --bg-fill {image_path}"
    os.system(cmd)

    fehrc_path = os.path.join(os.path.expanduser("~"), ".wallpaper")
    mode = "w" 
    if not os.path.exists(fehrc_path):
        mode = "x"

    with open(fehrc_path, mode=mode) as file:
        file.write(cmd)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())

