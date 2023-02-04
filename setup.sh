#!/usr/bin/env bash
set -e

dependencies=(bat broot chsh curl fd fzf git lsd nvim rg stow tar tmux wget wl-copy zsh)
check_dependencies() {
  for dependency in "${dependencies[@]}"; do
    if ! command -v "$dependency" > /dev/null; then
      echo "Error: '$dependency' command not found. Please install it first and try again."
      exit 1
    fi
  done
}

DOOTS="$HOME/Git/Local/dootsfile"
CONFIG="$HOME/.config"
BINS="$HOME/.local/bin"
THEMES="$HOME/.local/share/themes"
ICONS="$HOME/.local/share/icons"

create() {
  local dir="$1" 
  local dir_name
  dir_name="$(basename "$dir")"
  if [[ ! -d "$dir" ]]; then
    mkdir -p "$dir" && echo "Creating directory for '$dir_name'" 
  fi
}

backup() {
  local file="$1"
  local backup_file=${2:-$1.doots}

  if [[ -e "$file" ]] && [[ ! -e "$backup_file" ]]; then
    cp -r "$file" "$backup_file"
    echo "Backing up $file to $backup_file..."
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
stow_this() {
  local dootsfile="$1" target_dir="$2"
  stow "$dootsfile" --dir "$DOOTS" --verbose --restow --target "$target_dir" #--adopt
  #git reset --hard
}

symlink() {
  local dootsfile="$1" target_dir="$2"
  ln -sf "$dootsfile" "$target_dir"
  echo "Symlinking $dootsfile to $target_dir..."
}

setup_zsh() {
  backup "$HOME/.zshenv"
  create "$HOME/.local/state/zsh/"
  symlink "$DOOTS/config/zsh/.zshenv" "$HOME"
  if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
  fi
}

setup_firefox() {
  mozilla_dirs=(
    ~/.mozilla/firefox/**.default-**
    ~/.var/app/org.mozilla.firefox/.mozilla/firefox/**.default-**
    ~/.librewolf/**.default-**
    ~/.var/app/io.gitlab.librewolf-community/.librewolf/**.default-**
  )
  
  for dir in "${mozilla_dirs[@]}"; do
    search_file="$dir/search.json.mozlz4"
    if [[ -d $dir ]] && [[ ! -e $search_file.doots ]]; then
      backup "$search_file"
      symlink "$DOOTS/config/librewolf/search.json.mozlz4" "$search_file"
    fi
  done
}

get_download_url() {
  local repo="$1"
  local extension="$2"

  local release_url
  release_url=$(curl -s "https://api.github.com/repos/$repo/releases" | \
    jq -r '.[].assets[] | select(.name | endswith("'"$extension"'")) | .browser_download_url' | \
    grep -o "https.*" | head -n1)
  echo "$release_url"
}

dl_from_releases() {
  echo "Fetching download links..."
  # This will download phinger-cursors and adw-gtk3 theme from github releases
  cursor_release_url=$(get_download_url phisch/phinger-cursors ".tar.bz2")
  theme_release_url=$(get_download_url lassekongo83/adw-gtk3 ".tar.xz")

  while true; do
    echo -n "Choose download method: (1) curl, (2) wget: "
    read -r cmd
    case "$cmd" in
      1)
        curl -L "$cursor_release_url" | tar xvfj - -C "$ICONS"
        curl -L "$theme_release_url" | tar xvfJ - -C "$THEMES"
        break
        ;;
      2)
        wget -c -O- "$cursor_release_url" | tar xvfj - -C "$ICONS"
        wget -c -O- "$theme_release_url" | tar xvfJ - -C "$THEMES"
        break
        ;;
      *)
        echo "Invalid choice. Please try again."
        ;;
    esac
  done
}

setup() {
  if [ ! -d "$DOOTS" ]; then
    create "$DOOTS" && cd "$_" || return
    git clone --recurse-submodules https://github.com/lime-desu/dootsfile.git "$(pwd)"
    ./setup.sh
    setup_zsh
    setup_firefox
    bat cache --build
    dl_from_releases
  fi

  stow_this config "${CONFIG}"
  stow_this bin "${BINS}"
  stow_this themes "${THEMES}"
  stow_this icons "${ICONS}"
}

check_dependencies
setup

# For custom installation comment out `stow_this config` from above, and
# uncomment this line of array below then remove some you don't want to include
# Note: Using stow will not work it will litter all the files in the target dir without their foldername/basename
# TODO: add colors, make this interactive, and split into multiple file?
# create another function to install themes on flatpak
# flatpak install adw-gtk3 && flatpak override theme --gtk-{3,4}

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
