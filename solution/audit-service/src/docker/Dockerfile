FROM java:8

ARG fatJar
ARG vertxOptsArg

## Set environment variable with the argument passed during build time
ENV VERTX_OPTS $vertxOptsArg

## Declare listening port
EXPOSE 8080

## We will work in the /opt directory
WORKDIR /opt

## Install Filebeat and prerequisites
RUN apt-get update -qq \
 && apt-get install -qqy curl \
 && apt-get clean

RUN curl -L -O https://download.elastic.co/beats/filebeat/filebeat_1.2.3_amd64.deb \
 && dpkg -i filebeat_1.2.3_amd64.deb \
 && rm filebeat_1.2.3_amd64.deb

## Add Filebeat configuration
ADD filebeat.yml /etc/filebeat/filebeat.yml

## Add CA certificate
RUN mkdir -p /etc/pki/tls/certs
ADD logstash-beats.crt /etc/pki/tls/certs/logstash-beats.crt

## Application
COPY /maven/$fatJar ./app-fat.jar

## Config file
ADD config.json ./

## Assign permissions to workdir
RUN chmod -R 777 /opt

## Start script
ADD start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh
CMD [ "/tmp/start.sh" ]