#!/bin/sh
set -e

for script in ${DOCKER_INIT_SCRIPT_DIR}/*
do
    echo $script
    if [[ -x $script ]]; then
        $script
    fi
done

exec /usr/sbin/nginx -g "daemon off;"