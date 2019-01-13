#!/bin/bash

usage() {
  echo "Usage: $0 [-n namespace] [-e event_name]"
  exit 1
}

while getopts "e:n:h" OPT
do
  case $OPT in
    "e") ER_EVENT_NAME=${OPTARG} ;;
    "n") ER_EVENT_NAMESPACE=${OPTARG} ;;
    "h") usage ;;
  esac
done

if [ -z "${ER_EVENT_NAME}" ]; then
  echo "Event name is not set."
  exit 1
fi

if [ -z "${ER_EVENT_NAMESPACE}" ]; then
  echo "Event namespace is not set."
  exit 1
fi

EVENT=`kubectl get events.eventreactor.summerwind.github.io ${ER_EVENT_NAME} -n ${ER_EVENT_NAMESPACE} -o json`
if [ $? -ne 0 ]; then
  echo "Unable to fetch event."
  exit 1
fi

GITHUB_PAYLOAD=`echo "${EVENT}" | jq -r .spec.data`
GITHUB_REF=`echo "${GITHUB_PAYLOAD}" | jq -r .ref`
GITHUB_COMMIT=`echo "${GITHUB_PAYLOAD}" | jq -r .head_commit.id`
GITHUB_REPO_URL=`echo "${GITHUB_PAYLOAD}" | jq -r .repository.clone_url`

if [ -z "${GITHUB_REF}" ]; then
  echo "Invalid payload."
  exit 1
fi

echo "URL: ${GITHUB_REPO_URL}"
echo "Ref: ${GITHUB_REF}"
echo "Commit: ${GITHUB_COMMIT}"

set -e

# Initialize repository
git init
git remote add origin "${GITHUB_REPO_URL}"

# Checkout
if [ `echo "${GITHUB_REF}" | grep 'refs/tags/'` ]; then
  git fetch --tags origin "+${GITHUB_REF}:"
  git checkout -qf FETCH_HEAD
else
  git fetch --no-tags origin "+${GITHUB_REF}:"
  git reset --hard -q "${GITHUB_COMMIT}"
fi

# Initialize submodules
git submodule update --init --recursive

