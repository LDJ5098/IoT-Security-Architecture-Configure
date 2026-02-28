#!/bin/sh
cat > /tmp/mosquitto-runtime.conf << EOF
listener ${MQTT_INT_PORT} 0.0.0.0
allow_anonymous true
log_dest file /mosquitto/log/mosquitto.log
log_type all
EOF
exec mosquitto -c /tmp/mosquitto-runtime.conf