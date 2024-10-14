# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory
WORKDIR /app

# Install necessary packages and .NET SDK in one layer to minimize image size
RUN apt-get update && \
    apt-get install -y \
        wget \
        git \
        tmux \
        libopus0 \
        opus-tools \
        libopus-dev \
        libsodium-dev \
        python3 \
        ffmpeg \
        && rm -rf /var/lib/apt/lists/* \
        && wget "https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb" -O packages-microsoft-prod.deb \
        && dpkg -i packages-microsoft-prod.deb \
        && apt-get update \
        && apt-get install -y dotnet-sdk-8.0 \
        && rm -f packages-microsoft-prod.deb

# Install yt-dlp
RUN wget -O /usr/local/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Clone the latest version of NadekoBot
RUN git clone -b v5 --recursive --depth 1 https://gitlab.com/kwoth/nadekobot /app/nadekobot

# Download and execute setup scripts
RUN wget -q -N https://gitlab.com/Kwoth/nadeko-bash-installer/-/raw/v5/detectOS.sh && \
    bash detectOS.sh > /dev/null && \
    wget -q -N https://gitlab.com/kwoth/nadeko-bash-installer/-/raw/v5/rebuild.sh && \
    bash rebuild.sh && \
    rm -f rebuild.sh detectOS.sh

# Cleanup unnecessary files and package lists
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Specify the command to run when the container starts
CMD ["sh", "-c", "echo 'Running NadekoBot'; cd nadekobot/output && echo 'Running NadekoBot. Please wait.' && dotnet NadekoBot.dll && echo 'Done'"]
