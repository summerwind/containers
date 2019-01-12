# smee-client

Client and CLI for smee.io, a service that delivers webhooks to your local development environment.

## Usage

```
$ docker run -it summerwind/smee-client:latest \
    -u ${SMEE_URL} -p ${TARGET_PORT} -P ${TARGET_PATH}
```
