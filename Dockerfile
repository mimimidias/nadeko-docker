FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update
RUN apt-get install apt-transport-https git tmux redis-server libopus0 opus-tools libopus-dev libsodium-dev python3 ffmpeg -y
RUN wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp


RUN git clone -b v5 --recursive --depth 1 https://gitlab.com/Kwoth/nadekobot
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
RUN cd nadekobot && dotnet restore -f --no-cache && dotnet build src/NadekoBot/NadekoBot.csproj -c Release -o output/

RUN mv -f nadekobot_old/output/creds.yml nadekobot/output/creds.yml 1>/dev/null 2>&1 && \
    mv -f nadekobot_old/output/credentials.json nadekobot/output/credentials.json 1>/dev/null 2>&1 && \
    rm -rf nadekobot/output/data/strings_new 1>/dev/null 2>&1 && \
    mv -fT nadekobot/output/data/strings nadekobot/output/data/strings_new 1>/dev/null 2>&1 && \
    rm -rf nadekobot_old/output/data/strings_old 1>/dev/null 2>&1 && \
    rm -rf nadekobot_old/output/data/strings_new 1>/dev/null 2>&1 && \
    mv -f nadekobot/output/data/aliases.yml nadekobot/output/data/aliases_new.yml 1>/dev/null 2>&1 && \
    mv -f nadekobot_old/output/data/NadekoBot.db nadekobot/output/data/NadekoBot.db 1>/dev/null 2>&1 && \
    cp -RT nadekobot_old/output/data/ nadekobot/output/data 1>/dev/null 2>&1 && \
    mv -f nadekobot/output/data/aliases.yml nadekobot/output/data/aliases_old.yml 1>/dev/null 2>&1 && \
    mv -f nadekobot/output/data/aliases_new.yml nadekobot/output/data/aliases.yml 1>/dev/null 2>&1 && \
    mv -f nadekobot/output/data/strings nadekobot/output/data/strings_old 1>/dev/null 2>&1 && \
    mv -f nadekobot/output/data/strings_new nadekobot/output/data/strings 1>/dev/null 2>&1

# RUN mv creds.yml nadekobot/output/creds.yml
CMD ["/bin/bash", "-c", "cd nadekobot/output && dotnet NadekoBot.dll"]
