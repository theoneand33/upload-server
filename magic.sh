curl https://downloads.arduino.cc/arduino-ide/arduino-ide_2.3.9_Linux_64bit.AppImage --output ~/arduino.appimage
chmod +x ~/arduino.appimage
sudo apt install -y libfuse2t64
cat <<EOF > "$HOME/.local/share/applications/arduino.desktop"
[Desktop Entry]
Type=Application
Name=Arduino IDE
Exec=~/arduino.appimage
Terminal=false
Categories=Utility;
EOF
