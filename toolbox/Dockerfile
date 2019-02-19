FROM golang:1.11 AS builder

ENV GITHUB_RELEASE_VERSION=0.7.2 \
    GIT_CHLOG_VERSION=0.7.1 \
    CONSUL_TEMPLATE_VERSION=0.19.5

RUN apt update \
  && apt install -y bzip2 \
  && rm -rf /var/lib/apt/lists/*

# go-task
RUN curl -s https://taskfile.org/install.sh | sh \
  && install -o root -g root -m 755 ./bin/task /usr/local/bin \
  && rm -rf ./bin

# github-release
RUN curl -L -O https://github.com/aktau/github-release/releases/download/v${GITHUB_RELEASE_VERSION}/linux-amd64-github-release.tar.bz2 \
  && tar jxvf linux-amd64-github-release.tar.bz2 \
  && install -o root -g root -m 755 bin/linux/amd64/github-release /usr/local/bin/github-release

# git-chglog
RUN curl -L -O https://github.com/git-chglog/git-chglog/releases/download/${GIT_CHLOG_VERSION}/git-chglog_linux_amd64 \
  && install -o root -g root -m 755 git-chglog_linux_amd64 /usr/local/bin/git-chglog

# consul-template
RUN curl -L -O https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz \
  && tar zxvf consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz \
  && install -o root -g root -m 755 consul-template /usr/local/bin/consul-template

#######################################

FROM golang:1.11

ENV GO111MODULE=on

COPY --from=builder /usr/local/bin /usr/local/bin
