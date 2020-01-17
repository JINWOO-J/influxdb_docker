#!/bin/bash

APP=influxdb
CNF_FILE=influxdb.conf
DATA_DIR=/data/influxdb
VERSION=1.7.4
COMMENT='InfluxDB time series database'

. ../install-function
os_check
user_check
directory_check
docker_check

groupadd -g 860 ${APP} && useradd -u 860 -g ${APP} -c "${COMMENT}" -s /bin/false ${APP}

mkdir -p /data/influxdb/lib /data/influxdb/log

chown -R influxdb:influxdb /data/influxdb && chmod -R 750 /data/influxdb

app_config

docker build -t iconloop/${APP}:${VERSION} .
docker-compose up -d

echo "alias influxdb-admin='docker exec -it influxdb bash'" >>~root/.bashrc
if [ -e ~centos ]; then
	echo "alias influxdb-admin='docker exec -it influxdb bash'" >>~centos/.bashrc
fi

admin_info
# echo "alias influxdb-admin='influx -precision rfc3339'" >>~influxdb/.bashrc
