#!/usr/bin/env python
import subprocess
import os.path
import json

import ensurepip
ensurepip.bootstrap()


HOME_DIR = os.path.expanduser('~')


with open("packages.json") as f:
    packages: dict = json.load(f)

subprocess.run(["sudo", "pacman", "-Sy", *packages.get("pacman", [])])
subprocess.run(["python", "-m", "ensurepip"])
subprocess.run(["pip3", "install", "--upgrade", "pip"])
subprocess.run(["pip", "install", *packages.get("pip", [])])
subprocess.run(["sudo", "npm", "install", "--global", *packages.get("npm", [])])
subprocess.run(["sh", f"{HOME_DIR}/.dotfiles/scripts/install-rustup.sh"])
subprocess.run(["sh", f"{HOME_DIR}/.dotfiles/scripts/install-omf.sh"])
subprocess.run(["sh", f"{HOME_DIR}/.dotfiles/scripts/install-tpm.sh"])
subprocess.run(["fish", "omf", "install", "nai"])
subprocess.run(["sh", f"{HOME_DIR}/.dotfiles/scripts/setup-ssh.sh"])

for pkg in packages.get("stow", []):
    subprocess.run([
        "stow", "-S", pkg
        ])

subprocess.run(["sh", f"{HOME_DIR}/.dotfiles/scripts/chsh2fish.sh"])
