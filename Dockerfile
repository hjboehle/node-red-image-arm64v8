FROM node:lts-alpine3.16

ARG NODE_RED_USERNAME=${NODE_RED_USERNAME}
ARG NODE_RED_USERID=${NODE_RED_USERUID}

LABEL org.label-schema.docker.dockerfile="./Dockerfile" \
      org.label-schema.license="GNU General Public License v3.0" \
      org.label-schema.name="Node-RED" \
      org.label-schema.description="Low-code programming for event-driven applications." \
      org.label-schema.url="https://nodered.org" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/hjboehle/node-red-image-arm64v8" \
      org.label-schema.arch=ARM64v8 \
      authors="hj@boehle.info"

RUN apk -U add --no-cache --verbose \
    bash \
    tzdata \
&&  npm install --location=global npm@latest \
&&  npm install --location=global --unsafe-perm node-red \
&&  deluser --remove-home node \
&&  adduser -s /bin/bash -u ${NODE_RED_USERID} -D ${NODE_RED_USERNAME} \
&&  mkdir -p /home/${NODE_RED_USERNAME}/data \
&&  chown -R ${NODE_RED_USERNAME} /home/${NODE_RED_USERNAME} \
&&  chgrp -R ${NODE_RED_USERNAME} /home/${NODE_RED_USERNAME}

EXPOSE 1880

USER ${NODE_RED_USERNAME}:${NODE_RED_USERNAME}

WORKDIR /home/${NODE_RED_USERNAME}

CMD ["node-red", "--userDir", "./data", "flows.json"]
