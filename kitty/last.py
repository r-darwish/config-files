import subprocess
import sys
import argparse
from time import sleep
from typing import List
from kitty.boss import Boss  # type: ignore
from kittens.tui.handler import result_handler  # type: ignore


class Namespace(argparse.Namespace):
    copy: bool


parser = argparse.ArgumentParser(description="Edit clipboard kitten")
parser.add_argument("-c", "--copy", action="store_true", help="Start with an empty file")


def main(args: List[str]) -> None:
    parsed_args = parser.parse_args(args=args[1:], namespace=Namespace)
    if parsed_args.copy:
        subprocess.run(["/usr/bin/pbcopy"], stdin=sys.stdin)
        print("Text copied to clipboard")
        sleep(1)
    else:
        subprocess.run(["/usr/local/bin/hx"], stdin=sys.stdin)


@result_handler(type_of_input="output")
def handle_result(args: List[str], stdin_data: str, target_window_id: int, boss: Boss) -> None:
    pass
