FLATPAK_ALIAS_FILE_DIR="$XDG_CONFIG_HOME/zsh/alias/flatpak-aliases.zsh"

generate_flatpak_alias() {
  set -e
  [[ -f $FLATPAK_ALIAS_FILE_DIR ]] && touch $FLATPAK_ALIAS_FILE_DIR
  local flatpak_binaries_dir="/var/lib/flatpak/exports/bin"
  if [[ -d "$flatpak_binaries_dir" ]]; then
    echo -e "\n# Auto-generated aliases for Flatpak applications\n" >> "${FLATPAK_ALIAS_FILE_DIR}"

    while read -r app; do
      app_id=$(echo "$app" | awk -F'/' '{print $NF}')
      alias_name=$(echo "$app_id" | awk -F'.' '{print $NF}' | tr '[:upper:]' '[:lower:]')
      echo "alias $alias_name='flatpak run $app_id'" >> "${FLATPAK_ALIAS_FILE_DIR}"
    done < <(find "$flatpak_binaries_dir" -maxdepth 1 -mindepth 1)

    echo "Done generating Flatpak aliases"
    echo "Check ${BLD}${BLU}$FLATPAK_ALIAS_FILE_DIR${RST} to modify auto-generated alias"
  else
    echo "${RED}${BLD}Error: ${YLW}$flatpak_binaries_dir${RST} directory does not exist"
  fi
}
