#!/usr/bin/env bash

# "mocha": "95894cfd-82f7-430d-af6e-84d168bc34f5",
# "macchiato": "5083e06b-024e-46be-9cd2-892b814f1fc8",
# "frappe": "71a9971e-e829-43a9-9b2f-4565c855d664",
# "latte": "de8a9081-8352-4ce4-9519-5de655ad9361",

setup_flatpak() {
  if command -v flatpak > /dev/null; then
    echo  -e "Adding ${BLD}${BLU}flathub repository${RST} for Flatpak..."
    sudo flatpak remote-modify --enable flathub
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  
    echo -e "Installing ${BLD}${BLU}Flatpak apps/themes...${RST}"
    echo -e "  ${BLD}${BLU}Theme:${RST}${CYN} adw-gtk3${RST}"
    echo -e "  ${BLD}${BLU} Apps:${RST}${CYN} Flatseal and Junction${RST}"
    flatpak install --assumeyes flathub org.gtk.Gtk3theme.adw-gtk3 org.gtk.Gtk3theme.adw-gtk3-dark
    flatpak install --assumeyes flathub re.sonny.Junction
    flatpak install --assumeyes flathub com.github.tchx84.Flatseal
  
    if [[ "$XDG_CURRENT_DESKTOP" =~ "GNOME" ]]; then
      echo -e "Applying ${BLD}${BLU}theme and cusor icon${RST} on GNOME..."
      curl -sL https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 - # gnome-terminal catppuccin
      gsettings set org.gnome.Terminal.ProfilesList default "95894cfd-82f7-430d-af6e-84d168bc34f5"       # mocha
      gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
      gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
      gsettings set org.gnome.desktop.interface cursor-theme Catppuccin-Mocha-Dark-Cursors
      echo -e "Installing ${BLD}${BLU}ExtensionManager${RST} on Flatpak for GNOME..."
      flatpak install --assumeyes flathub com.mattjakeman.ExtensionManager
    fi
  
    echo -e "Applying ${BLD}${BLU}Gtk theme${RST}..."
    sudo flatpak override --filesystem=xdg-config/gtk-{3,4}.0
  fi
}

setup_flatpak
