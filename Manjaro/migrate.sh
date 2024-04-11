#!/bin/bash

# Destination directory where files and directories will be copied
destination_dir="$HOME/DotFiles/Manjaro/"

# List of sources to copy (each enclosed in double quotes)
sources=(
    "$HOME/.config/install.sh"
    "$HOME/.config/hypr"
    "$HOME/.config/rofi"
    "$HOME/.config/waybar"
    "$HOME/.config/zsh"
    "$HOME/.config/kitty"
    "$HOME/.config/manjaro"
    "$HOME/.config/btop"
)

# Check if destination directory exists, if not, create it
if [ ! -d "$destination_dir" ]; then
    mkdir -p "$destination_dir"
fi

# Loop through each source and copy it to the destination directory
for source in "${sources[@]}"; do
    # Check if source exists
    if [ ! -e "$source" ]; then
        echo "Source '$source' does not exist. Skipping."
    else
        # Copy source to destination directory
        cp -R "$source" "$destination_dir"
        echo "Copied '$source' to '$destination_dir'."
    fi
done

echo "All files and directories copied successfully to '$destination_dir'."
