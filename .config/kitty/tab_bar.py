"""Custom tab bar with wiki tab on the right side"""
# pyright: reportMissingImports=false

from kitty.fast_data_types import Screen, get_options
from kitty.tab_bar import (DrawData, ExtraData, TabBarData, as_rgb,
                           draw_title)
from kitty.utils import color_as_int

opts = get_options()

def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    """Draw regular tabs on the left, wiki tab on the right"""
    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)
    
    # Wiki tab gets drawn on the right side
    wiki_tab_length = 6  # Length of " wiki "
    if tab.title != 'wiki':
        # Draw regular tab title normally
        draw_title(draw_data, screen, tab, index)
    else:
        # Draw wiki tab on the right side using theme colors
        # Colors are set by the wiki kitten using theme-based values
        save_x = screen.cursor.x
        screen.cursor.x = screen.columns - wiki_tab_length
        draw_title(draw_data, screen, tab, index)
        screen.cursor.x = save_x
    
    trailing_spaces = min(max_title_length - 1, draw_data.trailing_spaces)
    max_title_length -= trailing_spaces
    extra = screen.cursor.x - before - max_title_length
    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.draw("…")
    
    if trailing_spaces:
        screen.draw(" " * trailing_spaces)
    
    screen.cursor.bold = screen.cursor.italic = False
    screen.cursor.fg = 0
    if not is_last:
        screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
        screen.draw(draw_data.sep)
    screen.cursor.bg = 0
    return screen.cursor.x

def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    """Main draw function"""
    # Draw the tab (wiki tab will be positioned on the right automatically)
    end = _draw_left_status(
        draw_data, screen, tab, before, max_title_length, 
        index, is_last, extra_data
    )
    
    return end 