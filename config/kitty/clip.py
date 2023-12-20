import argparse
import subprocess
import tempfile
import os

from typing import List
from kitty.boss import Boss  # type: ignore


class Namespace(argparse.Namespace):
    empty: bool


parser = argparse.ArgumentParser(description="Edit clipboard kitten")
parser.add_argument("-e", "--empty", action="store_true", help="Start with an empty file")


def main(args: List[str]) -> None:
    parsed_args = parser.parse_args(args=args[1:], namespace=Namespace)

    clipboard = ""
    if not parsed_args.empty:
        clipboard = subprocess.check_output("/usr/bin/pbpaste", shell=False, encoding="utf-8")
    with tempfile.NamedTemporaryFile(mode="w+") as f:
        f.write(clipboard)
        f.flush()
        subprocess.check_call([os.environ.get("EDITOR", "/usr/local/bin/hx"), f.name])
        f.seek(0)
        new_clipboard = f.read()

    if new_clipboard != clipboard and (new_clipboard.strip() != ""):
        proc = subprocess.run("/usr/bin/pbcopy", shell=False, input=new_clipboard.strip(), encoding="utf-8", check=True)
        if proc.returncode != 0:
            input("pbcopy failed")


def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    pass
