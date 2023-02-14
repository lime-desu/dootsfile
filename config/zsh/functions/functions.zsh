cdtmp() {
  if [[ -z "$1" ]]; then
    tmpdir="$(mktemp -d -t tempdir.XXXXXX)"
  else
    tmpdir="/tmp/$1"
  fi

  [[ ! -d "$tmpdir" ]] && mkdir "$tmpdir"
  cd "$tmpdir" || exit 1
  echo "${CYN}Changed to temp directory: ${BLU}$(pwd)${RST}"
}

colors() {
  for color in {0..255}; do
    print -Pn "%K{$color}  %k%F{$color}${(l:3::0:)color}%f " \
      ${${(M)$((color%6)):#3}:+$'\n'}
  done
}

cheat() {
  if ! command -v cht.sh > /dev/null; then
    echo "installing cheat.sh and it's dependencies..."
    curl -s https://cht.sh/:cht.sh | tee ~/.local/bin/cht.sh && chmod +x ~/.local/bin/cht.sh
    sudo dnf install rlwrap virtualenv
    cht.sh --standalone-install ${XDG_DATA_HOME:-$HOME/.local/share}/cheat.sh
  fi
  ~/.local/bin/cht.sh --shell
}
wtfis() { curl -s "cheat.sh/${@:-cheat}" | sed -e 's/cheat/wtfis/g' | bat --plain -l=md || less -R } > /dev/tty

bak() {
    if [ -d "$1" ]; then
        echo "${BLD}${RED}Error: ${YLW}$1${RST} is a directory"
    else
        backup_file=${2:-$1.bak}
        cp -T "$1" "$backup_file"
    fi
}

help() {
    "$@" --help 2>&1 | bat --plain --language=help
}

up(){
  local dir=""
  limit=$1
  for ((i=1 ; i <= limit ; i++))
  do
    dir=$dir/..
  done
  dir=$(echo $dir | sed 's/^\///')
  cd "${dir:-..}"
}

path() { echo ${PATH//:/\\n} }
silent() { "$@" > /dev/null 2>&1; }
unique() { awk '!seen[$0]++' "$1"; }

update() {
  sudo dnf makecache && topgrade -y;
  omz-custom update
  git -C $OMT_DIR pull;
}
