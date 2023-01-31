#!/usr/bin/env bash
# wip add colors
# make sure we have pulled in and updated any submodules

DOOTS="$HOME/Git/Local/dootsfile"
CONFIG="$HOME/.config"
BINS="$HOME/.local/bin"
THEMES="$HOME/.local/share/themes"
ICONS="$HOME/.local/share/icons"

create() {
  local dir="$1"
  [ ! -d "$dir" ] && mkdir -p "$dir" && echo "Creating directory for $dir..."
}

dirs=("$CONFIG" "$BINS" "$THEMES" "$ICONS")
for dir in "${dirs[@]}"; do
  create "$dir"
done

backup() {
  local file="$1"
  if [ -e "$file" ]; then
    backup_file=${2:-$1.bak}
    if [ ! -e "$backup_file" ]; then
      cp -r "$file" "$backup_file"
      echo "Backing up $file to $backup_file..."
    fi
  fi
}

for file in "$DOOTS"/* ; do 
  backup "$CONFIG"
  create "$DOOTS"
done

# wip
# install() {
#   cd "$DOOTS" || return
#   git clone https://github.com/lime-desu/dootsfile.git
#   git submodule update --init
# }
#
# uninstall() {
#
# }

stowit() {
  dootsfile="$1"
  target_dir="$2"
  stow "$dootsfile" --dir "$DOOTS" --verbose --restow --target "$target_dir"
}

stowit config "${CONFIG}"
stowit bin "${BINS}"
stowit themes "${THEMES}"
stowit icons "${ICONS}"

# For custom installation comment out stowit config from above, and
# uncomment this line below add/remove config from the array
# doots=(
#   alacritty
#   atuin
#   bat
#   broot
#   btop
#   cava
#   foot
#   fzf
#   git
#   gtk-3.0
#   gtk-4.0
#   hypr
#   kitty
#   librewolf
#   lsd
#   neofetch
#   nvim
#   ripgrep
#   tealdeer
#   tmux
#   zsh
# )
#
# for dot in "${doots[@]}"; do
#   cd "$DOOTS/config" || exit
#   stowit "$dot" "${CONFIG}"
# done
