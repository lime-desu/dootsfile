#!/usr/bin/env bash

source_dir="$HOME/Pictures/Wallpapers"
dest_dir="$HOME/Pictures/Wallpapers/Random_Wallpapers"

if [ ! -d "$dest_dir" ]; then
  mkdir -p "$dest_dir"
  echo -e "Creating $dest_dir..."
fi

image_extensions=( "jpg" "png" "jpeg" "svg" "webp" "icon" "bmp" )
symlink_images() {
  echo "Symlinking wallpapers..."
  for extension in "${image_extensions[@]}"; do
    find "$source_dir" -type f -name "*.$extension" -print0 | while read -r -d $'\0' file; do
      ln -sf "$file" "$dest_dir"
    done
  done
  echo "Done symlinking all wallpapers to $dest_dir"
}

repositories=(
  "linuxdotexe/nordic-wallpapers" 
  "catppuccin/wallpapers" 
  "FrenzyExists/wallpapers" 
  "saint-13/Linux_Dynamic_Wallpapers" 
  "mut-ex/wallpapers" 
  "damnitharshit/Wallpapers" 
  "D3Ext/aesthetic-wallpapers" 
  "kitsunebishi/Wallpapers" 
)

clone_repositories() {
  for repo in "${repositories[@]}"; do
    repo_username="${repo%%/*}"
    if [ ! -d "$source_dir/$repo_username" ]; then
      git clone --depth=1 "https://github.com/$repo" "$source_dir/$repo_username"
    fi
  done
}

clone_repositories
symlink_images

# Wallpaper sources git clone <url> <dest_dir/repo_name>
# https://github.com/linuxdotexe/nordic-wallpapers
# https://github.com/catppuccin/wallpapers
# https://github.com/FrenzyExists/wallpapers
# https://github.com/saint-13/Linux_Dynamic_Wallpapers
# https://github.com/mut-ex/wallpapers
# https://github.com/damnitharshit/Wallpapers
# https://github.com/D3Ext/aesthetic-wallpapers
# https://github.com/kitsunebishi/Wallpapers 
