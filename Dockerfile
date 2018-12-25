FROM ubuntu:latest
MAINTAINER Andreas Oeldemann <hey@aoel.io>

RUN apt-get update \
 && apt-get install -y --no-install-recommends vlc \
 && rm -rf /var/lib/apt/lists/*

RUN useradd -G video -m -s /bin/bash vlc

EXPOSE 4321/tcp

ENTRYPOINT cvlc v4l2:///dev/video0:chroma=h264:width=1920:height=1080 \
  --sout '#standard{access=http,mux=ts,dst=:4321,name=stream,mime=video/ts}'
