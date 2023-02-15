# dootsfile
🏠 - Personal Dotfiles (Managed by GNU Stow)

### Installation

<details>
<summary><strong> Prerequisites </strong></summary>

Must have: `chsh curl git jq nvim stow tar wget zsh`
- **chsh** - for changing your default shell
- **curl/wget and jq** - for downloading stuff on github releases
- **nvim** - as for default editor
- **tar** - for extracting files
- **zsh** - for interactive shell
- **wl-copy** - for clipboard utilities on wayland (optional)
- **hotel** - trivago

Any Nerd Fonts installed on used by your terminal emulator to display icon 
(Highly Recommended: JetBrains Mono, since most of the config using this font)

You can use my script to download any Nerd Fonts
(requires [fzf](https://github.com/junegunn/fzf))
```
sh -c "$(curl -Ls https://raw.githubusercontent.com/lime-desu/dootsfile/main/bin/nf-dl)"
```
or
```
sh -c "$(wget https://raw.githubusercontent.com/lime-desu/dootsfile/main/bin/nf-dl -O -)"
```
</details>

⚠️ _Note: It's a good idea to take a look at the script and inspect it first to know what it does._ 

| Method    | Command                                                                                     |
| :-------- | :-----------------------------------------------------------------------------------------  |
| **curl**  | `sh -c "$(curl -Ls https://raw.githubusercontent.com/lime-desu/dootsfile/main/setup.sh)"`   |
| **wget**  | `sh -c "$(wget https://raw.githubusercontent.com/lime-desu/dootsfile/main/setup.sh -O -)"`  |

And that's all 👌

<details>
<summary><strong> Setup Script Summary </strong></summary>

  - This will get all the files from the source (and store it on `$HOME/Git/Local/dootsfile`)
  - Create symbolic links (using [stow](https://www.gnu.org/software/stow/) for bin, config, icons, and themes, based on xdg-spec directories. (Backup existing files and rename with `.doots` extension.)
  - Setup zsh as a default shell, after setting this up:
    - this will automatically install and use [Oh-My-Zsh](https://ohmyz.sh/) framework and download it's defined custom plugins
    - it will also download [Oh-My-Tmux](https://github.com/gpakosz/.tmux) too and tmux plugins
  - Set up Firefox/Librewolf search engine shortcuts (Not custom CSS).
    - shortcut search engine for quick search, example `:gh` will search on github `:r/` will search subreddit, `:so` stackoverflow,`:y` youtube and etc.
    - and it will also execute [Firefox-Ui-Fix](https://github.com/black7375/Firefox-UI-Fix) installation script
  - Install [phinger-cursors](https://github.com/phisch/phinger-cursors) icons as a mouse/cursor theme and [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) for consistent gtk looking theme (will fetch it from github releases)
  - If on Gnome De:
    - This will also import all my of Gnome Keybindings (including Custom keybindings, and Gnome Shell Shortcut aswell as [Pop!_Os-Shell](https://github.com/pop-os/shell) too)
  - Lastly, if Flatpak is installed, set it up and add the Flathub repository. Install useful apps like [Flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal), [Extension Manager](https://flathub.org/apps/details/com.mattjakeman.ExtensionManager) (on Gnome), and [Junction](https://flathub.org/apps/details/re.sonny.Junction) (for fzf dependencies).
  
 **Additional note:**
> Before running the command make sure you're not on tmux first (some script will not work I found out when I'm inside tmux the $XDG_{CURRENT,SESSION}_DESKTOP became unset idk if this some tmux bug or not)

> The color scheme used is [Catppuccin Mocha](https://github.com/catppuccin) (which has already been set up and configured via its submodules.)

> In Neovim, I use Vanilla [Lazy Vim](https://www.lazyvim.org/) configuration, with the only modification being the Catppuccin color scheme and the Lualine. (idk how to configure it yet and i'm still nub)

 </details>
 
  #### Testing this out on a temporary installation:
  ```sh
  temp_dir=$(mktemp -d)                   # create tempdir variable
  export HOME=$temp_dir                   # set it as $HOME directory to don't dirty your ~
  cd $temp_dir                            # cd into it, then ran the setup script above
  ```
  
  ### Keybindings
  <details>
  <summary><strong> Firefox </strong></summary>

| Search Engine | Keyword |
| :-  | :-  |
| [Google](https://www.google.com/)  | `:g`  |
| [Youtube](https://www.youtube.com/) | `:y` `:y/` (most viewed), `:y//` or `:yt` (most viewed by year)  |
| [Reddit](https://www.reddit.com/)  | `:r` or `:re`, `:r/` or `r/` (subreddit)  |
| [Quora](https://www.quora.com/) | `:q` (sometimes not working detected as a robot xd)
| [GitHub](https://github.com) | `:gh` `:gh/` (most stars) |
| [Stack Overflow](https://stackoverflow.com)  | `:so` |
| [Unix Stack Exchange](https://unix.stackexchange.com/) | `:use`  |
| [DevDocs](https://devdocs.io/) | `:dd` |
| [MDN Web Docs](https://developer.mozilla.org/en-US/)  | `:mdn`
| [CODELF](https://unbug.github.io/codelf/) | `:var` |
| [Arch Wiki](https://wiki.archlinux.org/) | `:aw` |
| [Ask Fedora](https://ask.fedoraproject.org/) | `:fed`  |
| [Mankier](https://www.mankier.com/) | `:man`  |
| [Command Not Found](https://command-not-found.com/) | `:cnf`  |
| [Explain Shell](https://www.explainshell.com/) | `:xsh`  |
| [Internet Archive (Wayback Machine)](https://archive.org/)  | `:ia` or `:wm`  |
| [Merriam Webster Dictionary](https://www.merriam-webster.com/)  | `:mw` |
| [Urban Dictionary](https://www.urbandictionary.com/) | `:ud`  |
| [AlternativeTo](https://alternativeto.net/) | `:alt`  |
| [OpenSubtitles](https://www.opensubtitles.org/en/search/subs) | `:subs` |
| [DeepL (to EN)](https://www.deepl.com/translator) | `:dl` |
| [Google Translate (to EN)](https://translate.google.com/)  | `:tl` |
| [Google Maps](https://maps.google.com/) | `:maps` |
| [Anna's Archive](https://annas-archive.org/)  | `:lib` or `:aa` |
| [Library Genesis](https://www.libgen.is/) | `:libgen` or `:lg`  |
| [Goodreads](https://www.goodreads.com/) | `:gr` |

And many more some weeb and pirate stuff..
You can find all of the list on `about:preferences#search`

**Pro Tip:**

Pressing `Ctrl-L` or `Alt-D` will focus on search bar

**Adding custom search engine:**

By default it is disabled you have to enabled it first,
on `about:config` add this line and set it to true
```
browser.urlbar.update2.engineAliasRefresh
```
Also suggest me some good search engines to add...

</details>
