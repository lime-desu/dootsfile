#!/usr/bin/env bash

source "$DOOTS"/config/zsh/functions/colors.zsh
define_colors

source_dir="$HOME/Pictures/Wallpapers"
dest_dir="$source_dir/Random_Wallpapers"

create_dir() {
	if [ ! -d "$dest_dir" ]; then
		mkdir -p "$dest_dir"
		echo -e "Creating ${BLD}${BLU}$dest_dir...${RST}"
	fi
}

image_extensions=("jpg" "png" "jpeg" "svg" "webp" "icon" "bmp")
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
repositories=( # Total of 15.2+ GB
	"catppuccin/wallpapers"                          # 100+ MB
	"damnitharshit/Wallpapers"                       # 20+ MB
	"D3Ext/aesthetic-wallpapers"                     # 500+ MB
	"DenverCoder1/minimalistic-wallpaper-collection" # 450+ MB
	"dharmx/lambda-wallpapers"                       # 4.4+ GB
	"elementary/wallpapers"                          # 120+ mb
	"Everblush/wallpapers"                           # 15+ MB
	"FrenzyExists/wallpapers"                        # 1.4+ GB
	"kitsunebishi/Wallpapers"                        # 4.1+ GB
	"linuxdotexe/nordic-wallpapers"                  # 830+ MB
	"mut-ex/wallpapers"                              # 650+ MB
	"saint-13/Linux_Dynamic_Wallpapers"              # 2.5+ GB
	# "cat-milk/Anime-Girls-Holding-programming-Books" # 580+ MB
)

clone_repositories() {
	echo -e "Downloading wallpapers from: ${BLD}${BLU}$repo${RST} repo..."
	if ! git clone --depth=1 "https://github.com/$repo" "$source_dir/$repo_username"; then
		echo -e "${BLD}${RED}Error:${RST} Failed to download wallpapers from ${BLD}${BLU}${repo}${RST}."
		echo -e "Or it is already ${YLW}${BLD}downloaded,${RST} check ${BLD}${BLU}$repo_dir.\n${RST}"
	fi
}

update_repositories() {
	echo -e "Updating wallpapers from: ${BLD}${BLU}$repo${RST} repo..."
	cd "$source_dir/$repo_username" || return
	if ! git pull origin; then
		echo -e "${BLD}${RED}Error:${RST} Failed to update wallpapers from ${BLD}${BLU}${repo}${RST}."
		echo -e "Check your internet connection and try again.\n"
	fi
}

repository() {
	for repo in "${repositories[@]}"; do
		repo_username="${repo%%/*}"
		repo_dir="$source_dir/$repo_username"
		case "$1" in
		clone) clone_repositories ;;
		update) update_repositories ;;
		list) echo -e " - ${BLU}$repo${RST}" ;;
		esac
	done
}

show_message() {
	cat <<EOF
${BLD}${YLW}${RED}Warning:${RST} This script will download a lot of wallpapers from remote repositories and use a lot of bandwidth!!
(${BLD}${YLW}Note:${RST} Some of the downloaded wallpapers may have duplicates)

The wallpapers will be symlinked to a single directory at:
${BLU}$dest_dir${RST}
Downloaded wallpapers will be stored in:
${BLU}$source_dir${RST}

(${BLD}${YLW}Another Note:${RST} You can easily add/edit/remove sources from the repository array.
Rerunning the script again, to update the previously downloaded wallpapers repo and resymlink,
Or will download wallpapers if you add new repo sources from array then symlink it.

Here are the following list of wallpaper repository source/s:
EOF

	repository list
}

repository_exists() { repo_dir="$source_dir/${1%%/*}" && [[ -d "$repo_dir" ]]; }

main() {
	all_dirs_exist=true
	for repo in "${repositories[@]}"; do
		repository_exists "$repo" || {
			all_dirs_exist=false
			break
		}
	done

	if [[ ! -d "$source_dir" ]]; then
		show_message
		while true; do
			echo -en "\nAre you really sure you want to continue? (y/n): "
			read -r choice
			case "$choice" in
			[Yy])
				create_dir
				repository clone && symlink_images
				break
				;;
			[Nn])
				echo "Aborting..."
				exit 1
				;;
			*) echo "Invalid input." ;;
			esac
		done
	elif "$all_dirs_exist"; then
		repository update && symlink_images
	elif ! "$all_dirs_exist"; then
		repository clone && symlink_images
	fi
}

main
