#!/bin/bash

echo "Installing dotnet"
apt-get update
apt-get install wget -y
wget "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
apt-get update;
apt-get install -y apt-transport-https && apt-get update;
apt-get install -y dotnet-sdk-6.0;

echo "Installing Git, Redis and Tmux..."
apt-get install git tmux redis-server -y

echo "Installing music prerequisites..."
apt-get install libopus0 opus-tools libopus-dev libsodium-dev python3 ffmpeg -y
wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp
chmod a+rx /usr/local/bin/yt-dlp

echo "NadekoBot Prerequisites Installation completed..."
