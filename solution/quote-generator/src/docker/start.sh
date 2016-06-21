#!/usr/bin/env bash

# Wait for the ELK container to be ready before starting app.
echo "Stalling for ELK stack"

# Not optimal way to stall
sleep 40

echo "Starting app"

/etc/init.d/filebeat start -e
java $VERTX_OPTS -jar app-fat.jar -cluster -conf config.json -cp .