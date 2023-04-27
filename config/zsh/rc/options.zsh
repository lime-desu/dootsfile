# History
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST
setopt EXTENDED_HISTORY 
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY

# Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CDABLE_VARS
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Completion
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
# setopt CORRECT              # Turn on spelling correction for command.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.
setopt GLOB_COMPLETE        # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu

zstyle ':completion:*' verbose true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
zstyle ':completion:*:paths' path-completion yes

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%F{cyan}%BSorry, no matches for: %d%b%f'
zstyle ':completion:*:commands' list-colors '=*=1;32'
zstyle ':completion:*:builtins' list-colors '=*=1;33'
zstyle ':completion:*:aliases' list-colors '=*=1;35'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==1;34=34}:${(s.:.)LS_COLORS}")';
