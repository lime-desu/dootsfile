# install and use any of this cli utilities if the function is invoke, 
# since they are mostly shell scripts and some aren't available on some package manager

# A cli tool to browse and play anime 
ani-cli() {
	local anicli=${CLONES:-$HOME/Git/Clones}/ani-cli
	if ! command_exist anicli && [[ ! -d ${anicli} ]]; then
		echo "${BLD}${BLU}ani-cli${RST} is not installed. Installing it first..."
		silent git clone https://github.com/pystardust/ani-cli ${anicli}
		ln -sf ${anicli}/ani-cli ${BIN:-$HOME/.local/bin}/ani-cli
	fi
	$BIN/ani-cli "$@"
}
# cheat.sh, the only cheat sheet you need
cheat() {
	local chtsh=${BIN}/cht.sh
	if ! command_exist rlwrap; then
		echo "${BLD}${BLU}cheat.sh${RST} is not installed. Installing it now and it's dependencies..."
		curl -s https://cht.sh/:cht.sh >"${chtsh}" && chmod +x "${chtsh}" &&
		install rlwrap
	fi
	${chtsh} --shell
}
# Like "ls", but for images. Shows thumbnails in terminal using sixel graphics.
lsix() {
	local ls_ix=${CLONES:-$HOME/Git/Clones}/lsix
	if ! command_exist lsix && [[ ! -d ${ls_ix} ]]; then
		echo "${BLD}${BLU}lsix${RST} is not installed. Installing it first..."
		silent git clone https://github.com/hackerb9/lsix.git ${ls_ix}
		ln -sf ${ls_ix}/lsix ${BIN:-$HOME/.local/bin}/lsix
	fi
	$BIN/lsix "$@"
}
# ripgrep all
# translate-shell - cli translator using Google Translate, Bing Translator, Yandex.Translate, etc. 
trans() {
	if ! command_exist trans >/dev/null; then
		echo "${BLD}${BLU}trans${RST} is not installed. Installing it first..."
		silent wget git.io/trans && chmod +x ./trans && mv trans "${BIN}"
  fi
	$BIN/trans "$@"
}
# A shell script which checks your $HOME for unwanted files and directories. 
xdg-ninja() {
	local xdgninja=${CLONES:-$HOME/Git/Clones}/xdg-ninja
	if [[ ! -d ${xdgninja} ]]; then
		echo "${BLD}${BLU}xdg-ninja${RST} is not installed. Installing it first..."
		silent git clone https://github.com/b3nj5m1n/xdg-ninja.git ${xdgninja}
		ln -sf ${xdgninja}/xdg-ninja.sh ${BIN:-$HOME/.local/bin}/xdg-ninja
	fi
	$BIN/xdg-ninja "$@"
}
# A posix script to find and watch youtube videos from the terminal. (Without API)
ytfzf() {
	local ytfzf_dir=${CLONES:-$HOME/Git/Clones}/ytfzf
	if ! command_exist ytfzf && [[ ! -d ${ytfzf_dir} ]]; then
		echo "${BLD}${BLU}ytfzf${RST} is not installed. Installing it first..."
		silent git clone https://github.com/pystardust/ytfzf.git ${ytfzf_dir}
    cd ${ytfzf_dir} || return && silent sudo make install doc
	fi 
  /usr/local/bin/ytfzf "$@"
}
