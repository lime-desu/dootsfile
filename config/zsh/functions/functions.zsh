command_exist() { (( $+commands[$1] )) }
help() { "$@" --help 2>&1 | bat --plain --language=help }
path() { echo ${PATH//:/\\n} }
silent() { "$@" > /dev/null 2>&1; }
unique() { awk '!seen[$0]++' "$1"; }

ani-cli() {
	local anicli=${CLONES:-$HOME/Git/Clones}/ani-cli
	if [[ ! -d ${anicli} ]]; then
		echo "${BLD}${BLU}ani-cli${RST} is not installed. Installing it first..."
		silent git clone https://github.com/pystardust/ani-cli ${anicli}
		ln -sf ${anicli}/ani-cli ${BIN:-$HOME/.local/bin}/ani-cli
	fi
	$BIN/ani-cli "$@"
}

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

cheat() {
	local chtsh=${BIN}/cht.sh
	if ! command -v cht.sh rlwrap >/dev/null; then
		echo "${BLD}${BLU}cheat.sh${RST} is not installed. Installing it now and it's dependencies..."
		curl -s https://cht.sh/:cht.sh >"${chtsh}" && chmod +x "${chtsh}" &&
		install rlwrap
	fi
	${chtsh} --shell
}
wtfis() { curl -s "cheat.sh/${@:-cheat}" | sed -e 's/cheat/wtfis/g' | bat --plain -l=md || less -R } > /dev/tty

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

xdg-ninja() {
	local xdgninja=${CLONES:-$HOME/Git/Clones}/xdg-ninja
	if [[ ! -d ${xdgninja} ]]; then
		echo "${BLD}${BLU}xdg-ninja${RST} is not installed. Installing it first..."
		silent git clone https://github.com/b3nj5m1n/xdg-ninja.git ${xdgninja}
		ln -sf ${xdgninja}/xdg-ninja.sh ${BIN:-$HOME/.local/bin}/xdg-ninja
	fi
	$BIN/xdg-ninja "$@"
}

ytfzf() {
	local ytfzf_dir=${CLONES:-$HOME/Git/Clones}/ytfzf
	if [[ ! -d ${ytfzf_dir} ]]; then
		echo "${BLD}${BLU}ytfzf${RST} is not installed. Installing it first..."
		silent git clone https://github.com/pystardust/ytfzf.git ${ytfzf_dir}
    cd ${ytfzf_dir} || return && silent sudo make install doc
	fi
	/usr/local/bin/ytfzf "$@"
}
