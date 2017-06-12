FROM alpine

RUN apk update \
	&& apk add monit bind-tools
	   # shadow

#RUN useradd -m monit -s /bin/ash

#WORKDIR /home/monit
WORKDIR /root

COPY entrypoint.sh /entrypoint.sh

# Needs root if you want ping
# USER monit

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
CMD ["monit", "-I"]
