FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN dpkg --add-architecture i386
RUN rm -rf /etc/apt/sources.list.d/*
COPY debian.sources /etc/apt/sources.list.d/
RUN apt-get update
RUN apt-get install -y steamcmd
RUN useradd -m -s /bin/bash kf2server
RUN mkdir -p /home/kf2server/games/killingfloor
RUN chown -R kf2server:kf2server /home/kf2server/games
WORKDIR /home/kf2server/games/killingfloor
COPY update.txt /home/kf2server/games/killingfloor/
USER kf2server
RUN steamcmd +runscript /home/kf2server/games/killingfloor/update.txt

CMD ["./Binaries/Win64/KFGameSteamServer.bin.x86_64", "kf-bioticslab"]
