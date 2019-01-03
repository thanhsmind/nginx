#!/bin/bash

ARG NGINX_VERSION=1.15

FROM nginx:${NGINX_VERSION}-alpine


ENV NGINX_CONFIG_FOLDER=/data/nginx/config
ENV NGINX_LOG_FOLDER=/data/nginx/log
ENV NGINX_DOCUMENT_FOLDER=/data/nginx/www
ENV DOCKER_INIT_SCRIPT_DIR=/docker_scripts/init

ARG HOST_USER_UID=1000
ARG HOST_USER_GID=1000
ARG HOST_USER_NAME=www
ARG HOST_GROUP_NAME=www

COPY config/ /etc/nginx/conf.d/ 

RUN set -xe \
    \
    && echo 'Creating notroot user and group from host' \
    && addgroup -g ${HOST_USER_UID} -S ${HOST_GROUP_NAME} \
    && adduser  -u ${HOST_USER_UID} -D -S -G ${HOST_GROUP_NAME} ${HOST_USER_NAME} \
    \
    && echo 'Switch to run with Custom USER' \
    && sed -e "s/user\s+.*;/user ${HOST_USER_NAME};/" -i /etc/nginx/nginx.conf \
    && sed -e "s/worker_processes.*/worker_processes auto;/" -i /etc/nginx/nginx.conf \
    && sed -e "s/#gzip.*/gzip on;/" -i /etc/nginx/nginx.conf 
    # \
    # && echo 'Creating custom Config folder...' \    
    # && mv /etc/nginx /etc/nginx_origin \
    # && mkdir -p $NGINX_CONFIG_FOLDER \
    # && rm $NGINX_CONFIG_FOLDER -rf \
    # && ln -s /etc/nginx_origin $NGINX_CONFIG_FOLDER \
    # && ln -s $NGINX_CONFIG_FOLDER /etc/nginx 

    # \
    # && echo 'Creating custom Log folder...' \    
    # && rm /var/log/nginx -rf \
    # && mkdir -p $NGINX_LOG_FOLDER \
    # && ln -s $NGINX_LOG_FOLDER /var/log/nginx \
    # && chown -h ${HOST_USER_NAME}:${HOST_GROUP_NAME} $NGINX_LOG_FOLDER 

# COPY run.sh /run.sh
# COPY init_scripts/* $DOCKER_INIT_SCRIPT_DIR/

# VOLUME ["/app"]

# CMD ["/run.sh"]
