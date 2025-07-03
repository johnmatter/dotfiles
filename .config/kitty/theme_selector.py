#!/usr/bin/env .venv/bin/python

import os
import re
from pathlib import Path
from blessed import Terminal

def parse_theme_colors(theme_file):
  """Parse colors from a kitty theme file."""
  colors = {}
  try:
    with open(theme_file, 'r') as f:
      for line in f:
        line = line.strip()
        if line and not line.startswith('#'):
          match = re.match(r'(\w+)\s+#([0-9a-fA-F]{6})', line)
          if match:
            colors[match.group(1)] = match.group(2)
  except Exception:
    pass
  return colors

def get_themes():
  """Get all theme files from the themes directory."""
  themes_dir = Path("kitty-themes/themes")
  if not themes_dir.exists():
    return []
  
  themes = []
  for theme_file in themes_dir.glob("*.conf"):
    colors = parse_theme_colors(theme_file)
    if colors:
      themes.append((theme_file.stem, theme_file, colors))
  
  return sorted(themes)

def apply_theme(theme_file):
  """Apply the selected theme by updating the symlink."""
  theme_path = f"./kitty-themes/themes/{theme_file.name}"
  try:
    if os.path.exists("theme.conf"):
      os.remove("theme.conf")
    os.symlink(theme_path, "theme.conf")
    return True
  except Exception:
    return False

def main():
  term = Terminal()
  themes = get_themes()
  
  if not themes:
    print("No themes found in kitty-themes/themes/")
    return
  
  selected = 0
  scroll_offset = 0
  
  with term.fullscreen(), term.cbreak(), term.hidden_cursor():
    while True:
      print(term.clear)
      
      # Header
      print(term.move_y(1) + term.center(term.bold("Kitty Theme Selector")))
      print(term.move_y(2) + term.center("↑/↓ to navigate, Enter to select, q to quit"))
      
      # Calculate visible area
      start_y = 4
      max_visible_items = term.height - 8 - start_y
      
      # Update scroll offset to keep selected item visible
      if selected < scroll_offset:
        scroll_offset = selected
      elif selected >= scroll_offset + max_visible_items:
        scroll_offset = selected - max_visible_items + 1
      
      # Theme list
      for i in range(max_visible_items):
        theme_index = scroll_offset + i
        if theme_index >= len(themes):
          break
          
        name, _, colors = themes[theme_index]
        y = start_y + i
        
        if theme_index == selected:
          line = f"> {name}"
          print(term.move_y(y) + term.reverse(line))
        else:
          line = f"  {name}"
          print(term.move_y(y) + line)
      
      # Show scroll indicators
      if scroll_offset > 0:
        print(term.move_y(start_y - 1) + term.center("↑ more themes above ↑"))
      if scroll_offset + max_visible_items < len(themes):
        print(term.move_y(start_y + max_visible_items) + term.center("↓ more themes below ↓"))
      
      # Preview colors for selected theme
      if selected < len(themes):
        _, _, colors = themes[selected]
        preview_y = term.height - 6
        
        print(term.move_y(preview_y) + term.center(term.bold("Color Preview:")))
        
        # Show main colors
        color_line = ""
        for color_name in ['background', 'foreground', 'cursor']:
          if color_name in colors:
            hex_color = colors[color_name]
            try:
              r, g, b = int(hex_color[0:2], 16), int(hex_color[2:4], 16), int(hex_color[4:6], 16)
              color_line += term.color_rgb(r, g, b)("███") + " "
            except ValueError:
              color_line += "███ "
        
        print(term.move_y(preview_y + 1) + term.center(color_line))
        
        # Show color palette
        palette_line = ""
        for i in range(8):
          color_key = f"color{i}"
          if color_key in colors:
            hex_color = colors[color_key]
            try:
              r, g, b = int(hex_color[0:2], 16), int(hex_color[2:4], 16), int(hex_color[4:6], 16)
              palette_line += term.color_rgb(r, g, b)("██")
            except ValueError:
              palette_line += "██"
        
        print(term.move_y(preview_y + 2) + term.center(palette_line))
      
      # Handle input
      key = term.inkey()
      
      if key.lower() == 'q':
        break
      elif key.name == 'KEY_UP' and selected > 0:
        selected -= 1
      elif key.name == 'KEY_DOWN' and selected < len(themes) - 1:
        selected += 1
      elif key.name == 'KEY_ENTER':
        theme_name, theme_file, _ = themes[selected]
        if apply_theme(theme_file):
          print(term.move_y(term.height - 1) + term.center(
            term.green(f"Applied theme: {theme_name}! Press any key to exit...")))
          term.inkey()
        else:
          print(term.move_y(term.height - 1) + term.center(
            term.red("Failed to apply theme. Press any key to continue...")))
          term.inkey()
        break

if __name__ == "__main__":
  main() 