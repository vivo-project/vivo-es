#!/bin/bash


if [ -f /usr/share/opensearch/setup_done.flag ]; then
    echo "Setup has already been completed, skipping setup."
    exit 0
fi


SSL_ENABLED=$(curl -sk -X GET "https://localhost:9200")

if [ -z "$SSL_ENABLED" ]; then
    echo "SSL not enabled, falling back to HTTP..."
    SSL_ENABLED="false"
else
    SSL_ENABLED="true"
    echo "SSL is enabled"
fi

if [ "$SSL_ENABLED" == "true" ]; then
    OS_URL="https://localhost:9200"
else
    OS_URL="http://localhost:9200"
fi


AUTH="-u $OS_USERNAME:$OPENSEARCH_INITIAL_ADMIN_PASSWORD"

until curl -k -s $AUTH -X GET "$OS_URL"; do
    echo "Waiting for OpenSearch to start..."
    sleep 5
done

echo "OpenSearch is up..."


curl -k $AUTH -X PUT "$OS_URL/$INDEX_NAME" -H 'Content-Type: application/json' -d @/usr/share/opensearch/index-config.json

touch /usr/share/opensearch/setup_done.flag
