ROFI=$(echo -e "Lock\nShutdown\nRestart\nLog out" | rofi -dmenu)
sleep 0.4
case "$ROFI" in
  "Lock")
    hyprlock 
  ;;
  "Shutdown")
    shutdown now
  ;;
  "Restart")
    reboot
  ;;
  "Log out")
    killall --user $USER
  ;;
esac