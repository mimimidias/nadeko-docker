FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update
RUN apt-get install apt-transport-https git tmux redis-server libopus0 opus-tools libopus-dev libsodium-dev python3 ffmpeg libc6 libgcc1 -y
RUN wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp


RUN git clone -b v5 --recursive --depth 1 https://gitlab.com/Kwoth/nadekobot
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
RUN cd nadekobot/src/NadekoBot && dotnet restore && dotnet build -o /output/

CMD ["/bin/bash", "-c", "cd nadekobot/output && dotnet NadekoBot.dll"]
