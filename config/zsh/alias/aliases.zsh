alias \
    sudo='sudo ' \
    off='poweroff' \
    sus='systemctl suspend' \
    open='xdg-open' \
    reload='exec $SHELL -l' \
    r='reload' \
    ip="ip -human -color addr" \
    myip="ip | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' && curl ifconfig.me; echo" \
    rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash' \
    lsbl='cd > /dev/null ;fd --hidden --follow --type=l' # list broken links

alias \
    alacrittyrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.yml" \
    fzfrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzfrc" \
    gitrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/git/config" \
    gitignorerc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/git/gitignore" \
    hyprlandrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprland.conf" \
    kittyrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf" \
    nvimrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/after/plugin/defaults.lua" \
    tmuxrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/config}/tmux/tmux.conf.local" \
    zshrc="$EDITOR ${ZDOTDIR:-$HOME/.config/zsh}/.zshrc" \
    zshenv="$EDITOR ${ZDOTDIR:-$HOME/.config/zsh}/.zshenv" \
    {v,vim}="$EDITOR" \

alias \
    update-grub="sudo grub2-mkconfig -o /etc/grub2.cfg && sudo grub2-mkconfig -o /etc/grub2-efi.cfg && sudo grub2-mkconfig -o /boot/grub2/grub.cfg" \
    reinstall-grub="sudo rm -iv /boot/efi/EFI/fedora/grub.cfg && sudo rm -iv /boot/grub2/grub.cfg; sudo dnf reinstall 'shim-*' 'grub2-efi-*' grub2-common"

autoload -Uz tetriscurses
alias tetris=tetriscurses

(( ! $+commands[dust] )) && { alias dust='du --summarize -h * | sort --reverse -h'; }
(( $+commands[nala] )) && { alias apt='nala'; }
(( $+commands[pkg] )) && { alias pkg='nala'; }
[[ -n $TERMUX_APP_PID ]] && alias reload='exec $SHELL -l && termux-reload-settings'
