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
${GRN}  theme  [repos...]   ${RST}    Install one or more custom themes

${GRN}  --help              ${RST}    Display this help message
EOF
  }

  install_custom() {
    local custom_dir="$ZSH_CUSTOM/${1}s"
    for repo in "${@:2}"; do
      local name="${repo##*/}"
      local dir="$custom_dir/$name"
      if [[ ! -d "$dir" ]]; then
        echo "${GRN}Installing ${BLD}${YLW}$name${RST} ${BLU}${1}...${RST}"
        git clone --depth=1 "https://github.com/$repo" "$dir"
      fi
    done
  }

  remove_custom() {
    local custom_dir="$ZSH_CUSTOM/${1}s"
    local dir="$custom_dir/$2"
    if [[ -d "$dir" ]]; then
      echo "${RED}Removing ${BLD}${YLW}$2${RST} ${BLU}${1}...${RST}"
      rm -rf "$dir" > /dev/null && sleep 2; echo "Done."
    else
      echo -e "${BLD}${RED}Error: ${YLW}$2${RST} not found.\n"
      usage
    fi
  }

  update_custom() {
    echo "${BLU}Updating ${BLD}[Oh My Zsh]${RST} ..."
    git -C "$ZSH" pull
    echo ""
    printf "${BLU}%s${RST}\n" "Updating custom plugins and themes..."
    find "$ZSH_CUSTOM" -type d -name ".git" | while read LINE; do
      plugin=${LINE%/.git}
      if git -C "$plugin" pull --rebase; then
        printf "%s${RST}\n" "${YLW}${BLD}${plugin##*/}${RST} ${GRN}has been updated and/or is at the current version.${RST}"
      else
        printf "%s${RST}\n" "${RED}There was an error updating ${RST}${YLW}${BLD}${plugin##*/}.${RST}${RED} Try again later or figure out what went wrong..."
      fi
    done
  }

  main() {
    if [[ ! -d "$ZSH" ]]; then
        echo "${BLU}Installing ${BLD}[Oh My Zsh]${RST} ..."
        git clone https://github.com/ohmyzsh/ohmyzsh.git "$ZSH" && exec $SHELL -l
    fi

    case $1 in
      plugin|theme)
          install_custom "$1" "${@:2}"
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
    "lime-desu/fzf-tab-completion" \
    "Bhupesh-V/ugit" \
    "marlonrichert/zsh-autocomplete" \
    "hlissner/zsh-autopair" \
    "zsh-users/zsh-autosuggestions" \
    "zsh-users/zsh-completions" \
    "zsh-users/zsh-syntax-highlighting"

! command_exist starship && omz-custom theme "romkatv/powerlevel10k"
