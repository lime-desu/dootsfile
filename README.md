# dootsfile
🏠 - Personal Dotfiles (Managed by GNU Stow)

### Installation
⚠️ _Note: It's a good idea to take a look at the script and inspect it first to know what it does._ 

| Method    | Command                                                                                     |
| :-------- | :-----------------------------------------------------------------------------------------  |
| **curl**  | `sh -c "$(curl -Ls https://raw.githubusercontent.com/lime-desu/dootsfile/main/setup.sh)"`   |
| **wget**  | `sh -c "$(wget https://raw.githubusercontent.com/lime-desu/dootsfile/main/setup.sh -O -)"`  |

And that's all 👌

**The setup scripts will do:**
  - Get the all the files from the source (and will store it on $HOME/Git/Local/Dootsfile)
  - Symlink all the bin, config, icons, themes, based on xdg-specs directory (will create a copy of file first and backup it first if there's such directory and name it ending with the extension `.doots`)
  - Setup zsh and use it as default shell, after setting this up:
    - this will automatically install and use oh-my-zsh framework and download it's defined custom plugins
    - it will also download oh-my-tmux too and download tmux plugins
   - Setup firefox/librewolf search engine shortcut (not custom css, you can find the define search engine on `about:preferences#search`)
     - just a shortcut search engine for short example and overview typing `:gh` will search on github `r/` will search subreddit `:y` youtube and etc.
  - This will also import all my Gnome Keybindings (custom keybindings, and some modified pop-os-shell all of my custom modified shortcut)
  - Install phinger-cursors-icons as a mouse/cursor theme and adw-gtk3 for consistent gtk looking theme (will fetch it from github releases)
  - And lastly if you have flatpak install it will setup flatpak and add flathub repository and install some useful apps (flatseal, junction (application chooser, for my fzf dependencies))
  
 **Additional note:**
  - Before running the command make sure you're not on tmux first (some script will not work I found out when I'm inside tmux the $XDG_{CURRENT,SESSION}_DESKTOP became unset idk if this some tmux bug or not)
  - The Color Scheme I use is Catppuccin Mocha (all of this is already setup thanks to it's submodules)
  - On Neovim I'm using vanilla Lazy Vim (the colorscheme are the only modified (Catppuccin) and the lualine. Idk and still nub to customize neovim yet)
  
  #### Testing this out on a temporary installation:
  
  ```sh
  # create tempdir and set it as $HOME to do not dirty your home directory
  temp_dir=$(mktemp -d)
  export HOME=$temp_dir
  cd $temp_dir
  # then ran execute the setup script
  ```
