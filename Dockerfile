# Use a stable version of the .NET SDK as the base image
FROM mcr.microsoft.com/dotnet/sdk:8.0.400 AS build-env

# Set the working directory
WORKDIR /app

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
        git \
        tmux \
        libopus0 \
        opus-tools \
        libopus-dev \
        libsodium-dev \
        python3 \
        ffmpeg \
        && rm -rf /var/lib/apt/lists/*

# Install yt-dlp
RUN wget -O /usr/local/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp

# Clone the latest version of NadekoBot into the /app directory
RUN git clone -b v5 --recursive --depth 1 https://gitlab.com/kwoth/nadekobot .

# Restore dependencies
RUN dotnet restore NadekoBot.sln --verbosity diagnostic

# Build the project with verbose logging
RUN dotnet build NadekoBot.sln --configuration Release --verbosity diagnostic

# Download and execute setup scripts
RUN wget -q -N https://gitlab.com/Kwoth/nadeko-bash-installer/-/raw/v5/detectOS.sh && \
    bash detectOS.sh > /dev/null && \
    wget -q -N https://gitlab.com/kwoth/nadeko-bash-installer/-/raw/v5/rebuild.sh && \
    bash rebuild.sh && \
    rm -f rebuild.sh detectOS.sh

# Cleanup unnecessary files
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Specify the command to run when the container starts
CMD ["sh", "-c", "echo 'Running NadekoBot'; cd output && echo 'Running NadekoBot. Please wait.' && dotnet NadekoBot.dll && echo 'Done'"]
