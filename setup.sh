#!/usr/bin/env bash
# wip add colors
# make sure we have pulled in and updated any submodules
git submodule update --init

DOOTS="$HOME/Git/Local/dootsfile"
CONFIG="$HOME/.config"
BINS="$HOME/.local/bin"
THEMES="$HOME/.local/share/themes"
ICONS="$HOME/.local/share/icons"

stowit() {
  dootsfile="$1"
  target_dir="$2"
  echo -e "\nStowing ${dootsfile} for user: $(whoami)";
  stow "$dootsfile" --dir "$DOOTS" --verbose --restow --target "$target_dir";
}

create() {
  local dir="$1"
  [ -d "$dir" ] || mkdir -p "$dir"
}

dirs=("$DOOTS" "$CONFIG" "$BINS" "$THEMES" "$ICONS")
for dir in "${dirs[@]}"; do
  create "$dir"
done

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
