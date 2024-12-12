FROM opensearchproject/opensearch:2.18.0

# Simple, single node deployment
ENV discovery.type=single-node
ENV OPENSEARCH_JAVA_OPTS="-Xms512m -Xmx512m"
ENV plugins.security.disabled=true

# VIVO index name
ENV INDEX_NAME="vivo"

# Default OpenSearch username
ENV OS_USERNAME="admin"

# Provide strong initial password
ENV OPENSEARCH_INITIAL_ADMIN_PASSWORD="<STRONG_PASSWORD>"

EXPOSE 9200 9300

COPY /opensearch/setup-index.sh /usr/share/opensearch/setup-index.sh
COPY index-config.json /usr/share/opensearch/index-config.json

CMD ["sh", "-c", "/usr/share/opensearch/opensearch-docker-entrypoint.sh & sleep 15 && sh /usr/share/opensearch/setup-index.sh && wait"]
