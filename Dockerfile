FROM ubuntu:22.04

# Disable telemetry
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

# Set .NET root environment variable
ENV DOTNET_ROOT=/usr/share/dotnet

# Install dependencies and .NET SDK in one layer
RUN apt-get update && \
    apt-get install -y apt-transport-https wget && \
    wget "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-6.0 python3 git tmux redis-server libopus0 opus-tools libopus-dev libsodium-dev ffmpeg && \
    wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O /usr/local/bin/yt-dlp && \
    chmod a+rx /usr/local/bin/yt-dlp

# Clone the NadekoBot repository
RUN git clone -b v4 --recursive --depth 1 https://gitlab.com/Kwoth/nadekobot

# Restore and build NadekoBot in a single step to preserve context
RUN cd nadekobot && \
    dotnet restore --no-cache && \
    dotnet build src/NadekoBot/NadekoBot.csproj -c Release -o /

# Set the CMD to run NadekoBot
CMD ["dotnet", "/NadekoBot.dll"]
