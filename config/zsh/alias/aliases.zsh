alias \
    ls='exa --group-directories-first' \
    ll='ls --long --icons' \
    l='ll --hidden --icons' \
    l.='ls -d .* --icons' \
    ip="ip -human -color addr" \
    myip="ip | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"

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
    
