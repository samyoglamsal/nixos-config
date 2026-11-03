#!/usr/bin/env bash
# macOS-style area screenshot: select a region, save it to ~/Pictures/Screenshots and copy it to the clipboard.
# Requires grim, slurp and wl-clipboard. Does nothing if the selection is cancelled.
dir="$HOME/screenshots"
mkdir -p "$dir"
file="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"

geometry=$(slurp) || exit 0
[ -z "$geometry" ] && exit 0

grim -g "$geometry" "$file" && wl-copy --type image/png < "$file"
