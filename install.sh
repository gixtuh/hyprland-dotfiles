#!/bin/bash

#          .__          __        .__          .___      __    _____.__.__                 
#     ____ |__|__  ____/  |_ __ __|  |__     __| _/_____/  |__/ ____\__|  |   ____   ______
#    / ___\|  \  \/  /\   __\  |  \  |  \   / __ |/  _ \   __\   __\|  |  | _/ __ \ /  ___/
#   / /_/  >  |>    <  |  | |  |  /   Y  \ / /_/ (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ 
#   \___  /|__/__/\_ \ |__| |____/|___|  / \____ |\____/|__|  |__|  |__|____/\___  >____  >
#  /_____/          \/                 \/       \/                               \/     \/ 




if (whiptail --yesno "Do you want to update the system?" --title "gixtuh's hyprland dotfile install wizard" 20 60) then
    UPDATE=y
else
    UPDATE=n
fi
if (whiptail --yesno "Do you want to install the dependencies? (cava fastfetch waybar hyprland hyprlock kitty swww python-pywal btop dolphin pamixer plasma-systemmonitor mpv python)" --title "gixtuh's hyprland dotfile install wizard" 20 60) then
    DEPENDENCIES=y
else
    DEPENDENCIES=n
fi
if (whiptail --yesno "Do you want to install the yay dependencies? (google-chrome)" --title "gixtuh's hyprland dotfile install wizard" 20 60) then
    YAY=y
else
    YAY=n
fi
if (whiptail --yesno "Do you want to replace the .bashrc file?" --title "gixtuh's hyprland dotfile install wizard" 20 60) then
    BASHRC=y
else
    BASHRC=n
fi
if (whiptail --yesno "Do you want to restart waybar after installation?" --title "gixtuh's hyprland dotfile install wizard" 20 60) then
    AUTOSTART=y
else
    AUTOSTART=n
fi
if (whiptail --yesno "Are you sure you want to install gixtuh's Hyprland dotfiles? It will overwrite your current Hyprland, fastfetch, cava and waybar configs!" --title "gixtuh's hyprland dotfile install wizard" 20 60) then
    COPY=y
else
    COPY=n
fi

clear

case "$COPY" in
    y|yes|"")
        echo "copying dotfiles in 5"; sleep 1; clear
        echo "copying dotfiles in 4"; sleep 1; clear
        echo "copying dotfiles in 3"; sleep 1; clear
        echo "copying dotfiles in 2"; sleep 1; clear
        echo "copying dotfiles in 1"; sleep 1; clear
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
                sudo pacman -S --noconfirm cava fastfetch waybar hyprland hyprlock kitty swww python-pywal btop dolphin pamixer plasma-systemmonitor mpv python > /dev/null
                case "$YAY" in
                    y|yes|"")
                        clear
                        echo "stage 3: installing yay dependencies..."
                        yay -S google-chrome --noconfirm > /dev/null
                    ;;
                esac
            ;;
        esac

        clear

        echo "stage 4: copying dotfiles..."
        rm -rf ~/.config/hypr
        cp -r ./config/hypr ~/.config/hypr
        sleep 1

        rm -rf ~/.config/waybar
        cp -r ./config/waybar ~/.config/waybar
        sudo chmod +x ~/.config/waybar/wifi_ssid.sh
        sleep 1

        rm -rf ~/.config/cava
        cp -r ./config/cava ~/.config/cava
        sleep 1

        rm -rf ~/.config/fastfetch
        cp -r ./config/fastfetch ~/.config/fastfetch
        sleep 1

        sudo rm -rf /usr/local/bin/wallpaper.sh # for some reason we need sudo
        sudo rm -rf /usr/local/bin/pipes.sh # sudo
        sudo cp -r ./config/pipes.sh /usr/local/bin/pipes.sh # sudo
        sudo chmod +x /usr/local/bin/pipes.sh # sudo 
        sudo cp -r ./config/wallpaper.sh /usr/local/bin/wallpaper.sh # GOD IT'S ALL SUDO
        rm -rf ~/HyprlandRoot
        sudo rm -rf /usr/local/bin/HyprlandRoot
        sudo cp -r ./config/HyprlandRoot /usr/local/bin/HyprlandRoot
        sudo cp -r ./config/wal_cava /usr/local/bin/wal_cava
        sleep 1

        mkdir ~/.cache/wal
        cp -r ./config/colors-waybar.css ~/.cache/wal/colors-waybar.css
        sleep 1

        sudo rm -rf ~/.local/share/blesh/ble-0.4.0-devel3
        sudo cp -r ./config/blesh ~/.local/share/blesh/ble-0.4.0-devel3
        sleep 1
        
        hyprctl reload
        echo "waiting 3 seconds for hyprland to reload..."
        sleep 3

        case "$AUTOSTART" in
            y|yes|"")
                clear
                echo "killing waybar..."
                pkill waybar
                echo "starting waybar..."
                waybar &
                sleep 2
            ;;
        esac

        clear

        case "$BASHRC" in
            y|yes|"")
                echo "stage 5: copying bashrc files..."
                rm -rf ~/.bashrc
                cp -r ./config/bashrc ~/.bashrc
                sleep 1
            ;;
        esac

        if (whiptail --yesno "Do you want to launch swww-daemon? (wallpaper engine daemon required by the gixtuh's dotfiles)" 20 60) then
            swww-daemon &
        fi
        if (whiptail --yesno "Do you want to reboot?" 20 60) then
            sudo reboot
        fi
        clear
        echo "Finished!"
    ;;
esac
