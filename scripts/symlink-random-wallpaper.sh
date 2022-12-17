#!/usr/bin/env bash

source_dir="$HOME/Pictures/Wallpapers"
dest_dir="$HOME/Pictures/Wallpapers/Random-Wallpapers"

# create destination dir if it doesn't exist
[ -d "$dest_dir" ] || mkdir -p "$dest_dir"

# search all image files types in the source directory and its subdirectories
find "$source_dir" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" -o -name "*.svg" -name "*.webp" -name "*.bmp" \) -print0 | while read -d $'\0' file
do
  ln -sf "$file" "$dest_dir"
done && echo "Done symlinking wallpapers to $dest_dir"
