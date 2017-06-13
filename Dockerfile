FROM alpine

RUN \
    apk update \
    && apk add monit bind-tools apache2-utils
    # shadow

#RUN useradd -m monit -s /bin/ash
#WORKDIR /home/monit
WORKDIR /root

COPY entrypoint.sh .

RUN \
    echo -e "#!/bin/sh\n/root/entrypoint.sh monit reload" >> /usr/local/bin/monit-reload; \
    chmod -R +x /usr/local/bin;

# Needs root if you want ping
# USER monit

EXPOSE 8080
ENTRYPOINT ["/root/entrypoint.sh"]
CMD ["monit", "-I", "-c", "/etc/monitrc"]
