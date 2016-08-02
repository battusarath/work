#!/usr/bin/env bash

# Wait for the ELK container to be ready before starting app.
echo "Stalling for Audit service"

while true; do
    [ "$(curl audit:8080 &> /dev/null; echo $?)" != 7 ] && break
    sleep 1s
done

echo "Stall again for a bit"
sleep 15

echo "Starting app"

/etc/init.d/filebeat start -e
java $VERTX_OPTS -jar app-fat.jar -cluster -conf config.json -cp .