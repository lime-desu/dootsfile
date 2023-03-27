# dootsfile
🏠 - Personal Dotfiles (Managed by GNU Stow)

![Bocchi](https://user-images.githubusercontent.com/114978689/227949867-bbb1dcb5-8914-434b-83fd-980975e61257.jpg "Current Setup")

## Tools Overview

- **DE**: [Gnome](https://www.gnome.org/)
  - **Extensions**: (*[config included](https://github.com/lime-desu/dootsfile/tree/main/share/gnome-shell/extensions)*)
    -  [arcmenu](https://extensions.gnome.org/extension/3628/arcmenu/)
    -  [aylurs-widgets](https://extensions.gnome.org/extension/5338/aylurs-widgets/)
    -  [dash-to-dock](https://extensions.gnome.org/extension/307/dash-to-dock/)
    -  [hidetopbar](https://extensions.gnome.org/extension/545/hide-top-bar/)
    -  [just-perfection](https://extensions.gnome.org/extension/3843/just-perfection/)
    -  [pano](https://extensions.gnome.org/extension/5278/pano/)
    -  [pop-os-shell](https://github.com/pop-os/shell)
    -  [rounded-window-corners](https://extensions.gnome.org/extension/5237/rounded-window-corners/)
- **OS**: [Fedora Linux](https://getfedora.org/)
- **Shell**: zsh
  - **Framework**: [oh-my-zsh](https://ohmyz.sh/)
  - **Plugin Manager**: [custom](https://github.com/lime-desu/dootsfile/blob/main/config/zsh/functions/oh-my-zsh.zsh)
  - **Prompt**: [Starship](https://starship.rs/) ([p10k](https://github.com/romkatv/powerlevel10k) as fallback)
- **Terminal**: alacritty, foot
- **Editor**: [Neovim](https://github.com/neovim/neovim/) (using [LazyVim](https://www.lazyvim.org/) configuration)
- **Browser**: [Librewolf](https://librewolf.net/)/Firefox
- **Fonts**: Jetbrains Mono [Nerd Font](https://www.nerdfonts.com/), SF Pro Mono
- **Icons**:
  - **Application**: [Skeouwaita](https://github.com/Frostbitten-jello/Skeuowaita)
  - **Cursor**: [Catppuccin Cursor](https://github.com/catppuccin/cursors), [Phinger Cursors](https://github.com/phisch/phinger-cursors)
- **Colorscheme**: [Catppuccin](https://github.com/catppuccin/catppuccin) Mocha (Lavender)

### Installation

**Automatic:**

<details>
  <summary><strong> Prerequisites </strong></summary>

Any Nerd Fonts installed and used by your terminal emulator to display icon (Highly Recommended: JetBrains Mono, since most of the config using this font)

You can use my script to download any Nerd Fonts
(requires [fzf](https://github.com/junegunn/fzf))
```
bash -c "$(curl -Ls https://raw.githubusercontent.com/lime-desu/dootsfile/main/bin/nf-dl)"
```
<details>
  <summary>Setup Script Dependencies </summary>

  You don't need to install any of these item listed below since they are already installed on your system, and included on the setup script as well

| Packages | Description | 
| :---     | :----| 
|  chsh    | Util-Linux (system utilities)
|  curl    | Transfer a URL
|  git     | Version Control System
|  jq      | Command-line JSON processor
|  stow    | Manage farms of symbolik links
|  tar     | An archiving utility
|  wget    | The non-interactive network downloader
|  zsh     | Powerful interactive shell

</details>

<details>
  <summary> Packages List </summary>

  #### Applications:

  Following packages that will be installed on the setup script:

| Packages      | Arch | Debian |Fedora | Void | Description |
| :---          | :--- | :---   | :---  | :--- | :----| 
|  alacritty    | ✓    | ✗      | ✓     | ✓    | Fast, cross-platform, OpenGL terminal Emulator 
|  foliate      | ✓    | ✗      | ✓     | ✓    | A Simple and modern GTK eBook reader
|  foot         | ✓    | ✓      | ✓     | ✓    | Lightweight Wayland terminal emulator
|  mpv          | ✓    | ✓      | ✓     | ✓    | A media player
|  kitty        | ✓    | ✓      | ✓     | ✓    | Cross-platform, fast, feature rich, GPU based terminal

| Flatpak Packages      | Description |
| :---                  | :---        |
| amberol               | Plays music, and nothing else
| flatseal              | Utility to manage Flatpak Applications Permission
| junction              | Application chooser for opening files and links
| gradience             | Change the look of adwaita with ease

  **Command Line Utilities** *(Mostly [Modern Unix](https://github.com/ibraheemdev/modern-unix))*

| Packages      | Arch | Debian |Fedora | Void | Description |
| :---          | :--- | :---   | :---  | :--- | :----| 
|  bat          | ✓    | ✓      | ✓     | ✓    | A Cat(1) clone with wings
|  broot        | ✓    | ✗      | ✗     | ✓    | A tree explorer and a customizable launcher
|  btop         | ✓    | ✓      | ✓     | ✓    | Modern Resources Monitor Utility
|  cava         | ✗    | ✓      | ✓     | ✓    | Console-based Audio Visualizezr for Alsa
|  chafa        | ✓    | ✓      | ✓     | ✓    | Terminal graphics and character art generator.
|  delta        | ✓    | ✗      | ✓     | ✓    | Syntax-highlighting pager for git, diff etc.
|  dust         | ✓    | ✗      | ✗     | ✓    | A more intuitive version of du in rust
|  exa          | ✓    | ✓      | ✓     | ✓    | Modern replacement for ls
|  fd           | ✓    | ✓      | ✓     | ✓    | Simple, fast and user-friendly alternative to find
|  fuck         | ✓    | ✓      | ✓     | ✓    | App that corrects your previous console command
|  fzf          | ✓    | ✓      | ✓     | ✓    | A command-line fuzzy finder
|  lsd          | ✓    | ✗      | ✓     | ✓    | Ls command with pretty colors and some other stuff
|  neofetch     | ✓    | ✓      | ✓     | ✓    | CLI system information tool
|  ripgrep      | ✓    | ✓      | ✓     | ✓    | Command Line oriented search tool
|  starship     | ✓    | ✗      | ✗     | ✓    | Cross platform shell prompt
|  tldr         | ✓    | ✗      | ✓     | ✓    | Fast and customizable TLDR Client (tealdeer)
|  tmux         | ✓    | ✓      | ✓     | ✓    | A terminal multiplexer
|  unzip        | ✓    | ✓      | ✓     | ✓    | A utility for unpacking zip files
|  wl-clipboard | ✓    | ✓      | ✓     | ✓    | Command-line copy/paste utilities for Wayland


  <sub><sup>*Foliate is available on Debian, but it isn't available on Ubuntu (only on 3rd party repo PPA) so I didn't include it.* </sub></sup>
  <sub><sup>*If the package manager can't find all the necessary packages, it will fail to install and won't do anything* </sub></sup>

  Required version:
  - `fzf` >= 0.30 (***deps:*** *bat, broot, fd lsd rg wl-copy*)
  - `lsd` >= 0.23.1
  - `neovim` >= 0.8.0 (***deps:*** *C Compiler and Nodejs*)

  Also include essential group of packages for building and compiling

  </details>
</details>

> **Note** *Prior running the script ensure that environment variable are set. (`echo $XDG_CURRENT_DESKTOP`)*

using **curl**
```
bash -c "$(curl -Ls https://raw.githubusercontent.com/lime-desu/dootsfile/main/setup.sh)"
```

using **wget**
```
bash -c "$(wget -O - https://raw.githubusercontent.com/lime-desu/dootsfile/main/setup.sh)"
```

> **Warning** *Please review the script first before executing. Don't blindly run it. Consider running it on a new machine*

**Manually**:

> **Note** This README is wip, and some of the info may be outdated. Configuration in this repo are subject to change overtime."

### Keybindings
<details>
  <summary><strong> Firefox </strong></summary>

  | Keyword | Search |
  | --- | --- |
  | <kbd>:g</kbd>                                                                                               | [Google](https://www.google.com/) |
  | <kbd>:y</kbd>,<br><kbd>:y/</kbd> (most viewed), <br><kbd>:y//</kbd> or <kbd>:yt</kbd> (most viewed by year) | [Youtube](https://www.youtube.com/) |
  | <kbd>:r</kbd> or <kbd>:re</kbd>, <br> <kbd>:r/</kbd> or <kbd>r/</kbd> (subreddit)                           | [Reddit](https://www.reddit.com/) |
  | <kbd>:q</kbd>                                                                                               | [Quora](https://www.quora.com/) |
  | <kbd>:gh</kbd>, <kbd>:gh/</kbd> (most stars)                                                                | [GitHub](https://github.com) |
  | <kbd>:so</kbd>                                                                                              | [Stack Overflow](https://stackoverflow.com) |
  | <kbd>:use</kbd>                                                                                             | [Unix Stack Exchange](https://unix.stackexchange.com/) |
  | <kbd>:dd</kbd>                                                                                              | [DevDocs](https://devdocs.io/) |
  | <kbd>:mdn</kbd>                                                                                             | [MDN Web Docs](https://developer.mozilla.org/en-US/) |
  | <kbd>:var</kbd>                                                                                             | [CODELF](https://unbug.github.io/codelf/) |
  | <kbd>:aw</kbd>                                                                                              | [Arch Wiki](https://wiki.archlinux.org/) |
  | <kbd>:fed</kbd>                                                                                             | [Ask Fedora](https://ask.fedoraproject.org/) |
  | <kbd>:man</kbd>                                                                                             | [Mankier](https://www.mankier.com/) |
  | <kbd>:cnf</kbd>                                                                                             | [Command Not Found](https://command-not-found.com/) |
  | <kbd>:xsh</kbd>                                                                                             | [Explain Shell](https://www.explainshell.com/) |
  | <kbd>:ia</kbd> or <kbd>:wm</kbd>                                                                            | [Internet Archive (Wayback Machine)](https://archive.org/) |
  | <kbd>:mw</kbd>                                                                                              | [Merriam Webster Dictionary](https://www.merriam-webster.com/) |
  | <kbd>:ud</kbd>                                                                                              | [Urban Dictionary](https://www.urbandictionary.com/) |
  | <kbd>:alt</kbd>                                                                                             | [AlternativeTo](https://alternativeto.net/) |
  | <kbd>:subs</kbd>                                                                                            | [OpenSubtitles](https://www.opensubtitles.org/en/search/subs) |
  | <kbd>:dl</kbd>                                                                                              | [DeepL (to EN)](https://www.deepl.com/translator) |
  | <kbd>:tl</kbd>                                                                                              | [Google Translate (to EN)](https://translate.google.com/) |
  | <kbd>:maps</kbd>                                                                                            | [Google Maps](https://maps.google.com/) |
  | <kbd>:lib</kbd> or <kbd>:aa</kbd>                                                                           | [Anna's Archive](https://annas-archive.org/) |
  | <kbd>:libgen</kbd> or <kbd>:lg</kbd>                                                                        | [Library Genesis](https://www.libgen.is/) |
  | <kbd>:gr</kbd>                                                                                              | [Goodreads](https://www.goodreads.com/) |

  And many more some weeb and pirate stuff..
  You can find all of the list on `about:preferences#search`

  **Pro Tip:** Pressing `Ctrl-L` or `Alt-D` will focus on search bar
  
  **Adding custom search engine:**
  
  By default it is disabled you have to enabled it first,
  on `about:config` add this line and set it to true
  ```
  browser.urlbar.update2.engineAliasRefresh
  ```
  Also suggest me some good search engines to add...

</details>

<details>
  <summary><strong> GNOME </strong></summary>
	
  | Key | Action |
  | :-  | :-  |
  | <kbd>Super</kbd> + <kbd>Enter</kbd>                                      | Open Foot (Terminal Emulator) |
  | <kbd>Super</kbd> + <kbd>Enter</kbd>                                      | Open Alacritty (Terminal Emulator inside tmux) |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd>                       | Close window |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>M</kbd>                       | Maximize window | 
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>1-4</kbd>                     | Move window to workspace number 1-4 |
  | <kbd>Super</kbd> + <kbd>1-4</kbd>                                        | Switch to workspace number 1-4 |
  | <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Left/Right</kbd>                 | Move to the Left/Right workspace |
  | <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shift</kdb> <kbd>Left/Right</kbd>| Move window one workspace to the Left/Right |
  | <kbd>Alt</kbd> + <kbd>Tab</kbd>                                          | Switch windows |
  | <kbd>Super</kbd> + <kbd>Tab</kbd>                                        | Switch Application (Gnome default alt-tab behaviour)|
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd>                       | Hide all normal windows |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd>                       | Change Wallpaper Randomly |
  | <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>                          | Open Gnome Terminal |
  | <kbd>Super</kbd> + <kbd>N</kbd>                                          | Open Neovim (Text Editor) |
  | <kbd>Super</kbd> + <kbd>F</kbd>                                          | Open Foliate (Ebook Reader) |
  | <kbd>Super</kbd> + <kbd>E</kbd>                                          | Open Nautilus (File Manager) |
  | <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Del</kbd>                        | Rickroll (Opens on Foot Terminal) |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>                       | Record a screencast |
  | <kbd>Super</kbd> + <kbd>I</kbd>                                          | Open Settings |
  | <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Esc</kbd>                      | System Monitor |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd>                       | Logout/Exit |

  Shell Extension bindings:
  - Arcmenu: <kbd>Super</kbd> + <kbd>D</kbd>  - Arcmenu runner
  - Colorpicker: <kbd>Super</kbd> + <kbd>0</kbd>  - Toggle colorpicker
  - Pop Os Shell: <kbd>Super</kbd> + <kbd>R</kbd>  - Adjustment Mode
  - Pano: <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>V</kbd> - Show pano clipboard

  - [Official Documentation](https://help.gnome.org/users/gnome-help/stable/shell-keyboard-shortcuts.html.en)
  - [Pop Os Shell Keyboard Shortcuts](https://support.system76.com/articles/pop-keyboard-shortcuts/)

  > <kbd>Super</kbd> = <kbd>Windows Logo Key</kbd>
	
</details>

<details>
  <summary><strong> Neovim </strong></summary>
	
  - <kbd>Leader</kbd> - to show which-key
  - <kbd>Leader</kbd> + <kbd>s</kbd> + <kbd>k</kbd> - to search all keybindings
  - [Official Documentation](https://www.lazyvim.org/keymaps)	

  > <kbd>Leader</kbd> = <kbd>Space</kbd>
	
</details>

<details>
  <summary><strong> Tmux </strong></summary>
	
  - <kbd>Prefix</kbd> + <kbd>?</kbd> - to show the list of all keybindings
  - [Official Documentation](https://github.com/gpakosz/.tmux#bindings)

  > <kbd>Prefix</kbd> = <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd>
	</details>

<details>
  <summary><strong> Zsh </strong></summary>
	
  | Key | Details |
  | :-  | :-  |
  | <kbd>Alt</kbd> + <kbd>Enter</kbd>                     | Accept and hold (execute command and don't clear it)
  | <kbd>Alt</kbd> + <kbd>Left/Right</kdb>                | Dircycle (Browser like navigating directory stacks `dirs -v`)
  | <kbd>Ctrl-x</kbd> + <kbd>Ctrl-v</kbd>                 | Edit and paste clipboard (Similar to edit command-line(`Ctrl-x`+`Ctrl-e`))
  | <kbd>Ctrl</kbd> + <kbd>Q</kbd>                        | Save input (Pressing Ctrl-q will Store/Restore input to buffer)
  | <kbd>Ctrl-x</kbd> + <kbd>Ctrl-q</kbd>                 | Paste then edit saved input
  | <kbd>Ctrl</kbd> + <kbd>J</kbd>                        | Insert command substitution (`$()`)
  | <kbd>Alt</kbd> + <kbd>S</kbd>                         | Insert sudo at the beggining of the line
  | <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd>      | Execute previous command with sudo (sudo !! + enter)
  | <kbd>Alt</kbd> + <kbd>L</kbd>                         | Execute ls (if the buffer is empty else transform it to lowercase)
  | <kbd>Alt</kbd> + <kbd>G</kbd>                         | Execute git status (if inside on a git repository)
  | <kbd>.</kbd>                                          | Rationalise dot (Expands .. to ../..)
  | <kbd>Ctrl</kbd> + <kbd>/</kbd>                        | View in pager (open in pager the previous executed command)
  | <kbd>Ctrl</kbd> + <kbd>D</kbd>                        | Force exit (by default if the buffer is not empty, zsh won't exit)

<details open>
  <summary><strong> Fzf Widgets </strong></summary>

  > <kbd>Alt</kbd> + <kbd>?</kbd> will show list of fzf keybinds

  | Key | Details |
  | :-      | :-          |
  | <kbd>Alt</kbd> + <kbd>M</kbd>                         | Manpages Widget (list all manpages can preview with tldr, and cheat.sh)
  | <kbd>Ctrl</kbd> + <kbd>F</kbd>                        | Ripgrep Widget (ripgrep launcher + fzf as secondary filter)
  | <kbd>Alt</kbd> + <kbd>I</kbd>                         | Locate Widget (quickly find files with index database using locate command)
  | <kbd>Ctrl</kbd> + <kbd>T</kbd>                        | File Widget (Fzf Default Keybindings)
  | <kbd>Alt</kbd> + <kbd>C</kbd>                         | Cd Widget (Fzf Default Keybindings)
  | <kbd>Alt</kbd> + <kbd>Shift</kbd> + <kbd>C</kbd>      | Cd Recent Directory Widget (based on your dirstack)
  | <kbd>Ctrl</kbd> + <kbd>R</kbd>                        | History Widget (reverse history search, if there's atuin installed use it)
  | <kbd>Alt</kbd> + <kbd>A</kbd>                         | Alias Widget (search all aliases)
  | <kbd>Alt</kbd> + <kbd>F</kbd>                         | Functions Widget (search function list)
  | <kbd>Alt</kbd> + <kbd>D</kbd>                         | Dictionary Widget (based on /usr/share/dict/words)

</details>

  > List all zsh keybinds: `bindkey -M <keymap>` (`bindkey -l` to list all keymap)

</details>
