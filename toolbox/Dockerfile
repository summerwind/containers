FROM golang:1.13 AS builder

ENV DOCKER_VERSION=18.09.4 \
    GITHUB_RELEASE_VERSION=0.7.2 \
    GIT_CHLOG_VERSION=0.7.1 \
    GHR_VERSION=0.12.0 \
    CONSUL_TEMPLATE_VERSION=0.19.5 \
    HUB_VERSION=2.10.0

RUN apt update \
  && apt install -y bzip2 \
  && rm -rf /var/lib/apt/lists/*

# go-task
RUN curl -s https://taskfile.org/install.sh | sh \
  && install -o root -g root -m 755 ./bin/task /usr/local/bin \
  && rm -rf ./bin

# Docker
RUN curl -L -O https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
  && tar zxvf docker-${DOCKER_VERSION}.tgz \
  && install -o root -g root -m 755 docker/docker /usr/local/bin/docker

# github-release
RUN curl -L -O https://github.com/aktau/github-release/releases/download/v${GITHUB_RELEASE_VERSION}/linux-amd64-github-release.tar.bz2 \
  && tar jxvf linux-amd64-github-release.tar.bz2 \
  && install -o root -g root -m 755 bin/linux/amd64/github-release /usr/local/bin/github-release

# git-chglog
RUN curl -L -O https://github.com/git-chglog/git-chglog/releases/download/${GIT_CHLOG_VERSION}/git-chglog_linux_amd64 \
  && install -o root -g root -m 755 git-chglog_linux_amd64 /usr/local/bin/git-chglog

# ghr
RUN curl -L -O https://github.com/tcnksm/ghr/releases/download/v${GHR_VERSION}/ghr_v${GHR_VERSION}_linux_amd64.tar.gz \
  && tar zxvf ghr_v${GHR_VERSION}_linux_amd64.tar.gz \
  && install -o root -g root -m 755 ghr_v${GHR_VERSION}_linux_amd64/ghr /usr/local/bin/ghr

# consul-template
RUN curl -L -O https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz \
  && tar zxvf consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz \
  && install -o root -g root -m 755 consul-template /usr/local/bin/consul-template

# hub
RUN curl -L -O https://github.com/github/hub/releases/download/v${HUB_VERSION}/hub-linux-amd64-${HUB_VERSION}.tgz \
  && tar zxvf hub-linux-amd64-${HUB_VERSION}.tgz \
  && install -o root -g root -m 755 hub-linux-amd64-${HUB_VERSION}/bin/hub /usr/local/bin/hub

# testing framework
RUN curl -L -o /tmp/download-binaries.sh https://raw.githubusercontent.com/kubernetes-sigs/testing_frameworks/master/integration/scripts/download-binaries.sh \
  && chmod +x /tmp/download-binaries.sh \
  && mkdir -p /usr/local/kubebuilder/bin \
  && /tmp/download-binaries.sh /usr/local/kubebuilder/bin

COPY scripts/* /usr/local/bin/

#######################################

FROM golang:1.13

ENV GO111MODULE=on \
    DOCKER_BUILDKIT=1

RUN apt update \
  && apt install -y git jq zip bzip2 ca-certificates \
  && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/kubebuilder/bin /usr/local/kubebuilder/bin
