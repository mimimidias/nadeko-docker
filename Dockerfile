FROM ubuntu:24.04

RUN VER=$(cat /etc/debian_version)
RUN SVER=$( grep -oP "[0-9]+" /etc/debian_version | head -1 )

COPY . .

RUN chmod u+x ./install-nadeko.sh && ./install-nadeko.sh

RUN mv creds.yml nadekobot/output/creds.yml

CMD ["/bin/bash", "-c", "./n-run.sh"]