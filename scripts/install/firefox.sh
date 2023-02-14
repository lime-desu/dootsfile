#!/usr/bin/env bash

mozilla_dirs=(
  ~/.mozilla/firefox/**.default-**
  ~/.var/app/org.mozilla.firefox/.mozilla/firefox/**.default-**
  ~/.librewolf/**.default-**
  ~/.var/app/io.gitlab.librewolf-community/.librewolf/**.default-**
)
 
setup_firefox() {
 for dir in "${mozilla_dirs[@]}"; do
    search_file="$dir/search.json.mozlz4"
    if [[ -d $dir ]] && [[ ! -e $search_file.doots ]]; then
      backup "$search_file"
      symlink "$DOOTS/config/librewolf/search.json.mozlz4" "$search_file"
      echo "Executing ${BLD}${BLU}Firefox-UI-Fix${RST} Install script..." && sleep 2
      bash -c "$(curl -fsSL https://raw.githubusercontent.com/black7375/Firefox-UI-Fix/master/install.sh)"
    fi
  done
}

setup_firefox
