wallpaper=$(echo -e "default/wallpaper.jpg\ndefault/red.jpg\ndefault/purple.jpg\ndefault/green.jpg\ndefault/black.jpg" | rofi -dmenu -p "Select wallpaper")
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
