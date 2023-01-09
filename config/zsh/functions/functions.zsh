cdtmp() {
  if [[ -z "$1" ]]; then
    tmpdir="$(mktemp -d -t tempdir.XXXXXX)"
  else
    tmpdir="/tmp/$1"
  fi

  [[ ! -d "$tmpdir" ]] && mkdir "$tmpdir"
  cd "$tmpdir" || exit 1
  echo "Changed to temp directory: $(pwd)"
}

colors() {
  for color in {0..255}; do
    print -Pn "%K{$color}  %k%F{$color}${(l:3::0:)color}%f " \
      ${${(M)$((color%6)):#3}:+$'\n'}
  done
}

cheat() {
  [ -z "$*" ] && printf "Enter a command: " && read -r cmd || cmd=$*
  curl -s cheat.sh/$cmd | bat --plain -l=md || less
}
wtfis() { curl "cheat.sh/$@" }

bak() {
    if [ -d "$1" ]; then
        echo "Error: $1 is a directory"
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

