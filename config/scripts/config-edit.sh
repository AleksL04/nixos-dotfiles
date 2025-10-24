#!/usr/bin/env bash

# Create an array of your configuration files
files=(
    "$HOME/.config/hypr/hyprland.conf"
    "$HOME/.config/hypr/hyprpaper.conf"
    "$HOME/.config/hypr/hyprlock.conf"
    "$HOME/.config/hypr/conf/animations.conf"
    "$HOME/.config/hypr/conf/autostart.conf"
    "$HOME/.config/hypr/conf/binds.conf"
    "$HOME/.config/hypr/conf/cursor.conf"
    "$HOME/.config/hypr/conf/decoration.conf"
    "$HOME/.config/hypr/conf/environments.conf"
    "$HOME/.config/hypr/conf/general.conf"
    "$HOME/.config/hypr/conf/gestures.conf"
    "$HOME/.config/hypr/conf/input.conf"
    "$HOME/.config/hypr/conf/layouts.conf"
    "$HOME/.config/hypr/conf/misc.conf"
    "$HOME/.config/hypr/conf/monitor.conf"
    "$HOME/.config/hypr/conf/windowrules.conf"
)

# Use wofi to create a menu and get the selected file
selected=$(printf "%s\n" "${files[@]}" | wofi --dmenu -p "Select a config file to edit")

# If a file was selected, open it in nvim
if [[ -n "$selected" ]]; then
    kitty nvim "$selected"
fi
