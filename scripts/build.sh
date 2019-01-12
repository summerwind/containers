#!/bin/bash

for v in */VERSION; do
  NAME="$(dirname $v)"
  VERSION=$(cat $v)

  docker image inspect summerwind/${NAME}:${VERSION} > /dev/null 2>&1

  if [ $? -ne 0 ]; then
    docker build \
      --build-arg VERSION=${VERSION} \
      -t summerwind/${NAME}:latest \
      -t summerwind/${NAME}:${VERSION} \
      ${NAME}
  fi
done
