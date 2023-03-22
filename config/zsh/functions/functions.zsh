command_exist() { (( $+commands[$1] )) }
help() { "$@" --help 2>&1 | bat --plain --language=help }
path() { echo ${PATH//:/\\n} }
silent() { "$@" > /dev/null 2>&1; }
unique() { awk '!seen[$0]++' "$1"; }
wtfis() { curl -s "cheat.sh/${@:-cheat}" | sed -e 's/cheat/wtfis/g' | bat --plain -l=md || less -R } > /dev/tty

bak() {
    if [ -d "$1" ]; then
        echo "${BLD}${RED}Error: ${YLW}$1${RST} is a directory"
    else
        backup_file=${2:-$1.bak}
        cp -T "$1" "$backup_file"
    fi
}

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

install() {
  case "$(command -v dnf apt pacman xbps-install)" in
    *dnf) sudo dnf install "$@" ;;
    *apt) sudo apt install "$@" ;;
    *pacman) sudo pacman -S "$@" ;;
    *xbps-install) sudo xbps-install -S "$@" ;;
  esac
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

update() {
	if command_exist topgrade; then
		topgrade -y
	else
		case "$(command -v dnf apt pacman xbps-install)" in
		*dnf) sudo dnf makecache && sudo dnf upgrade -y ;;
		*apt) sudo apt update && sudo apt upgrade -y ;;
		*pacman) sudo pacman -Syu ;;
		*xbps-install) sudo xbps-install -Syu ;;
		esac
	fi

	echo && omz-custom update && echo       # update Oh-My-Zsh custom plugins
	echo "${BLU}Updating ${BLD}[Oh My Tmux]${RST} ..." && git -C "$OMT_DIR" pull --rebase && echo
	echo "${BLU}Updating ${BLD}Dootsfile${RST} ..." && git -C "$DOOTS" pull --rebase && echo
}
