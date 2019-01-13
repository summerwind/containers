FROM ubuntu:18.04

ARG KUBECTL_VERSION=1.13.0

RUN apt update \
  && apt install -y jq curl \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L -O https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
  && install -o root -g root -m 755 kubectl /usr/local/bin/kubectl \
  && rm kubectl

COPY event-init.sh /usr/local/bin/event-init

ENTRYPOINT ["/usr/local/bin/event-init"]
