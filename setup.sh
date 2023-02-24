#!/usr/bin/env bash
# set -eux
source_colors() {
  local tmp_file
  tmp_file="$(mktemp)"
  curl -fsSL https://raw.githubusercontent.com/lime-desu/dootsfile/main/config/zsh/functions/colors.zsh > "$tmp_file"
  source "$tmp_file" && define_colors
  unset tmp_file
}

dependencies=(chsh curl fzf git jq nvim stow tar tmux unzip wget zsh)
# fzf dependencies: bat broot fd lsd rg wl-copy
check_dependencies() {
  missing_deps=()
  for dependency in "${dependencies[@]}"; do
    if ! command -v "$dependency" > /dev/null; then
      missing_deps+=("$dependency")
    fi
  done

  if [ ${#missing_deps[@]} -gt 0 ]; then
    echo -e "${RED}${BLD}Error:${RST} The following dependencies are not installed: "
    for dependency in "${missing_deps[@]}"; do
      echo "- ${YLW}$dependency${RST}"
    done
    echo "Please install them first and try again."
    exit 1
  fi
}

DOOTS="$HOME/Git/Local/dootsfile"
CONFIG="$HOME/.config"
BINS="$HOME/.local/bin"
SCRIPTS="$BINS/scripts"
THEMES="$HOME/.local/share/themes"
ICONS="$HOME/.local/share/icons"

create() {
  local dir="$1" 
  local dir_name
  dir_name="$(basename "$dir")"
  if [[ ! -d "$dir" ]]; then
    echo -e "Creating directory for ${BLD}${BLU}'$dir_name'${RST}..." 
    mkdir -p "$dir" && sleep 2
  fi
}

backup() {
  local file="$1"
  local backup_file=${2:-$file.doots}

  if [[ -e "$file" ]] && [[ ! -e "$backup_file" ]]; then
    echo "Backing up ${BLD}${BLU}$file${RST} to ${BLD}${CYN}$backup_file${RST}..."
    cp -r "$file" "$backup_file" && sleep 2
  fi
}

stow_this() {
  local dootsfile="$1" target_dir="$2"
  stow "$dootsfile" --dir "$DOOTS" --verbose --restow --target "$target_dir" --adopt
  sleep 2
  git reset --hard > /dev/null
}

symlink() {
  local dootsfile="$1" target_dir="$2"
  echo -e "Symlinking ${BLD}${BLU}$dootsfile${RST} to ${BLD}${CYN}$target_dir${RST}..."
  ln -sf "$dootsfile" "$target_dir" && sleep 2
}

setup() {
  if [ ! -d "$DOOTS" ]; then
    echo -e "${BLD}${BLU}Fetching ${CYN}Doots${RST}${BLU}${BLD} from the source...${RST}"
    create "$DOOTS" && cd "$_" || return
    git clone --recurse-submodules https://github.com/lime-desu/dootsfile.git "$(pwd)"
    # backup files first
    dirs=("$CONFIG" "$BINS" "$SCRIPTS" "$THEMES" "$ICONS")
    for dir in "${dirs[@]}"; do
      backup "$dir"
      create "$dir"
    done
    # execute install scripts
    ./setup.sh
    source ./scripts/install/zsh.sh
    source ./scripts/install/dl-from-github.sh
    source ./scripts/install/flatpak.sh
    source ./scripts/install/firefox.sh
    source ./scripts/install/keybindings.sh
    # bat cache --build
    # recommended tools to install
    echo -e "${BLD}${BLU}All done.${WHT}\n\nRecommended tools to install:${RST}"
    source ./scripts/tools.sh
  fi
}

main() {
  setup
  stow_this config "${CONFIG}"
  stow_this bin "${BINS}"
  stow_this scripts "${SCRIPTS}"
  stow_this themes "${THEMES}"
  stow_this icons "${ICONS}"
}

source_colors
check_dependencies
main

# For custom installation comment out `stow_this config` from above, and
# uncomment this line of array below then remove some you don't want to include
# Note: Using stow will not work it will litter all the files in the target dir without their foldername/basename
# TODO: make this interactive, and split into multiple file?

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
#   cd "$DOOTS/config"
#   symlink "$(pwd)/$dot" "${CONFIG}"
# done
