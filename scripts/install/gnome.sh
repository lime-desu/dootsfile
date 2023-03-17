#!/usr/bin/env bash

# "mocha": "95894cfd-82f7-430d-af6e-84d168bc34f5",
# "macchiato": "5083e06b-024e-46be-9cd2-892b814f1fc8",
# "frappe": "71a9971e-e829-43a9-9b2f-4565c855d664",
# "latte": "de8a9081-8352-4ce4-9519-5de655ad9361",

if [[ "$XDG_CURRENT_DESKTOP" =~ "GNOME" ]]; then
	#-----------------------------------------------
	declare -A GNOME_PACKAGES=(
		["pacman"]="gnome-tweaks"
		["apt"]="gnome-tweaks gnome-shell-extension-gsconnect openssl"
		["dnf"]="gnome-tweaks gnome-shell-extension-gsconnect openssl gnome-shell-extension-pop-shell xprop gnome-shell-extension-user-theme"
		["xbps-install"]="gnome-tweaks"
		["flatpak"]="com.mattjakeman.ExtensionManager"
	)

	install_gnome_packages() {
		for package_manager in "${!GNOME_PACKAGES[@]}"; do
			read -ra packages <<<"${GNOME_PACKAGES[$package_manager]}"
			install_packages "$package_manager" "${packages[@]}"
		done
	}

	EXTENSIONS=(
		# "dash-to-dock@micxgx.gmail.com"
		# "pano@elhan.io"
		# "just-perfection-desktop@just-perfection"
		# "netspeedsimplified@prateekmedia.extension"
		"arcmenu@arcmenu.com"
		"gsconnect@andyholmes.github.io"
		"hidetopbar@mathieu.bidon.ca"
		"pop-shell@system76.com"
		"rounded-window-corners@yilozt"
		"user-theme@gnome-shell-extensions.gcampax.github.com"
		"widgets@aylur"
	)

	apply_extension_config() {
		local extensions=("aylurs-widgets" "hidetopbar" "pop-shell" "rounded-window-corners" "user-theme")
		local schema="org/gnome/shell/extensions"

		for ext in "${extensions[@]}"; do
			dconf load "/$schema/$ext/" <"$DOOTS/share/gnome-shell/extensions/$ext"
		done
	}

	enable_extension() {
		echo -e "${BLD}${BLU}Before proceeding ensure the following extension are installed to apply their configuration:${RST}"
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

	# TODO: don't hardcode gsettings value ask for prompt
	main() {
		install_gnome_packages && enable_extension
		echo -e "Importing ${BLD}${BLU}Gnome Keybindings${RST}..." && sleep 2
		perl "${DOOTS}"/scripts/gnome-keybindings.pl --import "${DOOTS}/"config/gnome-keybindings.csv
		echo -e "Applying ${BLD}${BLU}theme and cusor icon${RST} on GNOME..." && sleep 2
		curl -sL https://raw.githubusercontent.com/catppuccin/gnome-terminal/v0.2.0/install.py | python3 - # execute catppuccin/gnome-terminal script
		gsettings set org.gnome.Terminal.ProfilesList default '95894cfd-82f7-430d-af6e-84dl68bc34f5'       # mocha
		gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
		gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
		gsettings set org.gnome.desktop.interface cursor-theme 'Catppuccin-Mocha-Dark-Cursors'
		gsettings set org.gnome.desktop.interface icon-theme 'Skeuowaita'
		if command -v flatpak >/dev/null; then
			echo -e "Applying ${BLD}${BLU}Gtk theme on Flatpak${RST}..."
			sudo flatpak override --filesystem=xdg-config/gtk-{3,4}.0
		fi
	}

	main
#-----------------------------------------------
fi
