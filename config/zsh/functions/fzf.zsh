fonts() {
    fc-list | cut -d':' -f2- | sort -u | \
        fzf -d: --prompt="fonts > " \
        --bind="enter:execute(wl-copy {+})" \
}
