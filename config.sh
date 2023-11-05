#!/bin/bash

dependencies=(
    neofetch
    htop
    cava
    flatpak
    pipewire
    dunst
    waybar
    tmux
    unzip
    swaybg
    tldr
    pavucontrol
)

for PKG1 in "${dependencies[@]}"; do
  sudo apt-get install -y  "$PKG1"
done

tldr -u
