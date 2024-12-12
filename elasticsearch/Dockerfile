FROM docker.elastic.co/elasticsearch/elasticsearch:8.9.0

# Simple, single node deployment
ENV discovery.type=single-node
ENV ES_JAVA_OPTS="-Xms512m -Xmx512m"
ENV xpack.security.enabled=false

# VIVO index name
ENV INDEX_NAME="vivo"

# Default es username
ENV ES_USERNAME="elastic"

EXPOSE 9200 9300

COPY ./elasticsearch/setup-index.sh /usr/share/elasticsearch/setup-index.sh
COPY index-config.json /usr/share/elasticsearch/index-config.json

CMD ["sh", "-c", "/usr/local/bin/docker-entrypoint.sh & sleep 15 && sh /usr/share/elasticsearch/setup-index.sh && wait"]
