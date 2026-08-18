#!/usr/bin/env bash
LOG="$HOME/.cache/tint-logo-debug.log"
echo "$(date): tint-logo.sh triggered" >> "$LOG"

SRC="$HOME/Caelestia_assets/shell_cat_3_img.png"
OUT="$HOME/.cache/fastfetch_logo_tinted.png"

COLOR=$(jq -r '.colours.primary' "$HOME/.local/state/caelestia/scheme.json")
echo "$(date): COLOR=$COLOR" >> "$LOG"

python3 -c "
from PIL import Image

hex_color = '$COLOR'
r1 = int(hex_color[0:2], 16)
g1 = int(hex_color[2:4], 16)
b1 = int(hex_color[4:6], 16)
r2 = max(r1 - 20, 0)
g2 = max(g1 - 20, 0)
b2 = max(b1 - 20, 0)

img = Image.open('$SRC').convert('RGBA')
data = img.getdata()
new_data = []
for i, px in enumerate(data):
    if px[3] > 0:
        if i % 3 == 0:
            new_data.append((r1, g1, b1, px[3]))
        else:
            new_data.append((r2, g2, b2, px[3]))
    else:
        new_data.append((0, 0, 0, 0))
img.putdata(new_data)
img.save('$OUT')
" >> "$LOG" 2>&1

rm -rf "$HOME/.cache/fastfetch"

echo "$(date): script finished, exit code $?" >> "$LOG"
