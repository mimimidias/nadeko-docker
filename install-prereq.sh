#!/bin/bash

echo "Installing dotnet"
wget "https://packages.microsoft.com/config/ubuntu/$VER/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

apt-get update;
apt-get install -y apt-transport-https && apt-get update;
apt-get install -y apt-transport-https && apt-get update;
apt-get install -y dotnet-sdk-8.0;

echo "Installing Git, Redis and Tmux..."
apt-get install git tmux redis-server -y

echo "Installing music prerequisites..."
apt-get install libopus0 opus-tools libopus-dev libsodium-dev -y
apt install python
echo ""
apt-get install ffmpeg
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod a+rx /usr/local/bin/youtube-dl

echo "NadekoBot Prerequisites Installation completed..."
