#!/bin/sh

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
