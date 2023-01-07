FLATPAK_ALIAS_DIR="$XDG_CONFIG_HOME/zsh/alias/flatpak-aliases.zsh"

generate_flatpak_alias() {
  local flatpak_binaries_dir="/var/lib/flatpak/exports/bin"
  if test -d "$flatpak_binaries_dir"; then
    echo -e "\n# Auto-generated aliases for Flatpak applications\n" >> "${FLATPAK_ALIAS_DIR}"

    while read -r app; do
      app_id=$(echo "$app" | awk -F'/' '{print $NF}')
      alias_name=$(echo "$app_id" | awk -F'.' '{print $NF}' | tr '[:upper:]' '[:lower:]')
      echo "alias $alias_name='flatpak run $app_id'" >> "${FLATPAK_ALIAS_DIR}"
    done < <(ls "$flatpak_binaries_dir")

    echo "Done generating Flatpak aliases"
    echo "Check $FLATPAK_ALIAS_DIR to modify auto-generated alias"
  else
    echo "Error: $flatpak_binaries_dir directory does not exist"
  fi
}
