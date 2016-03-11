FROM rabbitmq:3.5.7-management

MAINTAINER Alexander Lomov <ab@lomov.io>

COPY ./plugins /usr/lib/rabbitmq/lib/rabbitmq_server-3.5.7/plugins

RUN rabbitmq-plugins enable --offline pgsql_listen_exchange && \
	apt-get -y update && \
	apt-get install --no-install-recommends -y python 

COPY ./rabbitmqadmin /usr/local/bin
COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["rabbitmq-server"]
