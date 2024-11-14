# vivo-es
Configuration for ElasticSearch index used by VIVO

# How to setup?

## Build the Docker Image:

```
docker build -t vivo-elasticsearch .
```

## Run the Container:

```
docker run -p 9200:9200 -p 9300:9300 vivo-elasticsearch
```

This setup will start Elasticsearch, expose it on localhost:9200, and create the vivo index with the specified mapping by loading the configuration from index-config.json.