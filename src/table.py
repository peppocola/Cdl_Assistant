import pandas as pd
from rich import box
from rich.table import Table, Column

COLORS = {"red", "green", "yellow", "blue", "magenta", "cyan", "white"}
BRIGHT_COLORS = set(['bright_' + c for c in list(COLORS)])


def create_rich_table(table: pd.DataFrame, title: str, box_style: box = box.ROUNDED, show_lines: bool = True):
    colors = BRIGHT_COLORS.copy()
    header = [Column(header=Name, justify='right', style=colors.pop()) for Name in table.columns]
    rich_table = Table(title=title, box=box_style, header_style='bold', show_lines=show_lines, title_style='bold', *header)
    for row in table.values:
        rich_table.add_row(*[str(x) for x in row])
    return rich_table
