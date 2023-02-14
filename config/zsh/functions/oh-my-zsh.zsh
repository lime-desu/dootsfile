omz-custom() {
usage() {
    cat <<EOF
${BLD}Usage:${RST} 
${BLD}${GRN}  omz-custom ${RST}${YLW}<command>${RST}
${BLD}${GRN}  omz-custom ${RST}${YLW}[remove] [plugin|theme] [name]${RST}
  repo: ${YLW}<username>/<reponame>${RST}

${BLD}Commands:${RST}
${GRN}  update              ${RST}    Update Oh My Zsh and all custom plugins/themes
${GRN}  remove [type] [name]${RST}    Remove/Uninstall a specific plugin or theme
${BLD}Type:${RST}
${GRN}  plugin [repos...]   ${RST}    Install one or more custom plugins
${GRN}  theme  [repos...]    ${RST}   Install one or more custom themes

${GRN}  --help              ${RST}    Display this help message

EOF

}
  main() {
    set -e
    local type="$1"
    local omz_dir="${ZSH:-$HOME/.local/share/oh-my-zsh}"

    if [[ ! -d "$omz_dir" ]]; then
        echo "${BLU}Installing ${BLD}[Oh My Zsh]${RST} ..."
        git clone https://github.com/ohmyzsh
    fi

    install_custom() {
        local type="$1"
        local custom_dir="${ZSH_CUSTOM:-$omz_dir/custom}/${type}s"
        local repos=("${@:2}")

        for repo in "${repos[@]}"; do
            local name=${repo##*/}
            local dir="$custom_dir/$name"
            if [[ ! -d "$dir" ]]; then
                echo "${GRN}Installing ${BLD}${YLW}$name${RST} ${BLU}${type}...${RST}"
                git clone --depth=1 "https://github.com/$repo" "$dir"
                echo "${BLD}${BLU}Installed successfully.${RST}"
                echo "Now add ${BLD}${YLW}$name${RST} on zshrc plugin array"
            fi
        done
    }

    remove_custom() {
        local type="$1"
        local name="$2"
        local custom_dir="${ZSH_CUSTOM:-$omz_dir/custom}/${type}s"
        local dir="$custom_dir/$name"

        if [[ -d "$dir" ]]; then
            echo "${RED}Removing ${BLD}${YLW}$name${RST} ${BLU}${type}...${RST}"
            rm -rf "$dir" > /dev/null && sleep 2; echo "Done."
        else
            echo -e "${BLD}${RED}Error: ${YLW}$name${RST} not found.\n"
            usage
        fi
    }

    update_custom() {
        echo "${BLU}Updating ${BLD}[Oh My Zsh]${RST} ..."
        git -C "$omz_dir" pull
        echo ""
        printf "${BLU}%s${RST}\n" "Updating custom plugins and themes..."
        find "${ZSH_CUSTOM:-$ZSH/custom}" -type d -name ".git" | while read LINE; do
            plugin=${LINE:h}
            pushd -q "${plugin}"
            if git pull --rebase; then
                printf "%s${RST}\n" ${YLW}${BLD}"${plugin:t}${RST} ${GRN}has been updated and/or is at the current version.${RST}"
            else
                printf "%s${RST}\n" "${RED}There was an error updating ${RST}${YLW}${BLD}${plugin:t}.${RST}${RED} Try again later or figure out what went wrong..."
            fi
            popd -q
        done
    }

  case $1 in
    plugin|theme)
      install_custom "$type" "${@:2}"
      ;;
    update)
      update_custom
      ;;
    remove)
      remove_custom "$2" "$3"
      ;;
    *)
      usage
      ;;
  esac
  }
  main "$@"
}

omz-custom plugin \
    "djui/alias-tips" \
    "wfxr/forgit" \
    "Bhupesh-V/ugit" \
    "marlonrichert/zsh-autocomplete" \
    "hlissner/zsh-autopair" \
    "zsh-users/zsh-autosuggestions" \
    "zsh-users/zsh-completions" \
    "zsh-users/zsh-syntax-highlighting"

omz-custom theme "romkatv/powerlevel10k"
