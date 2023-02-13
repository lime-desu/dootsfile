#!/usr/bin/env bash

source "$DOOTS"/config/zsh/functions/colors.zsh
define_colors

source_dir="$HOME/Pictures/Wallpapers"
dest_dir="$HOME/Pictures/Wallpapers/Random_Wallpapers"

create_dir(){
  if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
    echo -e "Creating ${BLD}${BLU}$dest_dir...${RST}"
  fi
}

image_extensions=( "jpg" "png" "jpeg" "svg" "webp" "icon" "bmp" )
symlink_images() {
  echo -e "${YLW}\nSymlinking wallpapers...${RST}"
  for extension in "${image_extensions[@]}"; do
    find "$source_dir" -type f -name "*.$extension" -print0 | while read -r -d $'\0' file; do
      ln -sf "$file" "$dest_dir"
    done
  done
  echo -e "\nDone symlinking all wallpapers to:\n${BLD}${BLU}$dest_dir${RST}"
}

# Custom: simply uncomment/remove from the array, for adding sources (format: <username>/<reponame>)
repositories=(                                            # Total of 15.2+ GB
  "catppuccin/wallpapers"                                 # 100+ MB
  "damnitharshit/Wallpapers"                              # 20+ MB
  "D3Ext/aesthetic-wallpapers"                            # 500+ MB
  "DenverCoder1/minimalistic-wallpaper-collection"        # 450+ MB
  "dharmx/lambda-wallpapers"                              # 4.4+ GB
  "elementary/wallpapers"                                 # 120+ mb
  "Everblush/wallpapers"                                  # 15+ MB
  "FrenzyExists/wallpapers"                               # 1.4+ GB
  "kitsunebishi/Wallpapers"                               # 4.1+ GB
  "linuxdotexe/nordic-wallpapers"                         # 830+ MB
  "mut-ex/wallpapers"                                     # 650+ MB
  "saint-13/Linux_Dynamic_Wallpapers"                     # 2.5+ GB
)

clone_repositories() {
  for repo in "${repositories[@]}"; do
    repo_username="${repo%%/*}"
    if [ ! -d "$source_dir/$repo_username" ]; then
      echo -e "Downloading wallpapers from: ${BLD}${BLU}$repo${RST} repo..."
      if ! git clone --depth=1 "https://github.com/$repo" "$source_dir/$repo_username"; then
        echo -e "${BLD}${RED}Error:${RST} Failed to download wallpapers from ${BLD}${BLU}${repo}${RST}."
        echo -e "Check your internet connection and try again.\n"
      fi
    fi
  done
}

update_repo() {
  for repo in "${repositories[@]}"; do
    repo_username="${repo%%/*}"
    if [ -d "$source_dir/$repo_username" ]; then
      echo -e "Updating wallpapers from: ${BLD}${BLU}$repo${RST} repo..."
      cd "$source_dir/$repo_username" || return
      if ! git pull origin; then
        echo -e "${BLD}${RED}Error:${RST} Failed to update wallpapers from ${BLD}${BLU}${repo}${RST}."
        echo -e "Check your internet connection and try again.\n"
      fi
    fi
  done
}

show_message() {
cat << EOF
${BLD}${YLW}${RED}Warning:${RST} This script will use a lot of bandwidth!!
This will download several wallpapers from github repo
(${BLD}${YLW}Note:${RST} Some of the downloaded wallpapers will have duplicates)

And will then symlink it to single directory on:
${BLU}$dest_dir${RST}

Here are the following list of wallpaper repository source:
EOF

  for repo in "${repositories[@]}"; do
   echo -e " - ${BLU}$repo${RST}"
  done
}

main() {
  if [ -d "$dest_dir" ]; then
    update_repo; symlink_images;
  else
    show_message
    while true; do
        echo -en "\nAre you really sure you want to continue? (y/n): "
        read -r choice
        case "$choice" in
          [Yy]) clone_repositories; create_dir; symlink_images; break;;
          [Nn]) echo "Aborting..."; exit 1;;
          *) echo "Invalid input.";;
        esac
    done
  fi
}

main
