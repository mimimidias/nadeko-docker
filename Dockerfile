FROM ubuntu:22.04

RUN VER=$(cat /etc/debian_version)
RUN SVER=$( grep -oP "[0-9]+" /etc/debian_version | head -1 )

COPY . .

RUN chmod u+x ./install-nadeko.sh && ./install-nadeko.sh

CMD ["/bin/bash", "-c", "export root=$(pwd) && cd '$root/nadekobot/output' && echo 'Running NadekoBot. Please wait.' && dotnet NadekoBot.dll" ]
