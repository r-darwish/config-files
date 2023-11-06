import subprocess
import sys
from typing import List
from kitty.boss import Boss


def main(args: List[str]) -> str:
    subprocess.run(["/usr/local/bin/hx"], stdin=sys.stdin)


from kittens.tui.handler import result_handler
@result_handler(type_of_input='output')
def handle_result(args: List[str], stdin_data: str, target_window_id: int, boss: Boss) -> None:
    pass
