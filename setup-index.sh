#!/bin/bash

# Wait until Elasticsearch is up
until curl -s -X GET "http://localhost:9200"; do
    echo "Waiting for Elasticsearch to start..."
    sleep 5
done

echo "Elasticsearch is up..."

# Create index mapping
curl -X PUT "http://localhost:9200/vivo" -H 'Content-Type: application/json' -d @/usr/share/elasticsearch/index-config.json
