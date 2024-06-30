FROM debian:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository non-free && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y steamcmd

RUN useradd -m -s /bin/bash kf2server
RUN mkdir -p /home/kf2server/games/killingfloor
RUN chown -R kf2server:kf2server /home/kf2server/games
WORKDIR /home/kf2server/games/killingfloor
COPY update.txt /home/kf2server/games/killingfloor/
USER kf2server
RUN steamcmd +runscript /home/kf2server/games/killingfloor/update.txt

CMD ["./Binaries/Win64/KFGameSteamServer.bin.x86_64", "kf-bioticslab"]
