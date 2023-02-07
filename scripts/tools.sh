#!/usr/bin/env bash
source "${DOOTS}/config/zsh/functions/colors.zsh"
define_colors

# r̶u̶s̶t̶ linux cli/tui tools and apps that i use
tools=(alacritty atuin bat broot btop chafa cowsay cava delta dust exa fd foot fuck fzf git kitty librewolf lsd mpv pipes.sh neofetch nvim rg starship tldr topgrade tmux zsh)
icons=( 󰳗 󰭟 פּ  󰈟  󰺢      󰚌       ﳣ    󱓞   ﮮ )
flags=("-V" "-V" "-V" "-V" "-v" "--version" "-V" "-v" "-V" "-V" "-v" "-V" "-v" "-v" "--version" "-v" "-v" "-V" "-V" "-V" "-v" "--version" "--version" "-V" "-V" "-v" "-V" "-V" "--version")

printf "${BLD}%-18s %-10s %-10s\n" "Tools" "Status" "Version"
printf "%s\n${RST}" "-----------------------------------------------"
for i in "${!tools[@]}"; do
  tool="${tools[$i]}"
  icon="${icons[$i]}"
  version_flag="${flags[$i]}"
  
  if command -v "$tool" &> /dev/null; then
    version=$("$tool" "$version_flag" 2> /dev/null | awk '{
      for (i = 1; i <= NF; i++) {
        if ($i ~ /[0-9]+\.[0-9]+([.][0-9]+)?/) {
          print $i;
          exit;
        }
      }
    }')
    printf "${BLU}${icon}${RST}${BLD} %-18s ${GRN}%-10s ${RST}${YLW}%-10s\n${RST}" "$tool" "" "$version"
  else
    printf "${CYN}${icon}${RST}${BLD} %-18s ${RED}%-10s ${BLK}%-10s\n${RST}" "$tool" "" "command not found"
  fi
done
