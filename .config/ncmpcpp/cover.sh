#!/bin/bash

DIR="$HOME/sync/music/$(dirname "$MPD_FILE")"

img=$(find "$DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | head -n 1)

[ -n "$img" ] && feh "$img"
