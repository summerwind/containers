#!/bin/bash

ER_EVENT_NAMESPACE="default"

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

OUTPUT_DIR="${HOME}/event"

mkdir -p "${OUTPUT_DIR}"
echo "${EVENT}" | jq -r ".spec.id" > "${OUTPUT_DIR}/id"
echo "${EVENT}" | jq -r ".spec.time" > "${OUTPUT_DIR}/time"
echo "${EVENT}" | jq -r ".spec.type" > "${OUTPUT_DIR}/type"
echo "${EVENT}" | jq -r ".spec.source" > "${OUTPUT_DIR}/source"
echo "${EVENT}" | jq -r ".spec.contentType" > "${OUTPUT_DIR}/content_type"
echo "${EVENT}" | jq -r ".spec.data" > "${OUTPUT_DIR}/data"
