#!/usr/bin/env bash

set -e

echo "==> Installing packages..."
sudo pacman -Syu --needed --noconfirm $(<packages.txt)

echo "==> Installing yay..."
if ! command -v yay >/dev/null 2>&1; then
    git clone https://aur.archlinux.org/yay.git --depth=1
    cd yay
    yes | makepkg -si
    cd ..
    rm -rf yay
else
    echo "yay is already installed."
fi

echo "==> Installing Waterfox..."
yay -S --needed --noconfirm waterfox-bin

echo "==> Installing betterlockscreen..."
yay -S --needed --noconfirm betterlockscreen

echo "==> Installing Vim build dependencies..."
sudo pacman -S --needed --noconfirm \
    git gcc make ncurses \
    libx11 libxt libxpm

echo "==> Building Vim with clipboard support..."
if ! command -v vim >/dev/null 2>&1; then
    git clone https://github.com/vim/vim --depth=1
    cd vim

    ./configure \
        --with-features=huge \
        --enable-multibyte \
        --enable-terminal \
        --enable-clipboard \
        --without-xim \
        --disable-gui \
        --prefix=/usr/local

    make -j"$(nproc)"
    sudo make install

    cd ..
    rm -rf vim
else
    echo "Vim is already installed."
fi

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

echo "==> Enabling touchpad tap-to-click..."

sudo mkdir -p /etc/X11/xorg.conf.d

sudo tee /etc/X11/xorg.conf.d/30-touchpad.conf > /dev/null <<'EOF'
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "NaturalScrolling" "false"
    Option "ClickMethod" "clickfinger"
EndSection
EOF

echo "==> Configuring betterlockscreen..."
betterlockscreen -u "$HOME/Pictures/Wallpapers/lockscreen.jpg" --fx blur

echo "==> Copying Vim configuration..."
cp vimconfig/.vimrc "$HOME/.vimrc"

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
