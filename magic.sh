#!/bin/bash
set -e

VERSION="2.3.9"
DOWNLOAD_URL="https://downloads.arduino.cc/arduino-ide/arduino-ide_${VERSION}_Linux_64bit.AppImage"
INSTALL_DIR="$HOME/.local/bin"
APPIMAGE_PATH="$INSTALL_DIR/arduino-ide.AppImage"
ICON_DIR="$HOME/.local/share/icons/hicolor/512x512/apps"

echo "Creating directories..."
mkdir -p "$INSTALL_DIR"
mkdir -p "$ICON_DIR"
sudo mkdir -p "/usr/share/applications"
mkdir -p $INSTALL_DIR

echo "Installing system dependencies..."
sudo apt update && sudo apt install -y libfuse2t64 fish libnss3
sudo echo -e "\n# Automatically launch fish shell\nif [ -t 1 ]; then\n    exec fish\nfi" >> ~/.bashrc

echo "Downloading Arduino IDE v${VERSION}..."
curl -L "$DOWNLOAD_URL" --output "$APPIMAGE_PATH"
chmod +x "$APPIMAGE_PATH"

echo "Downloading official icon..."
curl -L "https://github.com/arduino/arduino-ide/blob/main/electron-app/resources/icons/512x512.png?raw=true" --output "$ICON_DIR/arduino.png"

echo "Creating desktop shortcut..."
sudo tee /usr/share/applications/arduino.desktop > /dev/null <<EOF
[Desktop Entry]
Type=Application
Name=Arduino IDE
Exec=~/home/$USER/.local/bin/arduino-ide.AppImage
Icon=arduino
Terminal=false
Categories=Development;Engineering;GuidedTour;
Comment=Arduino IDE 2.x Application
EOF

echo "Update desktop database..."
sudo update-desktop-database "/usr/share/applications" || true

echo "Installation complete! You can now find Arduino IDE in your application menu."
