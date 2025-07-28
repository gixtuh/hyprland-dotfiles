
cd /usr/local/bin/HyprlandRoot/wallpapers
wallpaper=$(for wall in *.jpg; do echo -en "$wall\0icon\x1f$wall\n"; done | rofi -dmenu -p "")
case $wallpaper in
 "")
  echo "none selected; skipping"
 ;;
 *)
   swww img /usr/local/bin/HyprlandRoot/wallpapers/$wallpaper \
  --transition-type any \
  --transition-duration 1 
  wal -i /usr/local/bin/HyprlandRoot/wallpapers/$wallpaper -nst
  wal_cava -c ~/.config/cava/config -G 3 -i ~/.cache/wal/colors.json
  cat ~/.cache/wal/colors.css 
  pkill waybar && waybar &
 ;;
esac

# 
