#!/bin/bash
set -e
if [[ "${1:0:1}" = '-' ]]; then
    set -- influxd "$@"
fi

/init-influxdb.sh "${@:2}"

exec "influxd" 2>>/var/log/influxdb/influxd.log
