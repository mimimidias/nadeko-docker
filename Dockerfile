FROM mcr.microsoft.com/dotnet/sdk:8.0

RUN apt-get update
RUN apt-get install apt-transport-https git tmux redis-server libopus0 opus-tools libopus-dev libsodium-dev python3 ffmpeg libc6 libgcc1 -y
RUN wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && chmod a+rx /usr/local/bin/yt-dlp
RUN if [ "$TARGETOS" = "linux" ]; then \
      if [ "$TARGETARCH" = "arm64" ]; then \
        wget https://gitlab.com/api/v4/projects/9321079/packages/generic/NadekoBot-build/5.1.14/5.1.14-linux-arm64-build.tar -O 5.1.14-build.tar; \
      elif [ "$TARGETARCH" = "amd64" ]; then \
        wget https://gitlab.com/api/v4/projects/9321079/packages/generic/NadekoBot-build/5.1.14/5.1.14-linux-x64-build.tar -O 5.1.14-build.tar; \
      fi; \
    elif [ "$TARGETOS" = "darwin" ]; then \
      if [ "$TARGETARCH" = "arm64" ]; then \
        wget https://gitlab.com/api/v4/projects/9321079/packages/generic/NadekoBot-build/5.1.14/5.1.14-osx-arm64-build.tar -O 5.1.14-build.tar; \
      elif [ "$TARGETARCH" = "amd64" ]; then \
        wget https://gitlab.com/api/v4/projects/9321079/packages/generic/NadekoBot-build/5.1.14/5.1.14-osx-x64-build.tar -O 5.1.14-build.tar; \
      fi; \
    elif [ "$TARGETOS" = "windows" ]; then \
      if [ "$TARGETARCH" = "arm64" ]; then \
        wget https://gitlab.com/api/v4/projects/9321079/packages/generic/NadekoBot-build/5.1.14/5.1.14-windows-arm64-build.zip -O 5.1.14-build.zip; \
      elif [ "$TARGETARCH" = "amd64" ]; then \
        wget https://gitlab.com/api/v4/projects/9321079/packages/generic/NadekoBot-build/5.1.14/5.1.14-windows-x64-build.zip -O 5.1.14-build.zip; \
      fi; \
    else \
      echo "Unsupported OS/architecture: $TARGETOS/$TARGETARCH"; exit 1; \
    fi \
    # Extract tar or zip files accordingly
    && if [ "$TARGETOS" = "windows" ]; then \
      unzip 5.1.14-build.zip -d .; \
    else \
      tar -xvf 5.1.14-build.tar --strip-components=1; \
    fi \
    # Clean up
    && rm 5.1.14-build.*

CMD ["/bin/bash", "-c", "dotnet NadekoBot.dll"]
