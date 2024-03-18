#!/bin/bash

# https://github.com/JaKooLit
# Add non-free & contrib to sources.list
dependencies=(
    build-essential
    cmake
    cmake-extras
    curl
    gettext
    gir1.2-graphene-1.0
    git
    glslang-tools
    gobject-introspection
    golang
    hwdata
    jq
    libavcodec-dev
    libavformat-dev
    libavutil-dev
    libcairo2-dev
    libdeflate-dev
    libdisplay-info-dev
    libdrm-dev
    libegl1-mesa-dev
    libgbm-dev
    libgdk-pixbuf-2.0-dev
    libgdk-pixbuf2.0-bin
    libgirepository1.0-dev
    libgl1-mesa-dev
    libgraphene-1.0-0
    libgraphene-1.0-dev
    libgtk-3-dev
    libgulkan-0.15-0
    libgulkan-dev
    libinih-dev
    libinput-dev
    libjbig-dev
    libjpeg-dev
    libjpeg62-turbo-dev
    liblerc-dev
    libliftoff-dev
    liblzma-dev
    libnotify-bin
    libpam0g-dev
    libpango1.0-dev
    libpipewire-0.3-dev
    libseat-dev
    libswresample-dev
    libsystemd-dev
    libtiff-dev
    libtiffxx6
    libudev-dev
    libvkfft-dev
    libvulkan-dev
    libvulkan-volk-dev
    libwayland-dev
    libwebp-dev
    libxcb-composite0-dev
    libxcb-dri3-dev
    libxcb-ewmh-dev
    libxcb-icccm4-dev
    libxcb-present-dev
    libxcb-render-util0-dev
    libxcb-res0-dev
    libxcb-xinput-dev
    libxcb-xkb-dev
    libxkbcommon-dev
    libxkbcommon-x11-dev
    libxkbregistry-dev
    libxml2-dev
    libxxhash-dev
    meson
    ninja-build
    openssl
    psmisc
    python3-mako
    python3-markdown
    python3-markupsafe
    python3-yaml
    qt6-base-dev
    scdoc
    seatd
    spirv-tools
    vulkan-validationlayers
    vulkan-validationlayers-dev
    wayland-protocols
    xdg-desktop-portal
    xwayland
    firmware-misc-nonfree
    linux-headers-$(uname -r)
    libva-wayland2
    kitty
    polkit-kde-agent-1
)

# Add non-free and contrib to sources.list
sudo sed -i '/http:/ s/$/ non-free contrib/' /etc/apt/sources.list

sudo apt update && sudo apt upgrade

# Install dependencies
for PKG1 in "${dependencies[@]}"; do
  sudo apt-get install -y  "$PKG1"
done

sudo apt build-dep wlroots
export PATH=$PATH:/usr/local/go/bin

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

# Build hyprland
git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all
sudo make install
cd ..

# Build xdg-desktop-portal-hyprland
git clone --recursive https://github.com/hyprwm/xdg-desktop-portal-hyprland
cd xdg-desktop-portal-hyprland/
make all
sudo make install


