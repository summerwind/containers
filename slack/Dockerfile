FROM ubuntu:18.04

RUN apt update \
  && apt install -y curl \
  && rm -rf /var/lib/apt/lists/*

COPY slack.sh /usr/local/bin/slack

ENTRYPOINT ["/usr/local/bin/slack"]
