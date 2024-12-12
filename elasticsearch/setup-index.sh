#!/bin/bash


if [ -f /usr/share/elasticsearch/setup_done.flag ]; then
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
    ES_URL="https://localhost:9200"
else
    ES_URL="http://localhost:9200"
fi


ES_PASSWORD=$( /usr/share/elasticsearch/bin/elasticsearch-reset-password -u $ES_USERNAME --url $ES_URL --batch 2>&1 | grep -oP '(?<=New value: ).*' )

echo "The new password for the [$ES_USERNAME] user is: $ES_PASSWORD"


AUTH=""
if [[ -n "$ES_USERNAME" && -n "$ES_PASSWORD" ]]; then
    AUTH="-u $ES_USERNAME:$ES_PASSWORD"
fi


until curl -k -s $AUTH -X GET "$ES_URL"; do
    echo "Waiting for Elasticsearch to start..."
    sleep 5
done

echo "Elasticsearch is up..."


curl -k $AUTH -X PUT "$ES_URL/$INDEX_NAME" -H 'Content-Type: application/json' -d @/usr/share/elasticsearch/index-config.json

touch /usr/share/elasticsearch/setup_done.flag
