#!/usr/bin/env bash

setup_keybinds() {
  if [[ "$XDG_CURRENT_DESKTOP" =~ "GNOME" ]]; then
    echo -e "Importing ${BLD}${BLU}Gnome Keybindings${RST}..."
    perl "${DOOTS}"/scripts/gnome-keybindings.pl --import "${DOOTS}/"config/gnome-keybindings.csv
  fi
}

setup_keybinds
