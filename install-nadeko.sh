#!/bin/sh

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

git clone -b v5 --recursive --depth 1 https://gitlab.com/Kwoth/nadekobot

root=$(pwd)

cd nadekobot

export DOTNET_CLI_TELEMETRY_OPTOUT=1
dotnet restore -f --no-cache
dotnet build src/NadekoBot/NadekoBot.csproj -c Release -o output/

cd "$root"

mv -f nadekobot_old/output/creds.yml nadekobot/output/creds.yml 1>/dev/null 2>&1
mv -f nadekobot_old/output/credentials.json nadekobot/output/credentials.json 1>/dev/null 2>&1

rm -rf nadekobot/output/data/strings_new 1>/dev/null 2>&1
mv -fT nadekobot/output/data/strings nadekobot/output/data/strings_new 1>/dev/null 2>&1

rm -rf nadekobot_old/output/data/strings_old 1>/dev/null 2>&1
rm -rf nadekobot_old/output/data/strings_new 1>/dev/null 2>&1


mv -f nadekobot/output/data/aliases.yml nadekobot/output/data/aliases_new.yml 1>/dev/null 2>&1


mv -f nadekobot_old/output/data/NadekoBot.db nadekobot/output/data/NadekoBot.db 1>/dev/null 2>&1


cp -RT nadekobot_old/output/data/ nadekobot/output/data 1>/dev/null 2>&1


mv -f nadekobot/output/data/aliases.yml nadekobot/output/data/aliases_old.yml 1>/dev/null 2>&1

mv -f nadekobot/output/data/aliases_new.yml nadekobot/output/data/aliases.yml 1>/dev/null 2>&1


mv -f nadekobot/output/data/strings nadekobot/output/data/strings_old 1>/dev/null 2>&1

mv -f nadekobot/output/data/strings_new nadekobot/output/data/strings 1>/dev/null 2>&1

rm "$root/rebuild.sh"
exit 0
