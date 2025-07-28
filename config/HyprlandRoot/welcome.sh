#!/bin/bash

LOCK_FILE="/usr/local/bin/permlock.lock"

if [ ! -f "$LOCK_FILE" ]; then
    kitty whiptail --msgbox "This is your first time using gixtuhs hyprland dotfiles!\nThank you for using my dotfiles." 20 60 &
    sudo touch "$LOCK_FILE"
fi
