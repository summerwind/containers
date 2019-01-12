#!/bin/bash

for v in */VERSION; do
  NAME=$(dirname $v)
  VERSION=$(cat $v)

  echo -e "${NAME}\t${VERSION}"
done
