#!/usr/bin/env bash
#
# Rice installer for Arch Linux
# Run this from the root of your dotfiles directory (the one containing
# foot/, fuzzel/, helix/, mako/, mango/, rofi/, waybar/, starship.toml, linux.png)

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$HOME/.config"
PICTURES_DIR="$HOME/Pictures"

echo "==> Dotfiles source: $DOTFILES_DIR"

mkdir -p "$CONFIG_DIR" "$PICTURES_DIR"

# ---------- Install yay (AUR helper) if missing ----------
if ! command -v yay &>/dev/null; then
    echo "==> yay not found, installing..."
    sudo pacman -S --needed --noconfirm base-devel git
    tmpdir=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay"
    (cd "$tmpdir/yay" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
else
    echo "==> yay already installed, skipping"
fi

# ---------- Install AUR packages ----------
echo "==> Installing zen-browser-bin and localsend-bin mangowm and foot and fuzzel and helix and swaybg and mako and rofi and starship and waybar and libnotify and jetbrains mono nerd and noto fonts cjk and nautilus and grim and slurp from AUR"
yay -S --needed --noconfirm zen-browser-bin localsend-bin mangowm foot fuzzel helix swaybg mako rofi starship waybar-git libnotify ttf-jetbrains-mono-nerd noto-fonts-cjk nautilus grim slurp

# ---------- Copy configs ----------
echo "==> Copying foot"
mkdir -p "$CONFIG_DIR/foot"
cp -f "$DOTFILES_DIR/foot/foot.ini" "$CONFIG_DIR/foot/foot.ini"

echo "==> Copying fuzzel"
mkdir -p "$CONFIG_DIR/fuzzel"
cp -f "$DOTFILES_DIR/fuzzel/fuzzel.ini" "$CONFIG_DIR/fuzzel/fuzzel.ini"

echo "==> Copying helix"
mkdir -p "$CONFIG_DIR/helix/themes"
cp -f "$DOTFILES_DIR/helix/config.toml" "$CONFIG_DIR/helix/config.toml"
cp -f "$DOTFILES_DIR/helix/themes/white.toml" "$CONFIG_DIR/helix/themes/white.toml"

echo "==> Copying wallpaper"
cp -f "$DOTFILES_DIR/linux.png" "$PICTURES_DIR/linux.png"

echo "==> Copying mako"
mkdir -p "$CONFIG_DIR/mako"
cp -f "$DOTFILES_DIR/mako/config" "$CONFIG_DIR/mako/config"

echo "==> Copying mango"
mkdir -p "$CONFIG_DIR/mango"
cp -f "$DOTFILES_DIR/mango/config.conf" "$CONFIG_DIR/mango/config.conf"
cp -f "$DOTFILES_DIR/mango/powermenu" "$CONFIG_DIR/mango/powermenu"
cp -f "$DOTFILES_DIR/mango/slurpshot.sh" "$CONFIG_DIR/mango/slurpshot.sh"
chmod +x "$CONFIG_DIR/mango/powermenu" "$CONFIG_DIR/mango/slurpshot.sh"

echo "==> Copying rofi"
mkdir -p "$CONFIG_DIR/rofi"
cp -f "$DOTFILES_DIR/rofi/config.rasi" "$CONFIG_DIR/rofi/config.rasi"
cp -f "$DOTFILES_DIR/rofi/theme.rasi" "$CONFIG_DIR/rofi/theme.rasi"

echo "==> Copying starship"
cp -f "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"

echo "==> Copying waybar"
mkdir -p "$CONFIG_DIR/waybar/scripts"
cp -f "$DOTFILES_DIR/waybar/config" "$CONFIG_DIR/waybar/config"
cp -f "$DOTFILES_DIR/waybar/style.css" "$CONFIG_DIR/waybar/style.css"
cp -f "$DOTFILES_DIR/waybar/scripts/memory_usage.sh" "$CONFIG_DIR/waybar/scripts/memory_usage.sh"
cp -f "$DOTFILES_DIR/waybar/scripts/waybarTemp.sh" "$CONFIG_DIR/waybar/scripts/waybarTemp.sh"
chmod +x "$CONFIG_DIR/waybar/scripts/memory_usage.sh" "$CONFIG_DIR/waybar/scripts/waybarTemp.sh"

echo "==> Done! Rice installed."
