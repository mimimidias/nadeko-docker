FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update
RUN apt-get install apt-transport-https git tmux redis-server libopus0 opus-tools libopus-dev libsodium-dev python3 ffmpeg libc6 libgcc1 -y
RUN wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp

ARG TARGETARCH
ARG TARGETOS

RUN if [ "$TARGETOS" = "darwin" ]; then TARGETOS=osx; fi; \
    if [ "$TARGETARCH" = "amd64" ]; then TARGETARCH=x64; fi; \
    wget https://gitlab.com/api/v4/projects/9321079/packages/generic/NadekoBot-build/5.1.14/5.1.14-$TARGETOS-$TARGETARCH-build.tar -O 5.1.14-build.tar \
    && tar -xvf 5.1.14-build.tar --strip-components=1 \
    && rm 5.1.14-build.tar

CMD ["/bin/bash", "-c", "dotnet NadekoBot.dll"]
