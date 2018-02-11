#
# Shadowsocks Dockerfile
#
# https://github.com/FantasRu/Dockerfiles
#

# Pull base image.
FROM daocloud.io/library/python:latest
ARG arg
COPY . /etc
RUN \
	if [ -z "$arg"] ; \
		then echo Argument not provided, use default config. && \
		cat /etc/ssconfig.json ; \
	else \
		echo Argument is $arg && \
		curl $arg > /etc/ssconfig.json ; \
	fi
RUN pip3 install shadowsocks==2.8.2
EXPOSE 10000-10020
CMD ["python3", "/usr/local/bin/ssserver", "-c", "/etc/ssconfig.json", "start"]