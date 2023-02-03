#!/usr/bin/env bash

source ../config/zsh/functions/colors.zsh
define_colors

# r̶u̶s̶t̶ linux cli/tui tools and apps that i use
tools=(alacritty atuin bat broot btop chafa cowsay cava delta dust exa fd foot fuck fzf git kitty librewolf lsd mpv pipes.sh neofetch nvim rg starship tldr topgrade tmux zsh)
LANG=en_US.UTF-8
declare -A icons
icons=(
  [alacritty]=
  [atuin]=󰳗
  [bat]=󰭟
  [broot]=פּ
  [btop]=
  [chafa]=󰈟
  [cowsay]=
  [cava]=󰺢
  [delta]=
  [dust]=
  [exa]=
  [fd]=
  [foot]=
  [fuck]=󰚌
  [fzf]=
  [git]=
  [kitty]=
  [librewolf]=
  [lsd]=
  [mpv]=
  [pipes.sh]=ﳣ
  [neofetch]=
  [nvim]=
  [rg]=
  [starship]=󱓞
  [tldr]=
  [tmux]=
  [topgrade]=ﮮ
  [zsh]=
)

printf "${BLD}%-18s %-10s %-10s\n" "Tools" "Status" "Version"
printf "%s\n${RST}" "-----------------------------------------------"
for tool in "${tools[@]}"; do
  if command -v "$tool" &> /dev/null; then
    version=$("$tool" --version 2> /dev/null | awk '{
      for (i = 1; i <= NF; i++) {
        if ($i ~ /[0-9]+\.[0-9]+([.][0-9]+)?/) {
          print $i;
          exit;
        }
      }
    }')
    printf "${BLU}${icons[$tool]}${RST}${BLD} %-18s ${GRN}%-10s ${RST}${YLW}%-10s\n${RST}" "$tool" "" "$version"
  else
    printf "${CYN}${icons[$tool]}${RST}${BLD} %-18s ${RED}%-10s ${BLK}%-10s\n${RST}" "$tool" "" "command not found"
  fi
done
