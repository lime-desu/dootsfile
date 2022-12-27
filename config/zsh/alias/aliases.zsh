alias \
    ls='exa --group-directories-first' \
    ll='ls --long --icons' \
    l='ll --all --icons' \
    l.='ls -d .* --icons' \
    ip="ip -human -color addr" \
    myip="ip | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' && curl ifconfig.me; echo"

alias \
    off='poweroff' \
    sus='systemctl suspend' \
    open='xdg-open' \
    rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash' \
    lofi='mpv --no-video https://youtu.be/jfKfPfyJRdk'

alias \
    cp='cp -iv' \
    mv='mv -iv' \
    rm='rm -iv' \
    md='mkdir -pv';
    
alias \
    update-grub="sudo grub2-mkconfig -o /etc/grub2.cfg && sudo grub2-mkconfig -o /etc/grub2-efi.cfg && sudo grub2-mkconfig -o /boot/grub2/grub.cfg" \
    reinstall-grub="sudo rm -iv /boot/efi/EFI/fedora/grub.cfg && sudo rm -iv /boot/grub2/grub.cfg; sudo dnf reinstall 'shim-*' 'grub2-efi-*' grub2-common"
