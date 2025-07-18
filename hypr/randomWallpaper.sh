#!/usr/bin/env bash

# Directory containing your wallpapers
WALLPAPER_DIR="/home/max/Pictures/Wallpaper"

# Pick a random wallpaper from the folder
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | shuf -n 1)

swww img "$WALLPAPER" --transition-type wipe --transition-duration 2
