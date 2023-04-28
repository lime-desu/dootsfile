**Fedora Post Setup**
```sh
# speed up dnf
sudo sh -c "echo 'skip_if_unavailable=True' >> /etc/dnf/dnf.conf"
sudo sh -c "echo 'max_parallel_downloads=20' >> /etc/dnf/dnf.conf"
# enable rpm fusion and install multimedia codecs
sudo dnf install \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
# firefox openh264
sudo dnf config-manager --set-enabled fedora-cisco-openh264
sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264
# Afterwards you need open Firefox, go to menu → Add-ons → Plugins and enable OpenH264 plugin.
```

**Installing Rust and Some Apps**
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
git -C $DOOTS/config/zsh restore .
cargo install atuin cargo-update cargo-cache wipe topgrade
curl -sS https://starship.rs/install.sh | sh
```

**Installing Papirus Fonts (root)**
```
wget -qO- https://git.io/papirus-icon-theme-install | sh
```
**Papirus folder colors**
```
gsettings set  org.gnome.desktop.interface icon-theme 'Papirus-Dark'
cd $CLONES && git clone https://github.com/catppuccin/papirus-folders.git
cd papirus-folders && sudo cp -r src/* /usr/share/icons/Papirus
./papirus-folders -C cat-mocha-lavender --theme Papirus-Dark
```
**Desktop Icons**
```sh
#!/usr/bin/env bash
DESKTOP="share/applications"

for file in "$DOOTS/$DESKTOP/"*.desktop; do
    sed -i 's@/home/void@'"$HOME"'@g' "$file"
    cp -v "$file" "$HOME/.local/$DESKTOP/"
done
git -C "$DOOTS/$DESKTOP/" restore .
```
**Gnome**
```sh
# disable extension version check
gsettings set org.gnome.shell disable-extension-version-validation false
# get the current wallpaper set
gsettings get org.gnome.desktop.background picture-uri
```
