#!/usr/bin/env bash
source "${DOOTS}/config/zsh/functions/colors.zsh"
define_colors

# r̶u̶s̶t̶ linux cli/tui tools and apps that i use
declare -A tools
tools=(
	[alacritty]=" --version"
	[atuin]="󰳗 --version"
	[bat]="󰭟 --version"
	[broot]="פּ --version"
	[btop]=" --version"
	[chafa]="󰈟 --version"
	[cowsay]=" -h"
	[cava]="󰺢 -v"
	[delta]=" --version"
	[dust]=" --version"
	[exa]=" --version"
	[fd]=" --version"
	[foot]=" --version"
	[fuck]="󰚌 --version"
	[fzf]=" --version"
	[git]=" --version"
	[kitty]=" --version"
	[librewolf]=" --version"
	[lsd]=" --version"
	[mpv]=" --version"
	[pipes.sh]="ﳣ --version"
	[neofetch]=" --version"
	[nvim]=" --version"
	[rg]=" --version"
	[starship]="󱓞 --version"
	[tldr]=" --version"
	[tmux]=" -V"
	[wipe]=" -V"
	[zsh]=" --version"
)

mapfile -t sorted_tools < <(echo "${!tools[@]}" | tr ' ' '\n' | sort)
printf "${BLD}%-18s %-10s %-10s\n" "Tools" "Status" "Version"
printf "%s\n${RST}" "-----------------------------------------------"

for tool in "${sorted_tools[@]}"; do
	IFS=' ' read -r -a tool_data <<<"${tools[$tool]}"
	if command -v "$tool" &>/dev/null; then
		version=$("$tool" "${tool_data[1]}" 2>/dev/null | awk '{
      for (i = 1; i <= NF; i++) {
        if ($i ~ /[0-9]+.[0-9]+([.][0-9]+)?/) {
          print $i;
          exit;
        }
      }
    }')
		printf "${BLU}${tool_data[0]}${RST}${BLD} %-18s ${GRN}%-10s ${RST}${YLW}%-10s\n${RST}" \
			"$tool" "" "$version"
	else
		printf "${CYN}${tool_data[0]}${RST}${BLD} %-18s ${RED}%-10s ${BLK}%-10s\n${RST}" \
			"$tool" "" "command not found"
	fi
done
