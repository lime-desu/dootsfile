#!/usr/bin/env bash

WALLPAPER_DIR=${HOME}/Pictures/Wallpapers/Random_Wallpapers
RANDOM_PICTURE=$(find "$WALLPAPER_DIR" | shuf -n 1 | xargs basename)
CURRENT_DESKTOP="$(echo "$XDG_CURRENT_DESKTOP" | awk '{for (i=1;i<=NF;i++) { $i=toupper(substr($i,1,1)) tolower(substr($i,2)) }}1')"

case "$CURRENT_DESKTOP" in
Gnome)
	gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER_DIR/$RANDOM_PICTURE"
	gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER_DIR/$RANDOM_PICTURE"
	;;
Xfce)
	backdrop=$(xfconf-query --channel xfce4-desktop --property /backdrop --list | grep -E -e "screen.*/monitor.*image-path$" -e "screen.*/monitor.*/last-image$")
	for i in ${backdrop}; do
		xfconf-query --channel xfce4-desktop --property "$i" --create --type string --set "$WALLPAPER_DIR/$RANDOM_PICTURE"
		xfconf-query --channel xfce4-desktop --property "$i" --set "$WALLPAPER_DIR/$RANDOM_PICTURE"
	done
	;;
Kde)
	qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
      var allDesktops = desktops();
      print (allDesktops);
      for (i=0;i<allDesktops.length;i++) {
        d = allDesktops[i];
        d.wallpaperPlugin = \"org.kde.image\";
        d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");
        d.writeConfig(\"Image\", \"file://${WALLPAPER_DIR}/${RANDOM_PICTURE}\");
    }"
	;;
Sway)
	MODES=(
		[bg - center]=center
		[bg - fill]=fill
		[bg - max]=fit
		[bg - scale]=stretch
		[bg - tile]=tile
	)
	# default to fill if there's no bgtypes
	BGTYPE=${BGTYPE:-fill}
	MODE=${MODES[$BGTYPE]}
	swaymsg output "*" bg "$WALLPAPER_DIR/$RANDOM_PICTURE" "$MODE"
	;;
I3)
	if command -v feh >/dev/null; then
		feh --bg-fill "$WALLPAPER_DIR/$RANDOM_PICTURE" && exit
	elif command -v nitrogen >/dev/null; then
		nitrogen --set-auto "$WALLPAPER_DIR/$RANDOM_PICTURE" && exit
	fi
	;;
*)
	notify-send "Error: $(basename "$0")" "This script does not support $CURRENT_DESKTOP."
	exit 1
	;;
esac

if [[ "$CURRENT_DESKTOP" =~ ^(Gnome|Xfce|Kde|Sway|I3)$ ]]; then
	notify-send 'Wallpaper changed:' "$RANDOM_PICTURE"
fi
