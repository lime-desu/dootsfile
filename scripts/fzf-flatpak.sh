#!/usr/bin/env sh
# CLR=$(for i in {0..7}; do echo "tput setaf $i"; done)
BLK=\$(tput setaf 0); RED=\$(tput setaf 1); GRN=\$(tput setaf 2); YLW=\$(tput setaf 3); BLU=\$(tput setaf 4); 
MGN=\$(tput setaf 5); CYN=\$(tput setaf 6); WHT=\$(tput setaf 7); BLD=\$(tput bold); RST=\$(tput sgr0);    

AWK_COLOR_VAR=" -v BLK=${BLK} -v RED=${RED} -v GRN=${GRN} -v YLW=${YLW} -v BLU=${BLU} -v MGN=${MGN} -v CYN=${CYN} -v WHT=${WHT} -v BLD=${BLD} -v RST=${RST}"

FZF_FLATPAK_HELP="$(
cat <<-EOF

      ${BLU}${BLD}Fzf-Flatpak.sh     

      ${BLU}${BLD}M-f M-i     ${RST}${CYN}Install apps (flathub repo)
      ${BLU}${BLD}M-f M-u     ${RST}${CYN}Uninstall apps
      ${BLU}${BLD}M-f M-r     ${RST}${CYN}Run apps

      ${BLU}${BLD}M-?         ${RST}${CYN}Help (this page)
      ${BLU}${BLD}ESC         ${RST}${CYN}Exit
EOF
)"

if [[ $- =~ i ]]; then
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
_fzf_flatpak_fzf() {
  fzf-tmux -p85% -- \
    --tiebreak=begin \
    -m --ansi --nth=1.. \
    --color='header:italic:underline' \
    --color='fg:blue,fg+:blue,border:blue' \
    --layout=reverse --height=50% --border \
    --preview-window "nohidden,50%,<50(down,60%,border-rounded)" \
    --bind="alt-?:preview(printf \"${FZF_FLATPAK_HELP}\")"  "$@"
}

_fzf_flatpak_check() {
  which flatpak > /dev/null 2>&1 && return

  [[ -n $TMUX ]] && tmux display-message "Flatpak Isn't Installed"
  return 1
}

__fzf_flatpak=${BASH_SOURCE[0]:-${(%):-%x}}
__fzf_flatpak=$(readlink -f "$__fzf_flatpak" 2> /dev/null || /usr/bin/ruby --disable-gems -e 'puts File.expand_path(ARGV.first)' "$__fzf_flatpak" 2> /dev/null)

_fzf_flatpak_install() {
  _fzf_flatpak_check || return
  flatpak remote-ls flathub --cached --columns=app,name,description 2>/dev/null \
  | awk -v cyn=$(tput setaf 6) -v blu=$(tput setaf 4) -v bld=$(tput bold) -v res=$(tput sgr0) \
  '{
    app_info=""; 
    for(i=3;i<=NF;i++){
      app_info=app_info" "$i 
    }; print blu bld $2" -" res cyn app_info "|" $1}' \
  | column -t -s "|" -R 3 \
  | _fzf_flatpak_fzf  \
    --prompt="  Install > " \
    --header="M-u: Update" \
    --preview "flatpak --system remote-info flathub {-1} | awk $AWK_COLOR_VAR -F\":\" '{print YLW BLD \$1 RST MGN \$2}'" \
    --bind="alt-u:execute(flatpak update > /dev/tty; read -r)" \
    --bind="alt-m:change-preview(flatpak metadata {-1})" \
    --bind "enter:execute(flatpak install flathub {+-1} > /dev/tty)+clear-screen" "$@"
}

# _fzf_flatpak_remotes?() {
# flatpak remotes --columns=name | tail -n +1 
# }

_fzf_flatpak_installed_lists() {
  awk -v cyn=$(tput setaf 6) -v blu=$(tput setaf 4) -v bld=$(tput bold) -v res=$(tput sgr0)  \
  '{
    app_id=""; 
    for(i=2;i<=NF;i++){
      app_id=app_id" "$i
    }; print bld cyn app_id " && - " res blu $1}' \
  | column -t -s "&&" 
}

_fzf_flatpak_installed_lists-applications() {
    flatpak list --columns=application,name | _fzf_flatpak_installed_lists
}

_fzf_flatpak_installed_lists-no_runtimes() {
    flatpak list --app --columns=application,name | _fzf_flatpak_installed_lists
}

# `flatpak run` only accepts one argument so it isn't possible to run multiple apps
_fzf_flatpak_fzf_installed_lists() {
  _fzf_flatpak_fzf \
    --header="M-u: Uninstall | Del: Remove Unused | F4: Kill |M-r: Run" \
    --bind "f4:execute(flatpak kill {+-1})" \
    --bind "del:execute(flatpak remove --unused > /dev/tty; read -r)" \
    --bind "alt-r:change-prompt(  Run > )+execute-silent(touch /tmp/run && rm -r /tmp/uns)" \
    --bind "alt-u:change-prompt(  Uninstall > )+execute-silent(touch /tmp/uns && rm -r /tmp/run)" \
    --bind "enter:execute(
    if [ -f /tmp/uns ]; then 
      flatpak uninstall {+-1} > /dev/tty; 
    elif [ -f /tmp/run ]; then
      flatpak run {-1} > /dev/null; 
    fi
    )" "$@"
  rm -f /tmp/{uns,run} &> /dev/null
}

_fzf_flatpak_uninstall() {
  _fzf_flatpak_check || return
  touch /tmp/uns
  _fzf_flatpak_installed_lists-no_runtimes | _fzf_flatpak_fzf_installed_lists \
    --prompt="  Uninstall > " \
    --preview  "flatpak info {-1} | awk $AWK_COLOR_VAR -F\":\" '{print RED BLD  \$1 RST MGN \$2}'" \
}

_fzf_flatpak_run_apps() {
  _fzf_flatpak_check || return
  touch /tmp/run
  _fzf_flatpak_installed_lists-applications | _fzf_flatpak_fzf_installed_lists \
    --prompt="  Run > " \
    --preview  "flatpak info {-1} | awk $AWK_COLOR_VAR -F\":\" '{print CYN BLD  \$1 RST \$2}'" \
}

if [[ -n "${BASH_VERSION:-}" ]]; then
  __fzf_flatpak_init() {
    bind '"\er": redraw-current-line'
    local o
    for o in "$@"; do
      bind '"\M-f\M-'${o:0:1}'": "`_fzf_flatpak_'$o'`\e\M-e\er"'
      bind '"\M-f'${o:0:1}'": "`_fzf_flatpak_'$o'`\e\M-e\er"'
    done
  }
elif [[ -n "${ZSH_VERSION:-}" ]]; then
  __fzf_flatpak_join() {
    local item
    while read item; do
      echo -n "${(q)item} "
    done
  }

  __fzf_flatpak_init() {
    local o
    for o in "$@"; do
      eval "fzf-flatpak-$o-widget() { local result=\$(_fzf_flatpak_$o | __fzf_flatpak_join); zle reset-prompt; LBUFFER+=\$result }"
      eval "zle -N fzf-flatpak-$o-widget"
      eval "bindkey '^[f^[${o[1]}' fzf-flatpak-$o-widget"
      eval "bindkey '^[f[${o[1]}' fzf-flatpak-$o-widget"
    done
  }
fi
__fzf_flatpak_init install uninstall run_apps
#-----------------------------------------------------------------------------------------------------------------------------------------------------------------
fi
