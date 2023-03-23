#!/usr/bin/env bash

# "mocha": "95894cfd-82f7-430d-af6e-84d168bc34f5",
# "macchiato": "5083e06b-024e-46be-9cd2-892b814f1fc8",
# "frappe": "71a9971e-e829-43a9-9b2f-4565c855d664",
# "latte": "de8a9081-8352-4ce4-9519-5de655ad9361",

if [[ "$XDG_CURRENT_DESKTOP" =~ "GNOME" ]]; then
	#-----------------------------------------------
	declare -A GNOME_PACKAGES=(
		["pacman"]="gnome-tweaks libgda"
		["apt"]="gnome-tweaks gnome-shell-extension-gsconnect openssl gir1.2-gda-5.0 gir1.2-gsound-1.0"
		["dnf"]="gnome-tweaks gnome-shell-extension-gsconnect openssl gnome-shell-extension-pop-shell xprop gnome-shell-extension-user-theme libgda libgda-sqlite"
		["xbps-install"]="gnome-tweaks libgda"
		["flatpak"]="com.mattjakeman.ExtensionManager"
	)

	install_gnome_packages() {
		for package_manager in "${!GNOME_PACKAGES[@]}"; do
			read -ra packages <<<"${GNOME_PACKAGES[$package_manager]}"
			install_packages "$package_manager" "${packages[@]}"
		done
	}

	apply_flatpak_theme_config() {
		if command -v flatpak >/dev/null; then
			echo -e "\nApplying ${BLD}${BLU}Gtk theme on Flatpak${RST}..."
			sudo flatpak override --filesystem=xdg-config/gtk-{3,4}.0
		fi
	}

	EXTENSIONS=(
		# "netspeedsimplified@prateekmedia.extension"
		"arcmenu@arcmenu.com"
		"dash-to-dock@micxgx.gmail.com"
		"gsconnect@andyholmes.github.io"
		"hidetopbar@mathieu.bidon.ca"
		"just-perfection-desktop@just-perfection"
		"pano@elhan.io"
		"pop-shell@system76.com"
		"rounded-window-corners@yilozt"
		"user-theme@gnome-shell-extensions.gcampax.github.com"
		"widgets@aylur"
	)

	apply_extension_config() {
		# Technically I can refactor this, and use single array only, but since enabling and applying extensions are different command, especially aylurs-widgets have different formatting, just to avoid confusion i created another array.
		local extensions=("arcmenu" "aylurs-widgets" "dash-to-dock" "hidetopbar" "just-perfection" "pano" "pop-shell" "rounded-window-corners" "user-theme")
		local schema="org/gnome/shell/extensions"

		for ext in "${extensions[@]}"; do
			dconf load "/$schema/$ext/" <"$DOOTS/share/gnome-shell/extensions/$ext"
		done
	}

	enable_extension() {
		echo -e "${BLD}${BLU}\nBefore proceeding ensure the following extension are installed to apply their configuration:${RST}"
		printf " ${BLU}-${RST} %s\n" "${EXTENSIONS[@]}"
		echo -e "${BLD}${YLW}Note:${RST} Only ${BLU}gsconnect${RST} config aren't included only for enabling it. (Already installed on ${GRN}Debian and Fedora${RST})"
		echo -e "Also ${BLU}pop-shell${RST} and ${BLU}user-theme${RST} extensions are already installed on ${GRN}Fedora${RST} as system extensions\n" && sleep 10
		read -rp "Extensions are already installed? (y to proceed or n to skip) : " choice

		if [[ "$choice" =~ ^[yY]$ ]]; then
			for extension in "${EXTENSIONS[@]}"; do
				extension_name=${extension%%@*} # extract extension name up to the "@" character
				if gnome-extensions list | grep -q "$extension"; then
					gnome-extensions enable "$extension"
					echo -e "${BLU}$extension${RST} shell extension enabled successfully."
					apply_extension_config && echo -e "Applying ${GRN}$extension_name${RST} configuration..."
				fi
			done
		fi
	}

	import_gnome_keybindings() {
		echo -e "Importing ${BLD}${BLU}Gnome Keybindings${RST}..." && sleep 2
		perl "${DOOTS}"/scripts/gnome-keybindings.pl --import "${DOOTS}/"config/gnome-keybindings.csv
	}

	# TODO: don't hardcode gsettings value ask for prompt
	apply_gnome_settings() {
		echo -e "Applying ${BLD}${BLU}Gnome settings, themes and cusor icon${RST}..." && sleep 2
		gsettings set org.gnome.mutter dynamic-workspaces 'false'                # turn off dynamic-workspaces (fixed 4 workspaces as default)
		gsettings set org.gnome.mutter center-new-windows 'true'                 # place new windows at the center of the screen
		gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click 'true' # enable tap to click on touchpad
		gsettings set org.gnome.desktop.interface show-battery-percentage 'true' # show show-battery-percentage
		gsettings set org.gnome.desktop.interface clock-show-weekday 'true'      # show weekdays
		# gsettings set org.gnome.desktop.interface clock-format '12h'
		# gsettings set org.gtk.Settings.FileChooser clock-format '12h'
		# gsettings set org.gtk.gtk4.Settings.FileChooser clock-format '12h'
		# gsettings set org.gnome.desktop.sound allow-volume-above-100-percent 'true'
		# gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
		gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
		gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
		gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Mocha-Dark-Cursors'
		gsettings set org.gnome.desktop.interface icon-theme 'Skeuowaita'
		curl -sL https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 - # execute catppuccin/gnome-terminal script
		gsettings set org.gnome.Terminal.ProfilesList default '95894cfd-82f7-430d-af6e-84d168bc34f5'       # Catppuccin mocha
	}

	main() {
		install_gnome_packages && apply_flatpak_theme_config && enable_extension
		import_gnome_keybindings && apply_gnome_settings
	}

	main
#-----------------------------------------------
fi
