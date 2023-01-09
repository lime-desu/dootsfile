define_colors() {
if command -v tput > /dev/null 2>&1; then
    # colors
    BLK="$(tput setaf 0)"
    RED="$(tput setaf 1)"
    GRN="$(tput setaf 2)"
    YLW="$(tput setaf 3)"
    BLU="$(tput setaf 4)"
    MGN="$(tput setaf 5)"
    CYN="$(tput setaf 6)"
    WHT="$(tput setaf 7)" 
    # formatting
    RST="$(tput sgr0)"   # reset all formatting
    BLD="$(tput bold)"   # makes the text bold
    DIM="$(tput dim)"    # makes the text dim
    SUL="$(tput smul)"   # set underline
    RUL="$(tput rmul)"   # remove underline
    REV="$(tput rev)"    # reverses fg and bg colors
    SHL="$(tput smso)"   # start standout mode (set highlight)
    EHL="$(tput rmso)"   # end standout mode(remove highlight)
else
    BLK="\033[0;30m"
    RED="\033[0;31m"
    GRN="\033[0;32m"
    YLW="\033[0;33m"
    BLU="\033[0;34m"
    MGN="\033[0;35m"
    CYN="\033[0;36m"
    WHT="\033[0;37m"

    RST="\033[0m"
    BLD="\033[1m"
    DIM="\033[2m"
    SUL="\033[4m" 
    RUL="\033[24m"
    REV="\033[7m"
    SHL="\033[7m" 
    EHL="\033[27m" 
fi
}

