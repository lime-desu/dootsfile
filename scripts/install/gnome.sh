#!/usr/bin/env bash

# "mocha": "95894cfd-82f7-430d-af6e-84d168bc34f5",
# "macchiato": "5083e06b-024e-46be-9cd2-892b814f1fc8",
# "frappe": "71a9971e-e829-43a9-9b2f-4565c855d664",
# "latte": "de8a9081-8352-4ce4-9519-5de655ad9361",

if [[ "$XDG_CURRENT_DESKTOP" =~ "GNOME" ]]; then
#-----------------------------------------------
declare -A GNOME_PACKAGES=(
    ["pacman"]="gnome-tweaks"
    ["apt"]="gnome-tweaks gnome-shell-extension-gsconnect"
    ["dnf"]="gnome-tweaks gnome-shell-extension-gsconnect gnome-shell-extension-pop-shell gnome-shell-extension-user-theme"
    ["xbps-install"]="gnome-tweaks"
    ["flatpak"]="com.mattjakeman.ExtensionManager"
)

install_gnome_packages() {
  for package_manager in "${!GNOME_PACKAGES[@]}"; do
    read -ra packages <<< "${GNOME_PACKAGES[$package_manager]}"
    install_packages "$package_manager" "${packages[@]}"
  done
}

main() {
    install_gnome_packages
    echo -e "Importing ${BLD}${BLU}Gnome Keybindings${RST}..." && sleep 2
    perl "${DOOTS}"/scripts/gnome-keybindings.pl --import "${DOOTS}/"config/gnome-keybindings.csv
    echo -e "Applying ${BLD}${BLU}theme and cusor icon${RST} on GNOME..." && sleep 2
    curl -sL https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 - # gnome-terminal catppuccin
    gsettings set org.gnome.Terminal.ProfilesList default "95894cfd-82f7-430d-af6e-84d168bc34f5"       # mocha
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface cursor-theme Catppuccin-Mocha-Dark-Cursors
    if command -v flatpak > /dev/null; then
      echo -e "Applying ${BLD}${BLU}Gtk theme on Flatpak${RST}..."
      sudo flatpak override --filesystem=xdg-config/gtk-{3,4}.0
    fi
}

main
#-----------------------------------------------
fi
