#!/bin/env bash

repos=("phisch/phinger-cursors" "lassekongo83/adw-gtk3")
extensions=(".tar.bz2" ".tar.xz")

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
  echo "Fetching download links from:"
  for repo in "${repos[@]}"; do
   echo " - $repo"
  done

  cursor_release_url=$(get_download_url "${repos[0]}" "${extensions[0]}")
  theme_release_url=$(get_download_url "${repos[1]}" "${extensions[1]}")

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
