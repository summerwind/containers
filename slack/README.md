# slack

Sending a message to Slack using incoming webhook.

## Usage

```
$ docker run -it summerwind/slack:latest \
    -u ${SLACK_WEBHOOK_URL} -f ${SLACK_MESSAGE_FILE}
```
