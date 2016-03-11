#!/bin/bash

set -e

if [ "$1" = 'rabbitmq-server' ]; then

	if [ ! -s "/var/lib/rabbitmq/mnesia/rabbit@$HOSTNAME" ]; then

		RABBITMQ_NODE_IP_ADDRESS=127.0.0.1 RABBITMQ_PID_FILE=./pid bash -c 'nohup rabbitmq-server > /dev/null 2>&1 &'
		rabbitmqctl wait ./pid

		for f in /docker-entrypoint-init.d/*; do
			case "$f" in
				*.sh)     echo "$0: running $f"; . "$f" ;;
				*)        echo "$0: ignoring $f" ;;
			esac
			echo
		done

		rabbitmqctl stop ./pid
	fi
fi

exec "$@"
