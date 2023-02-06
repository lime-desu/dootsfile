#!/usr/bin/env bash

setup_flatpak() {
  if command -v flatpak > /dev/null; then
    echo "Adding flathub repository for Flatpak..."
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  
    echo "Installing Flatpak apps/themes..."
    echo "  Theme: adw-gtk3"
    echo "  Apps:  Flatseal and Junction"
    flatpak install flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
    flatpak install flathub re.sonny.Junction
    flatpak install flathub com.github.tchx84.Flatseal
  
    if [[ "$XDG_CURRENT_DESKTOP" =~ "GNOME" ]]; then
      echo "Applying theme on GNOME..."
      gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      echo "Installing ExtensionManager on Flatpak for GNOME..."
      flatpak install flathub com.mattjakeman.ExtensionManager
    fi
  
    echo "Applying theme on Flatpak..."
    sudo flatpak override --filesystem=xdg-config/gtk-{3,4}.0 && echo "Done."
  fi
}

setup_flatpak
