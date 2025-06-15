wallpaper=$(echo -e "default/wallpaper.jpg\ndefault/red.jpg\ndefault/purple.jpg\ndefault/green.jpg" | rofi -dmenu -p "Select wallpaper")
case $wallpaper in
 "")
  echo "none selected; skipping"
 ;;
 *)
   swww img /usr/local/bin/HyprlandRoot/wallpapers/$wallpaper \
  --transition-type grow \
  --transition-duration 1 \
  --transition-pos "$(awk 'BEGIN { srand(); printf "%.2f,%.2f\n", rand(), rand() }')"
  wal -i /usr/local/bin/HyprlandRoot/wallpapers/$wallpaper -nst
  cat ~/.cache/wal/colors.css 
  pkill waybar && waybar &
 ;;
esac

# 
