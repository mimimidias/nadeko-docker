FROM mcr.microsoft.com/dotnet/sdk:6.0

RUN apt-get update 
RUN apt-get install -y git tmux redis-server libopus0 opus-tools libopus-dev libsodium-dev python3 ffmpeg wget
RUN wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp
RUN git clone -b v4 --recursive --depth 1 https://gitlab.com/Kwoth/nadekobot
RUN cd nadekobot/src/NadekoBot && dotnet restore -f --no-cache 
RUN cd nadekobot/src/NadekoBot && dotnet build NadekoBot.csproj -c Release -o /

CMD ["/bin/bash", "-c", "dotnet NadekoBot.dll"]
