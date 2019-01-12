#!/bin/bash

SLACK_MESSAGE_FILE="message.json"

usage() {
  echo "Usage: $0 [-f message_file] [-u webhook_url]"
  exit 1
}

while getopts "f:u:h" OPT
do
  case $OPT in
    "f") SLACK_MESSAGE_FILE=${OPTARG} ;;
    "u") SLACK_WEBHOOK_URL=${OPTARG} ;;
    "h") usage ;;
  esac
done

if [ -z "${SLACK_WEBHOOK_URL}" ]; then
  echo "Webhook URL is not set."
  exit 1
fi

if [ ! -e "${SLACK_MESSAGE_FILE}" ]; then
  echo "Message file does not exist."
  exit 1
fi

RESULT=`curl -s -d "@${SLACK_MESSAGE_FILE}" "${SLACK_WEBHOOK_URL}"`

if [ $? -ne 0 ]; then
  echo "Failed to send message: ${RESULT}"
  exit 1
fi

echo "Success"
