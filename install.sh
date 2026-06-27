#!/usr/bin/env bash

set -e

echo "==> Installing packages..."
sudo pacman -Syu --needed --noconfirm $(<packages.txt)

echo "==> Creating directories..."
mkdir -p "$HOME/.config"
mkdir -p "$HOME/Pictures/Wallpapers"

echo "==> Copying configuration files..."
cp -rf alacritty "$HOME/.config/"
cp -rf chadwm "$HOME/.config/"
cp -rf fastfetch "$HOME/.config/"
cp -rf picom "$HOME/.config/"
cp -rf rofi "$HOME/.config/"
cp -rf walls/* "$HOME/Pictures/Wallpapers/"

echo "==> Creating .xinitrc..."
cat > "$HOME/.xinitrc" <<EOF
exec ~/.config/chadwm/scripts/run.sh
EOF

echo "==> Compiling and installing ChadWM..."
cd "$HOME/.config/chadwm/chadwm"
sudo make clean install

echo
echo "========================================="
echo " Installation complete!"
echo "========================================="
echo
echo "Run:"
echo "    startx"
