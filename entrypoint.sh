#!/bin/sh

MONIT_USER="$(id -nu)"

install -m 0600 -o "$MONIT_USER" -g "$MONIT_USER" /tmp/monitrc /etc/monitrc

exec "$@"
