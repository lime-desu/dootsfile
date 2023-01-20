alias \
    ip="ip -human -color addr" \
    myip="ip | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' && curl ifconfig.me; echo" \
    lsbl='cd > /dev/null ;fd --hidden --follow --type=l' # list broken links

alias \
    off='poweroff' \
    sus='systemctl suspend' \
    open='xdg-open' \
    reload='exec $SHELL -l' \
    r='reload' \
    rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash' \
    lofi='mpv --no-video https://youtu.be/jfKfPfyJRdk'

alias \
    cp='cp -iv' \
    mv='mv -iv' \
    rm='rm -iv' \
    md='mkdir -pv';

alias \
    alacrittyrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/alacritty.yml" \
    fzfrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/fzf/fzfrc" \
    gitrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/git/config" \
    gitignorerc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/git/gitignore" \
    hyrlandrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprland.conf" \
    kittyrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/kitty/kitty.conf" \
    nvimrc="$EDITOR ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/after/plugin/defaults.lua" \
    tmuxrc="$EDITOR $HOME/.tmux.conf.local" \
    zshrc="$EDITOR ${ZDOTDIR:-$HOME/.config/zsh}/.zshrc" \
    zshenv="$EDITOR ${ZDOTDIR:-$HOME/.config/zsh}/.zshenv" \
    {v,vim}="$EDITOR" \

alias \
    update-grub="sudo grub2-mkconfig -o /etc/grub2.cfg && sudo grub2-mkconfig -o /etc/grub2-efi.cfg && sudo grub2-mkconfig -o /boot/grub2/grub.cfg" \
    reinstall-grub="sudo rm -iv /boot/efi/EFI/fedora/grub.cfg && sudo rm -iv /boot/grub2/grub.cfg; sudo dnf reinstall 'shim-*' 'grub2-efi-*' grub2-common"

autoload -Uz tetriscurses
alias tetris=tetriscurses

function create_dust_alias() {
    if ! command -v dust > /dev/null; then
        alias dust='du --summarize -h * | sort --reverse -h'
    fi
}; create_dust_alias
