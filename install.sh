#!/bin/bash

#          .__          __        .__          .___      __    _____.__.__                 
#     ____ |__|__  ____/  |_ __ __|  |__     __| _/_____/  |__/ ____\__|  |   ____   ______
#    / ___\|  \  \/  /\   __\  |  \  |  \   / __ |/  _ \   __\   __\|  |  | _/ __ \ /  ___/
#   / /_/  >  |>    <  |  | |  |  /   Y  \ / /_/ (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ 
#   \___  /|__/__/\_ \ |__| |____/|___|  / \____ |\____/|__|  |__|  |__|____/\___  >____  >
#  /_____/          \/                 \/       \/                               \/     \/ 

clear
echo -e "gixtuh's hyprland dotfiles install wizard\n----------------------------------------------"
echo "update system? (y/n)"
read UPDATE
clear
echo -e "gixtuh's hyprland dotfiles install wizard\n----------------------------------------------"
echo "install dependencies? (cava fastfetch waybar hyprland hyprlock kitty swww python-pywal btop dolphin pamixer plasma-systemmonitor mpv) (y/n)"
read DEPENDENCIES
clear
echo -e "gixtuh's hyprland dotfiles install wizard\n----------------------------------------------"
echo "install yay dependencies? (google-chrome) (y/n)"
read YAY
clear
echo -e "gixtuh's hyprland dotfiles install wizard\n----------------------------------------------"
echo "copy dotfiles? (y/n)"
read COPY
clear
echo -e "gixtuh's hyprland dotfiles install wizard\n----------------------------------------------"
echo "replace bashrc? (y/n)"
read BASHRC
clear
echo -e "gixtuh's hyprland dotfiles install wizard\n----------------------------------------------"
echo "autostart waybar and swww? (y/n)"
read AUTOSTART
clear

case "$UPDATE" in
    y|yes|"")
        sudo pacman -Syu --noconfirm
    ;;
esac

clear

case "$DEPENDENCIES" in
    y|yes|"")
        sudo pacman -S --noconfirm cava fastfetch waybar hyprland hyprlock kitty swww python-pywal btop dolphin pamixer plasma-systemmonitor mpv
        case "$YAY" in
            y|yes|"")
                yay -S google-chrome
            ;;
        esac
    ;;
esac

clear

case "$COPY" in
    y|yes|"")
        echo "copying dotfiles in 5"; sleep 1; clear
        echo "copying dotfiles in 4"; sleep 1; clear
        echo "copying dotfiles in 3"; sleep 1; clear
        echo "copying dotfiles in 2"; sleep 1; clear
        echo "copying dotfiles in 1"; sleep 1; clear
        echo "copying dotfiles in 0"

        echo "copying hyprland dotfiles..."
        rm -rf ~/.config/hypr
        cp -r ./config/hypr ~/.config/hypr
        sleep 1
        echo "copied"

        echo "copying waybar dotfiles..."
        rm -rf ~/.config/waybar
        cp -r ./config/waybar ~/.config/waybar
        sudo chmod +x ~/.config/waybar/wifi_ssid.sh
        sleep 1
        echo "copied"

        echo "copying cava dotfiles..."
        rm -rf ~/.config/cava
        cp -r ./config/cava ~/.config/cava
        sleep 1
        echo "copied"

        echo "copying fastfetch dotfiles..."
        rm -rf ~/.config/fastfetch
        cp -r ./config/fastfetch ~/.config/fastfetch
        sleep 1
        echo "copied"

        echo "this process requires sudo!"
        echo "copying user files"
        sudo rm -rf /usr/local/bin/wallpaper.sh # for some reason we need sudo
        sudo rm -rf /usr/local/bin/pipes.sh # sudo
        sudo cp -r ./config/pipes.sh /usr/local/bin/pipes.sh # sudo
        sudo chmod +x /usr/local/bin/pipes.sh # sudo 
        sudo cp -r ./config/wallpaper.sh /usr/local/bin/wallpaper.sh # GOD IT'S ALL SUDO
        rm -rf ~/HyprlandRoot
        cp -r ./config/HyprlandRoot ~/HyprlandRoot
        sleep 1
        echo "copied"

        echo "copying pywal css colors..."
        mkdir ~/.cache/wal
        cp -r ./config/colors-waybar.css ~/.cache/wal/colors-waybar.css
        sleep 1
        echo "copied"

        echo "copying bash line editor..."
        sudo rm -rf ~/.local/share/blesh/ble-0.4.0-devel3
        sudo cp -r ./config/blesh ~/.local/share/blesh/ble-0.4.0-devel3
        echo "copied"

        echo "reloading hyprland..."
        hyprctl reload
        sleep 1

        case "$AUTOSTART" in
            y|yes|"")
                echo "starting swww..."
                swww-daemon &
                echo "starting waybar..."
                waybar &
            ;;
        esac

        case "$BASHRC" in
            y|yes|"")
                echo "copying bashrc..."
                rm -rf ~/.bashrc
                cp -r ./config/bashrc ~/.bashrc
                sleep 1
                echo "copied"
            ;;
        esac

        echo "finished, would you like to reboot? (y/n)"
        read RESTART
        case "$RESTART" in
            y|yes|"")
                sudo reboot
            ;;
        esac
    ;;
esac
