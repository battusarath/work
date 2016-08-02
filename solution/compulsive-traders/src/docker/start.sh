#!/usr/bin/env bash

# Wait for the ELK container to be ready before starting app.
echo "Stalling for Logstash"

while true; do
    [ "$(curl consolidation:5701 &> /dev/null; echo $?)" != 7 ] && [ "$(curl portfolio:5701 &> /dev/null; echo $?)" != 7 ] && break
    sleep 3s
done

echo "Starting app"

/etc/init.d/filebeat start -e
java $VERTX_OPTS -jar app-fat.jar -cluster -conf config.json -cp .