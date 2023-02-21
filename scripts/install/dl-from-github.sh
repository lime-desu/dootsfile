#!/bin/env bash

repos=("phisch/phinger-cursors" "lassekongo83/adw-gtk3" "Code-Hex/Neo-cowsay" "catppuccin/cursors")
extensions=(".tar.bz2" ".tar.xz" "x86_64.tar.gz" "Mocha-Dark-Cursors.zip")

get_download_url() {
  local repo="$1"
  local extension="$2"

  local release_url
  release_url=$(curl -s "https://api.github.com/repos/$repo/releases" | \
    jq -r '.[].assets[] | select(.name | endswith("'"$extension"'")) | .browser_download_url' | \
    grep -o "https.*" | head -n1)
  echo "$release_url"
}

# created separate function for unzip, since extraction from stdin wouldn't work
unzip_from_index_to() {
  local url
  url=$(get_download_url "${repos[$1]}" "${extensions[$2]}")
  local file_name
  file_name=$(basename "$url")
  curl -sL -o "$file_name" "$url"
  if [ -f "$file_name" ]; then
    unzip "$file_name" -d "$3"
    rm "$file_name"
  else
    echo "Error: Failed to extract '$file_name'"
  fi
}

cleanup_cowsay() {
  rm -rvf "$BINS"/{LICENSE,doc}
}

dl_from_releases() {
  local curl_cmd="curl -L"
  local wget_cmd="wget -c -O-"
  local download_cmd="$curl_cmd"

  echo "Fetching download links from:"
  for repo in "${repos[@]}"; do
    echo -e "${BLU} - $repo${RST}"
  done

  phinger_cursor_release_url=$(get_download_url "${repos[0]}" "${extensions[0]}")
  theme_release_url=$(get_download_url "${repos[1]}" "${extensions[1]}")
  neocowsay_release_url=$(get_download_url "${repos[2]}" "${extensions[2]}")
  download_and_extract_catppuccin_cursor=$(unzip_from_index_to 3 3 "$ICONS")

  while true; do
    echo -n -e "Choose download method: ${BLD}(1)${BLU} curl, ${RST}(2)${CYN} wget: ${RST}"
    read -r cmd
    case "$cmd" in
      1) download_cmd="$curl_cmd"; break;;
      2) download_cmd="$wget_cmd"; break;;
      *) echo -e "${BLD}${RED}Error: ${RST}Invalid choice. Please try again.";;
    esac
  done

  $download_cmd "$phinger_cursor_release_url" | tar xvfj - -C "$ICONS"
  $download_cmd "$theme_release_url" | tar xvfJ - -C "$THEMES"
  $download_cmd "$neocowsay_release_url" | tar xvfz - -C "$BINS" && cleanup_cowsay &&
  "$download_and_extract_catppuccin_cursor"
}

dl_from_releases
