omz_update_custom_plugins() {
    red=$(tput setaf 1)
    grn=$(tput setaf 2)
    ylw=$(tput setaf 3)
    blu=$(tput setaf 4)
    rst=$(tput sgr0)
    bld=$(tput bold)

    echo ""
    printf "${blu}${bld}%s${rst}\n" "Updating custom plugins..."

    find "${ZSH_CUSTOM:-$ZSH/custom}" -type d -name ".git" | while read LINE; do
        plugin=${LINE:h}
        pushd -q "${plugin}"

        if git pull --rebase; then
            printf "%s${rst}\n" ${ylw}${bld}"${plugin:t}${rst} ${grn}has been updated and/or is at the current version.${rst}"
        else
            printf "%s${rst}\n" "${red}There was an error updating ${rst}${ylw}${bld}${plugin:t}.${rst}${red} Try again later or figure out what went wrong..."
        fi
        popd -q
    done
}
