# dootsfile
🏠 - Personal Dotfiles (Managed by GNU Stow)

### Installation
<details open>
  <summary><strong> Prerequisites </strong></summary>

Any Nerd Fonts installed and used by your terminal emulator to display icon (Highly Recommended: JetBrains Mono, since most of the config using this font)

You can use my script to download any Nerd Fonts
(requires [fzf](https://github.com/junegunn/fzf))
```
bash -c "$(curl -Ls https://raw.githubusercontent.com/lime-desu/dootsfile/main/bin/nf-dl)"
```
<details>
  <summary>Setup Script Dependencies </summary>

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

| Method    | Command                                                                                     |
| :-------- | :-----------------------------------------------------------------------------------------  |
| **curl**  | `bash -c "$(curl -Ls https://raw.githubusercontent.com/lime-desu/dootsfile/main/setup.sh)"`   |
| **wget**  | `bash -c "$(wget -O - https://raw.githubusercontent.com/lime-desu/dootsfile/main/setup.sh)"`  |

> **Warning** *It's a good idea to take a look at the script and inspect and review it first to know what it does.*

<details>
<summary><strong> Setup Script Summary </strong></summary>

  - Will automatically install all the necessary packages and dependencies
  - Get all the files from the source (and store it on `$HOME/Git/Local/dootsfile`)
  - Using [stow](https://www.gnu.org/software/stow/) to symlink it based on their xdg-spec directories (Backup existing files and rename with `.doots` extension.)
  - Setup zsh as a default shell, after setting this up:
    - it will automatically install and use [Oh-My-Zsh](https://ohmyz.sh/) framework and download it's [defined custom plugins](https://github.com/lime-desu/dootsfile/blob/84da632afbcba8f1b5f691352d31ab1dec26c57e/config/zsh/functions/oh-my-zsh.zsh#L83)
    - will also download and setup [Oh-My-Tmux](https://github.com/gpakosz/.tmux) too.
  - Set up Firefox/Librewolf search engine shortcuts (Not custom CSS).
    - for quick search, e.g.: `:gh` for github search, `:r/` subreddit search, `:so` stackoverflow search,`:y` youtube search and etc.
    - and it will also execute [Firefox-Ui-Fix](https://github.com/black7375/Firefox-UI-Fix) installation script
  - Install [phinger-cursors](https://github.com/phisch/phinger-cursors), [catppuccin-cursors](https://github.com/catppuccin/cursors), [neocowsay](https://github.com/Code-Hex/Neo-cowsay), and [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) (will fetch it from github releases)
  - If on Gnome De:
    - Execute [catppuccin/gnome-terminal](https://github.com/catppuccin/gnome-terminal) script and apply it, and update some gnome settings.
    - This will also import all of my Gnome Keybindings (including Custom keybindings, and Gnome Shell Shortcut aswell as [Pop!_Os-Shell](https://github.com/pop-os/shell) too)
  - Lastly, if Flatpak is installed, Install useful apps: [Amberol](https://flathub.org/apps/details/io.bassi.Amberol), [Flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal), [Junction](https://flathub.org/apps/details/re.sonny.Junction), [Gradience](https://flathub.org/apps/details/com.github.GradienceTeam.Gradience) and [Extension Manager](https://flathub.org/apps/details/com.mattjakeman.ExtensionManager) (on Gnome)

 </details>
 
  **Testing this out on a temporary installation:**
  ```sh
  temp_dir=$(mktemp -d)                   # create tempdir variable
  export HOME=$temp_dir                   # set it as $HOME directory to don't dirty your ~
  cd $temp_dir                            # cd into it, then ran the setup script above
  ```
  
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
  | <kbd>Super</kbd> + <kbd>Enter</kbd>                                      | Open Alacritty (Terminal Emulator) |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>Q</kbd>                       | Close window |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>M</kbd>                       | Maximize window | 
  | <kbd>Super</kbd> + <kbd>R</kbd>                                          | Adjustment Mode (PopOS Shell Extension)|
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>1-4</kbd>                     | Move window to workspace number 1-4 |
  | <kbd>Super</kbd> + <kbd>1-4</kbd>                                        | Switch to workspace number 1-4 |
  | <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Left/Right</kbd>                 | Move to the Left/Right workspace |
  | <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Shift</kdb> <kbd>Left/Right</kbd>| Move window one workspace to the Left/Right |
  | <kbd>Alt</kbd> + <kbd>Tab</kbd>                                          | Switch windows |
  | <kbd>Super</kbd> + <kbd>Tab</kbd>                                        | Switch Application (Gnome default alt-tab behaviour)|
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>D</kbd>                       | Hide all normal windows |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>W</kbd>                       | Change Wallpaper Randomly |
  | <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>T</kbd>                          | Open Foot (Terminal Emulator) |
  | <kbd>Super</kbd> + <kbd>N</kbd>                                          | Open Neovim (Text Editor) |
  | <kbd>Super</kbd> + <kbd>F</kbd>                                          | Open Foliate (Ebook Reader) |
  | <kbd>Super</kbd> + <kbd>E</kbd>                                          | Open Nautilus (File Manager) |
  | <kbd>Ctrl</kbd> + <kbd>Alt</kbd> + <kbd>Del</kbd>                        | Rickroll (Opens on Foot Terminal) |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>R</kbd>                       | Record a screencast |
  | <kbd>Super</kbd> + <kbd>I</kbd>                                          | Open Settings |
  | <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>Esc</kbd>                      | System Monitor |
  | <kbd>Super</kbd> + <kbd>Shift</kbd> + <kbd>E</kbd>                       | Logout/Exit |

  - [Official Documentation](https://help.gnome.org/users/gnome-help/stable/shell-keyboard-shortcuts.html.en)
  - [Pop Os Shell Keyboard Shortcuts](https://support.system76.com/articles/pop-keyboard-shortcuts/)

  > <kbd>Super</kbd> = <kbd>Windows Logo Key</kbd>
	
</details>

<details open>
  <summary><strong> Neovim </strong></summary>
	
  - <kbd>Leader</kbd> - to show which-key
  - <kbd>Leader</kbd> + <kbd>s</kbd> + <kbd>k</kbd> - to search all keybindings
  - [Official Documentation](https://www.lazyvim.org/keymaps)	

  > <kbd>Leader</kbd> = <kbd>Space</kbd>
	
</details>

<details open>
  <summary><strong> Tmux </strong></summary>
	
  - <kbd>Prefix</kbd> + <kbd>?</kbd> - to show the list of all keybindings
  - [Official Documentation](https://github.com/gpakosz/.tmux#bindings)

  > <kbd>Prefix</kbd> = <kbd>Ctrl</kbd> + <kbd>a</kbd> or <kbd>Ctrl</kbd> + <kbd>b</kbd>
	</details>

<details open>
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
