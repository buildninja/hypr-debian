#!/bin/bash

# https://github.com/JaKooLit
# Add non-free & contrib to sources.list
dependencies=(
    meson
    wget
    build-essential
    ninja-build
    cmake-extras
    cmake
    gettext
    gettext-base
    fontconfig
    libfontconfig-dev
    libffi-dev
    libxml2-dev
    libdrm-dev
    libxkbcommon-x11-dev
    libxkbregistry-dev
    libxkbcommon-dev
    libpixman-1-dev
    libudev-dev
    libseat-dev
    seatd
    libxcb-dri3-dev
    libegl-dev
    libgles2
    libegl1-mesa-dev
    glslang-tools
    libinput-bin
    libinput-dev
    libxcb-composite0-dev
    libavutil-dev
    libavcodec-dev
    libavformat-dev
    libxcb-ewmh2
    libxcb-ewmh-dev
    libxcb-present-dev
    libxcb-icccm4-dev
    libxcb-render-util0-dev
    libxcb-res0-dev
    libxcb-xinput-dev
    xdg-desktop-portal-wlr
    libtomlplusplus3
    libtomlplusplus-dev
    libcairo2-dev
    libpango1.0-dev
    libzip-dev
    librsvg2-dev
)

# Install dependencies
for PKG1 in "${dependencies[@]}"; do
  sudo apt-get install -y  "$PKG1"
done

sudo apt build-dep wlroots

# Build hyprlang
git clone https://github.com/hyprwm/hyprlang
cd hyprlang
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprlang -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install ./build
cd ..

# Build hyprcursor
git clone https://github.com/hyprwm/hyprcursor
cd hyprcursor
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target all -j`nproc 2>/dev/null || getconf NPROCESSORS_CONF`
sudo cmake --install build
cd ..

git clone https://github.com/hyprwm/xdg-desktop-portal-hyprland
cd xdg-desktop-portal-hyprland
make all
sudo make install
cd ..

# Build hyprland
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all
sudo make install

