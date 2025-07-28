#!/bin/bash

#          .__          __        .__          .___      __    _____.__.__                 
#     ____ |__|__  ____/  |_ __ __|  |__     __| _/_____/  |__/ ____\__|  |   ____   ______
#    / ___\|  \  \/  /\   __\  |  \  |  \   / __ |/  _ \   __\   __\|  |  | _/ __ \ /  ___/
#   / /_/  >  |>    <  |  | |  |  /   Y  \ / /_/ (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ 
#   \___  /|__/__/\_ \ |__| |____/|___|  / \____ |\____/|__|  |__|  |__|____/\___  >____  >
#  /_____/          \/                 \/       \/                               \/     \/ 


UPDATE=n
DEPENDENCIES=n
YAY=n
BASHRC=n
AUTOSTART=n
SKIP=n
INSTANT=n
SWWW=n
REBOOT=n
ch1=$(whiptail --checklist "gixtuh's hyprland dotfile installation wizard" 20 60 9 \
    "Update system" "" OFF \
    "Install dependencies" "" OFF \
    "Install yay dependencies" "" OFF \
    "Replace .bashrc" "" OFF \
    "Restart waybar after installation" "" OFF \
    "Restart swww after installation" "" OFF \
    "Reboot after installation" "" OFF \
    "Skip timer" "" OFF \
    "Quick copy" "" OFF \
3>&1 1>&2 2>&3)
eval "choices=($ch1)"
for choice in "${choices[@]}"; do

    [[ $choice == "Update system" ]] && UPDATE=y
    [[ $choice == "Install dependencies" ]] && DEPENDENCIES=y
    [[ $choice == "Install yay dependencies" ]] && YAY=y
    [[ $choice == "Replace .bashrc" ]] && BASHRC=y
    [[ $choice == "Restart waybar after installation" ]] && AUTOSTART=y
    [[ $choice == "Skip timer" ]] && SKIP=y
    [[ $choice == "Quick copy" ]] && INSTANT=y
    [[ $choice == "Restart swww after installation" ]] && SWWW=y
    [[ $choice == "Reboot after installation" ]] && REBOOT=y
    
done


if (whiptail --yesno "Are you sure you want to install gixtuh's Hyprland dotfiles? It will overwrite your current Hyprland, fastfetch, cava and waybar configs!" --title "gixtuh's hyprland dotfile install wizard" 20 60) then
    COPY=y
else
    COPY=n
fi

clear

case "$COPY" in
    y|yes|"")

        if [ $SKIP = n ]; then
            echo "copying dotfiles in 5"; sleep 1; clear
            echo "copying dotfiles in 4"; sleep 1; clear
            echo "copying dotfiles in 3"; sleep 1; clear
            echo "copying dotfiles in 2"; sleep 1; clear
            echo "copying dotfiles in 1"; sleep 1; clear
        fi
        clear
        echo "stage 1: updating system..."
        case "$UPDATE" in
            y|yes|"")
                sudo pacman -Syu --noconfirm > /dev/null
            ;;
        esac

        clear

        case "$DEPENDENCIES" in
            y|yes|"")
                echo "stage 2: installing pacman dependencies..."
                if ( ! sudo pacman -S --noconfirm cava fastfetch waybar hyprland hyprlock kitty swww rofi python-pywal btop dolphin pamixer plasma-systemmonitor mpv python swaync libnotify code > /dev/null); then
                    whiptail --msgbox "Failure installing dependencies. Make sure you're on Arch Linux!" 20 60
                    exit
                fi
                case "$YAY" in
                    y|yes|"")
                        clear
                        echo "stage 3: installing yay dependencies..."
                        if ( ! yay -S google-chrome wlogout --noconfirm > /dev/null ); then
                            whiptail --msgbox "Failure installing yay dependencies. Make sure you have yay installed and it is not corrupted!" 20 60
                            exit
                        fi
                    ;;
                esac
            ;;
        esac

        clear

        echo "stage 4: copying dotfiles..."
        rm -rf ~/.config/hypr
        cp -r ./config/hypr ~/.config/hypr
        if [ $INSTANT = n ]; then sleep 1; fi

        rm -rf ~/.config/waybar
        cp -r ./config/waybar ~/.config/waybar
        sudo chmod +x ~/.config/waybar/wifi_ssid.sh
        if [ $INSTANT = n ]; then sleep 1; fi

        rm -rf ~/.config/cava
        cp -r ./config/cava ~/.config/cava
        if [ $INSTANT = n ]; then sleep 1; fi

        rm -rf ~/.config/fastfetch
        cp -r ./config/fastfetch ~/.config/fastfetch
        if [ $INSTANT = n ]; then sleep 1; fi

        sudo rm -rf /etc/wlogout
        sudo cp -r ./config/wlogout /etc/wlogout
        if [ $INSTANT = n ]; then sleep 1; fi

        sudo rm -rf /usr/local/bin/wallpaper.sh # for some reason we need sudo
        sudo rm -rf /usr/local/bin/pipes.sh # sudo
        sudo cp -r ./config/pipes.sh /usr/local/bin/pipes.sh # sudo
        sudo chmod +x /usr/local/bin/pipes.sh # sudo 
        sudo cp -r ./config/wallpaper.sh /usr/local/bin/wallpaper.sh # GOD IT'S ALL SUDO
        sudo chmod +x /usr/local/bin/wallpaper.sh
        rm -rf ~/HyprlandRoot
        sudo rm -rf /usr/local/bin/HyprlandRoot
        sudo cp -r ./config/HyprlandRoot /usr/local/bin/HyprlandRoot
        sudo cp -r ./config/wal_cava /usr/local/bin/wal_cava
        if [ $INSTANT = n ]; then sleep 1; fi

        mkdir ~/.cache/wal
        mkdir ~/.local/share/blesh/ble-0.4.0-devel3
        cp -r ./config/colors-waybar.css ~/.cache/wal/colors-waybar.css
        ln -sf ~/.cache/wal/colors-waybar.css ~/.config/waybar/colors-wal.css

        if [ $INSTANT = n ]; then sleep 1; fi

        sudo rm -rf ~/.local/share/blesh/ble-0.4.0-devel3
	sudo mkdir ~/.local/share/blesh
        sudo cp -r ./config/blesh ~/.local/share/blesh/ble-0.4.0-devel3
        if [ $INSTANT = n ]; then sleep 1; fi
        
        hyprctl reload
        echo "waiting 3 seconds for hyprland to reload..."
        if [ $INSTANT = n ]; then sleep 3; fi

        case "$AUTOSTART" in
            y|yes|"")
                clear
                echo "killing waybar..."
                pkill waybar
                echo "starting waybar..."
                waybar &
                if [ $INSTANT = n ]; then sleep 2; fi
            ;;
        esac

        clear

        case "$BASHRC" in
            y|yes|"")
                echo "stage 5: copying bashrc files..."
                rm -rf ~/.bashrc
                cp -r ./config/bashrc ~/.bashrc
                if [ $INSTANT = n ]; then sleep 1; fi
            ;;
        esac

        if [ $SWWW = y ]; then
            pkill swww-daemon
            swww-daemon &
            swww img /usr/local/bin/HyprlandRoot/wallpapers/default/wallpaper.jpg
        fi
        if [ $REBOOT = y ]; then
            sudo reboot
        fi
        clear
        echo "Finished!"
    ;;
esac
