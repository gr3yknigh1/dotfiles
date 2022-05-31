from __future__ import annotations
import argparse
import sys
import os
import os.path
import json
import dataclasses


CONFIG_PATH = os.path.join(os.path.expanduser("~"), ".config/setuper/")


@dataclasses.dataclass
class Package:
    install_hooks: list[Hook]


@dataclasses.dataclass
class Hook:
    cmd_string: str
    requirements: list[Package]


@dataclasses.dataclass
class Setup:
    pre_hooks: list[Hook]
    post_hooks: list[Hook]
    package_manager: str


@dataclasses.dataclass
class Settings:
    global_setup: Setup
    system_setup: dict[str, Setup]


def is_config_valid(path: str) -> bool:
    return True


def read_config(path: str) -> dict:
    return {}


def main() -> int:

    parser = argparse.ArgumentParser()
    parser.add_argument("--config-path", default=CONFIG_PATH, dest="config_path", type=str)
    args = parser.parse_args()
    config_path = args.config_path

    if not os.path.exists(config_path):
        raise FileExistsError(f"Configuration file doesn't exits! Config path: '{config_path}'")

    config = read_config(config_path)

    if not is_config_valid(config):
        raise Exception(f"Configuration file scheme doesn't valid! Config path: '{config_path}'")


    return 0


if __name__ == "__main__":
    raise SystemExit(main())

