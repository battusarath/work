#!/usr/bin/env bash

# Wait for the Portfolio to be ready before starting app. Poll Hazelcast default socket
echo "Stalling setup for Portfolio service"

while true; do
    [ "$(curl portfolio:5701 &> /dev/null; echo $?)" != 7 ] && break
    sleep 3s
done

echo "Stall again for a bit"
sleep 15

echo "Starting app"

/etc/init.d/filebeat start -e
java $VERTX_OPTS -jar app-fat.jar -cluster -conf config.json -cp .