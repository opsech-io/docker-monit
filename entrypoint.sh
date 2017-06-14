#!/bin/sh

MONIT_USER="$(id -nu)"

# This is word split because ash doesn't do arrays!
INSTALL_FILES='
    /etc/monitrc
    /etc/htpasswd
'

case "$1" in
    monit)
        shift
        # This gets around the problem of volumes and file ownership
        for i in $INSTALL_FILES; do
            if [ -f "/tmp/config/${i##*/}" ]; then
                install -m 0600 -o "$MONIT_USER" -g "$MONIT_USER" "/tmp/config/${i##*/}" "$i"
            fi
        done
        exec monit "$@"
        ;;
    *)
        exec "$@"
        ;;
esac
