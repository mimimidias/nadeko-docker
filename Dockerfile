FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install wget -y && wget "https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb && apt-get update
RUN apt-get install apt-transport-https dotnet-sdk-8.0 git tmux redis-server libopus0 opus-tools libopus-dev libsodium-dev python3 ffmpeg libc6 libgcc1 -y
RUN wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp

RUN git clone -b v4 --recursive --depth 1 https://gitlab.com/Kwoth/nadekobot
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV ROOT=$(pwd)
RUN cd nadekobot && dotnet restore -f --no-cache
RUN cd nadekobot && dotnet build src/NadekoBot/NadekoBot.csproj -c Release -o output/

CMD ["/bin/bash", "-c", "cd '$root/nadekobot/output' && dotnet NadekoBot.dll"]
