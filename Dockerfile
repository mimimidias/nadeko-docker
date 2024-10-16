FROM ubuntu:22.04

RUN VER=$(cat /etc/debian_version)
RUN SVER=$( grep -oP "[0-9]+" /etc/debian_version | head -1 )

COPY . .

RUN chmod u+x ./install-prereq.sh && ./install-prereq.sh
RUN chmod u+x ./install-nadeko.sh && ./install-nadeko.sh
RUN chmod u+x ./run-nadeko.sh

# RUN mv creds.yml nadekobot/output/creds.yml

CMD ["/bin/bash", "-c", "./run-nadeko.sh"]
