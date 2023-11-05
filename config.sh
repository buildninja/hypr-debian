#!/bin/bash

dependencies=(
    neofetch
    htop
    cava
    flatpak
    pipewire
    dunst
    wofi
    waybar
    tmux
    unzip
    swaybg
    tldr
    alacritty
    pavucontrol
    firefox-esr
    vlc
    qbittorrent
    keepassxc
)

for PKG1 in "${dependencies[@]}"; do
  sudo apt-get install -y  "$PKG1"
done

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.usebottles.bottles
