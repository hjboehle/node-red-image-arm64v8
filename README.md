# Node-RED Image for Architecture arm64v8

With the contained Dockerfile it is possible to build an image for Node-RED, which runs on an ARM64v8 architecture. This image is for example useable on a Raspberry Pi Mod B.

## Features

The following features are included:

* newest Node-RED version
* based on a small Apline OS base image
* username an user id (uid) choosable within build process
* runable on the ARM64v8 architecture

## Image Build Process

The image is to build with the following "docker build" command:

    docker build --tag <imagename>:<tag> \
    --build-arg NODE_RED_USERNAME=<username> \
    --build-arg NODE_RED_USERID=<uid> .

Note: With the variables `NODE_RED_USERNAME` and `NODE_RED_USERID` the username and the userid (uid) are choosable. With this username and userid will Node-RED starts.

## Run the Container

When the image is built the following command the conatiner starts:

    docker container run -d \
    -p 1880:1880 \
    -v <data directory of the host>:<data directory of the host> \
    --name <containername> \
    <imagename>:<tag>

## Run the Container with docker-compose

The following yaml structure must be placed in the `docker-compose.yml` file:

    version: '3.8'
    services:
      nodered:
        container_name: <containername>
        build:
          context: .
          dockerfile: <location of the Dockerfile>
          args:
            NODE_RED_USERNAME: <username>
            NODE_RED_USERID: <uid>
        user: <uid>:<gid equal the uid>
        ports:
          - 1880:1880
        volumes:
          - <data directory of the host>:<data directory of the host>
        environment:
          - TZ=Europe/Berlin
        restart: always

With `docker-compose build` and `docker-compose up -d` the stack starts.
