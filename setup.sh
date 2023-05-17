#!/usr/bin/env bash
# set -eux
base_url="https://raw.githubusercontent.com/lime-desu/dootsfile/main"
source_colors() {
	local tmp_file
	tmp_file="$(mktemp)"
	curl -fsSL "${base_url}"/config/zsh/functions/colors.zsh >"$tmp_file"
	source "$tmp_file" && define_colors
	unset tmp_file
}

DOOTS="$HOME/Git/Local/dootsfile"
CONFIG="$HOME/.config"
BINS="$HOME/.local/bin"
SCRIPTS="$BINS/scripts"
THEMES="$HOME/.local/share/themes"
ICONS="$HOME/.local/share/icons"

DEPENDENCIES=(alacritty bat broot btop cava chafa chsh curl delta dust exa fd foot fuck fzf git jq kitty lsd mpv neofetch nvim rg stow starship tar tldr tmux unzip wget wl-copy zsh)
check_dependencies() {
	missing_deps=()
	for dependency in "${DEPENDENCIES[@]}"; do
		if ! command -v "$dependency" >/dev/null; then
			missing_deps+=("$dependency")
		fi
	done

	if [ ${#missing_deps[@]} -gt 0 ]; then
		echo -e "${BLD}${BLU}Installing the following packages: ${RST}"
		for dependency in "${missing_deps[@]}"; do
			echo "- ${YLW}$dependency${RST}"
		done
		echo -e "${BLD}${RED}Note:${RST} Certain packages aren't available on some package manager"
		return 1
	fi
	return 0
}

setup_flatpak() { sudo flatpak remote-modify --enable flathub && sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo; }
install_packages() {
	if command -v "$package_manager" &>/dev/null; then
		case "$package_manager" in
		dnf | apt | flatpak) sudo "$package_manager" install -y "${packages[@]}" ;;
		pacman | xbps-install) sudo "$package_manager" -Sy "${packages[@]}" ;;
		*) echo "${BLD}${RED}Error:${RST} Unsupported package manager." ;;
		esac
	fi
}
# essential packages (setup script dependencies, modern unix and base-devel package (for building and compiling))
declare -A PACKAGE_LISTS=(
	["pacman"]="${base_url}/scripts/install/packages/arch.txt"
	["apt"]="${base_url}/scripts/install/packages/debian.txt"
	["dnf"]="${base_url}/scripts/install/packages/fedora.txt"
	["xbps-install"]="${base_url}/scripts/install/packages/void.txt"
	["flatpak"]="${base_url}/scripts/install/packages/flatpak.txt"
	["pkg"]="${base_url}/scripts/install/packages/termux.txt"
)

install_essential_packages() {
	if [ -n "$TERMUX_VERSION" ]; then
		readarray -t packages < <(curl -fsSL "${PACKAGE_LISTS[pkg]}")
		pkg install -y "${packages[@]}"
	else
		for package_manager in "${!PACKAGE_LISTS[@]}"; do
			readarray -t packages < <(curl -fsSL "${PACKAGE_LISTS[$package_manager]}")
			install_packages "$package_manager" "${packages[@]}"
		done
	fi
}

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

create_dircopy_and_backup() {
	dirs=("$CONFIG" "$BINS" "$SCRIPTS" "$THEMES" "$ICONS")
	for dir in "${dirs[@]}"; do
		backup "$dir"
		create "$dir"
	done
}

stow_this() {
	local dootsfile="$1" target_dir="$2"
	stow "$dootsfile" --dir "$DOOTS" --verbose --restow --target "$target_dir" --adopt
	sleep 2
}

symlink() {
	local dootsfile="$1" target_dir="$2"
	echo -e "Symlinking ${BLD}${BLU}$dootsfile${RST} to ${BLD}${CYN}$target_dir${RST}..."
	ln -sf "$dootsfile" "$target_dir" && sleep 2
}

setup() {
	stow_this config "${CONFIG}"
	stow_this bin "${BINS}"
	stow_this scripts "${SCRIPTS}"
	stow_this themes "${THEMES}"
	stow_this icons "${ICONS}"
}

main() {
	if [ ! -d "$DOOTS" ]; then
		source_colors
		! check_dependencies && install_essential_packages
		echo -e "${BLD}${BLU}Fetching ${CYN}Doots${RST}${BLU}${BLD} from the source...${RST}"
		create "$DOOTS" && cd "$_" || return
		git clone --recurse-submodules --shallow-submodules https://github.com/lime-desu/dootsfile.git "$(pwd)"
		create_dircopy_and_backup
		# stow/symlink to proper directory
		setup && git reset --hard &>/dev/null && bat cache --build
		# execute install scripts
		source ./scripts/install/gnome.sh
		source ./scripts/install/zsh.sh
		source ./scripts/install/dl-from-github.sh
		source ./scripts/install/firefox.sh
		echo -e "${BLD}${BLU}All done.${RST}\n\n"
		# recommended tools
		source ./scripts/tool.sh
	fi
}

[ "$(pwd)" = "${DOOTS}" ] && setup
main

# For custom installation comment out `stow_this config` from above, and
# uncomment this line of array below then remove some you don't want to include
# Note: Using stow will not work, so symlinking it instead
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
