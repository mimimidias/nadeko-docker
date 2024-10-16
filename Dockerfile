FROM ubuntu:22.04

ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

RUN apt-get update && apt-get install -y apt-transport-https && sudo apt-grt remove dotnet* && apt-get update;
RUN wget "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb && dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb
RUN apt-get update;

RUN apt-get install -y dotnet-sdk-6.0 python3 git tmux redis-server libopus0 opus-tools libopus-dev libsodium-dev ffmpeg wget
RUN wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp
RUN git clone -b v4 --recursive --depth 1 https://gitlab.com/Kwoth/nadekobot
RUN cd nadekobot && dotnet restore -f --no-cache 
RUN cd nadekobot && dotnet build src/NadekoBot/NadekoBot.csproj -c Release -o /

CMD ["/bin/bash", "-c", "dotnet NadekoBot.dll"]
