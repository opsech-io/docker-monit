#!/bin/bash

USER="$1"
HTPASSWD_FILE="./config/htpasswd"

# Quick check for docker permissions
docker ps -q >/dev/null || exit

if (( ! ${#USER} )); then
    read -p'Username: ' USER
fi

[[ ! -f "${HTPASSWD_FILE}" ]] && > "${HTPASSWD_FILE}"

docker-compose run --rm -v "$PWD/config/htpasswd:/tmp/config/htpasswd:z,rw" monit \
    htpasswd -m /tmp/config/htpasswd "$USER"

# Restart the monit service only if it's running
if [[ $(docker-compose ps -q monit) ]]; then
    docker-compose exec monit monit-reload
fi
