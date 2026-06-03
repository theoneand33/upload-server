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

echo "Installing system dependencies..."
sudo apt update && sudo apt install -y libfuse2t64 fish libnss3
if ! grep -q "Automatically launch fish shell" "$HOME/.bashrc" 2>/dev/null; then
    echo -e "\n# Automatically launch fish shell\nif [ -t 1 ]; then\n    exec fish\nfi" >> "$HOME/.bashrc"
fi

echo "Downloading Arduino IDE v${VERSION}..."
curl -L "$DOWNLOAD_URL" --output "$APPIMAGE_PATH"
chmod +x "$APPIMAGE_PATH"

echo "Downloading official icon..."
curl -L "https://raw.githubusercontent.com/arduino/arduino-ide/main/electron-app/resources/icons/512x512.png" \
  --output "$ICON_DIR/arduino.png"

echo "Creating desktop shortcut..."
sudo tee /usr/share/applications/arduino.desktop > /dev/null <<EOF
[Desktop Entry]
Type=Application
Name=Arduino IDE
Exec=$INSTALL_DIR/arduino-ide.AppImage
Icon=$ICON_DIR/arduino.png
Terminal=false
Categories=Development;Engineering;GuidedTour;
Comment=Arduino IDE 2.x Application
EOF

echo "Update desktop database..."
sudo update-desktop-database "/usr/share/applications" || true

echo "Installation complete! You can now find Arduino IDE in your application menu."
