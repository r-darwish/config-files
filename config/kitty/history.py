import subprocess
import sys
from typing import List
import os
from kittens.tui.handler import result_handler  # type: ignore
from kitty.boss import Boss  # type: ignore


def main(args: List[str]) -> None:
    subprocess.run(
        [
            os.environ.get(
                "EDITOR",
                "/usr/local/bin/nvim",
            ),
            "+set bt=nofile",
        ],
        stdin=sys.stdin,
    )


@result_handler(type_of_input="history")
def handle_result(
    args: List[str], stdin_data: str, target_window_id: int, boss: Boss
) -> None:
    pass
