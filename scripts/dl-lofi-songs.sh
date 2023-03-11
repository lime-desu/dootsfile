#!/bin/bash

prompt_for_directory() {
	read -rp "Directory where the songs should be saved? (default: $HOME/Music/lofi): " lofi_directory
	lofi_directory=${lofi_directory:-"$HOME/Music/lofi"}
	[[ -d "$lofi_directory" ]] || mkdir -p "$lofi_directory"
}

check_dependencies() {
	for command in curl aria2c; do
		if ! command -v $command &>/dev/null; then
			echo "$command command not found. Please install it first and try again." && exit 1
		fi
	done
}

fetch_songs() {
	local album_url="$1"
	local song_urls
	song_urls=$(curl -s "$album_url" | grep "data-audio-src" | cut -d "\"" -f4)

	aria2c -d "$lofi_directory" -i <(echo "$song_urls") && sleep 5

	local next_url
	next_url=$(curl -s "$album_url" | grep -o 'class="next" href="/blogs/releases/page[^"]*' | cut -d'"' -f3)

	if [[ -n "$next_url" ]]; then
		next_url="https://lofigirl.com$next_url"
		fetch_songs "$next_url"
	fi
}

check_dependencies
prompt_for_directory

lofi_release="https://lofigirl.com/blogs/releases"
album_urls=$(curl -s "$lofi_release" | grep "Cv_release_mini_wrap_img" | cut -d "\"" -f2 | cut -d "/" -f4)
while read -r album_url; do
	fetch_songs "$lofi_release/$album_url"
done <<<"$album_urls"
