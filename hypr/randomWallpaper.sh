#!/bin/bash

# Directory containing your wallpapers
WALLPAPER_DIR="/home/max/Pictures/SavedWallpapers"

# Pick a random wallpaper from the folder
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

# Apply the wallpaper using waypaper
waypaper --wallpaper "$WALLPAPER"
