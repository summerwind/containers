FROM node:11.3.0-slim

ARG VERSION

RUN npm install -g smee-client@${VERSION}

USER 10000:10000

ENTRYPOINT ["smee"]
