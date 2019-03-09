FROM ubuntu:18.04

ARG VERSION

RUN apt update \
  && apt install -y software-properties-common \
  && apt-add-repository --yes --update ppa:ansible/ansible \
  && apt install -y ansible=${VERSION}-1ppa~bionic

ENTRYPOINT ["/usr/bin/ansible-playbook"]
