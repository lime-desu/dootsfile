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
  - Set up Firefox/Librewolf search engine shortcuts, you can find it on `about:preferences#search`. (Not custom CSS).
    - shortcut for search engine for quick search, example `:gh` will search on github `:r/` will search subreddit, `:so` stackoverflow,`:y` youtube and etc.
  - Install [phinger-cursors](https://github.com/phisch/phinger-cursors) icons as a mouse/cursor theme and [adw-gtk3](https://github.com/lassekongo83/adw-gtk3) for consistent gtk looking theme (will fetch it from github releases)
  - If on Gnome De:
    - This will also import all my of Gnome Keybindings (including Custom keybindings, and Gnome Shell Shortcut aswell as [Pop!_Os-Shell](https://github.com/pop-os/shell) too)
  - Lastly, if Flatpak is installed, set it up and add the Flathub repository. Install useful apps like [Flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal), [Extension Manager](https://flathub.org/apps/details/com.mattjakeman.ExtensionManager) (on Gnome), and [Junction](https://flathub.org/apps/details/re.sonny.Junction) (for fzf dependencies).
  
 **Additional note:**
> Before running the command make sure you're not on tmux first (some script will not work I found out when I'm inside tmux the $XDG_{CURRENT,SESSION}_DESKTOP became unset idk if this some tmux bug or not)

> The color scheme used is [Catppuccin Mocha](https://github.com/catppuccin) (which has already been set up and configured via its submodules.)

> In Neovim, I use Vanilla [Lazy Vim](https://www.lazyvim.org/) configuration, with the only modification being the Catppuccin color scheme and the Lualine. (idk how to it and i'm still nub)

 </details>
 
  #### Testing this out on a temporary installation:
  ```sh
  # create tempdir and set it as $HOME to do not dirty your home directory
  temp_dir=$(mktemp -d)
  export HOME=$temp_dir
  cd $temp_dir
  # then ran the setup script
  ```
