#!/usr/bin/env bash
# wip add colors
set -e

check_dependency() {
  if ! command -v "$1" > /dev/null; then
    echo "Error: '$1' command not found. Please install it first and try again."
    exit 1
  fi
}

check_dependency git 
check_dependency stow

DOOTS="$HOME/Git/Local/dootsfile"
CONFIG="$HOME/.config"
BINS="$HOME/.local/bin"
THEMES="$HOME/.local/share/themes"
ICONS="$HOME/.local/share/icons"

create() {
  local dir="$1" 
  dir_name="${dir/*\//}"
  [ ! -d "$dir" ] && mkdir -p "$dir" && echo "Creating directory for '$dir_name'" 
}

backup() {
  local file="$1"
  if [ -e "$file" ]; then
    backup_file=${2:-$1.doots}
    if [ ! -e "$backup_file" ]; then
      cp -r "$file" "$backup_file"
      echo "Backing up $file to $backup_file..."
    fi
  fi
}

dirs=("$CONFIG" "$BINS" "$THEMES" "$ICONS")
for dir in "${dirs[@]}"; do
  backup "$dir"
  create "$dir"
done

# If you have this error message below:
# WARNING! stowing config would cause conflicts:
# All operations aborted.
# uncomment `--adopt` flag below
# and then git reset --hard
symlink() {
  dootsfile="$1"
  target_dir="$2"
  stow "$dootsfile" --dir "$DOOTS" --verbose --restow --target "$target_dir" #--adopt
  #git reset --hard
}

# wip
setup() {
  if [ ! -d "$DOOTS" ]; then
    create "$DOOTS" && cd "$_" || return
    git clone --recurse-submodules https://github.com/lime-desu/dootsfile.git "$(pwd)"
    ./setup.sh
  fi

  symlink config "${CONFIG}"
  symlink bin "${BINS}"
  symlink themes "${THEMES}"
  symlink icons "${ICONS}"
}

setup

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
