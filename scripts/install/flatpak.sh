#!/usr/bin/env bash

setup_flatpak() {
  if command -v flatpak > /dev/null; then
    echo  -e "Adding ${BLD}${BLU}flathub repository${RST} for Flatpak..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  
    echo -e "Installing ${BLD}${BLU}Flatpak apps/themes...${RST}"
    echo -e "  ${BLD}${BLU}Theme:${RST}${CYN} adw-gtk3${RST}"
    echo -e "  ${BLD}${BLU} Apps:${RST}${CYN} Flatseal and Junction${RST}"
    flatpak install flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
    flatpak install flathub re.sonny.Junction
    flatpak install flathub com.github.tchx84.Flatseal
  
    if [[ "$XDG_CURRENT_DESKTOP" =~ "GNOME" ]]; then
      echo -e "Applying ${BLD}${BLU}theme and cusor icon${RST} on GNOME..."
      gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      gsettings set org.gnome.desktop.interface cursor-theme phinger-cursors
      echo -e "Installing ${BLD}${BLU}ExtensionManager${RST} on Flatpak for GNOME..."
      flatpak install flathub com.mattjakeman.ExtensionManager
    fi
  
    echo -e "Applying ${BLD}${BLU}Gtk theme${RST} on Flatpak..."
    sudo flatpak override --filesystem=xdg-config/gtk-{3,4}.0
  fi
}

setup_flatpak
