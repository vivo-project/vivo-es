# vivo-es
Configuration for Elasticsearch/OpenSearch index used by VIVO

# How to setup?

## Build the Docker Image:

```
sudo docker build -t vivo-elasticsearch -f elasticsearch/Dockerfile .
```
if you want to use OpenSearch:
```
sudo docker build -t vivo-opensearch -f opensearch/Dockerfile .
```

## Run the Container:

```
docker run -p 9200:9200 -p 9300:9300 --name vivo_es vivo-elasticsearch
```
if you built OpenSearch image:
```
docker run -p 9200:9200 -p 9300:9300 --name vivo_os vivo-opensearch
```

This setup will start Elasticsearch/OpenSearch, expose it on localhost:9200, and create the vivo index with the specified mapping by loading the configuration from index-config.json.

## Alternatively - Run Elasticsearch locally

1. Download Elasticsearch (suited for your platform) from the [official website](https://www.elastic.co/downloads/elasticsearch).
2. Run `bin/elasticsearch` (or `bin\elasticsearch.bat` on Windows) to start Elasticsearch [with security enabled](https://www.elastic.co/guide/en/elasticsearch/reference/current/configuring-stack-security.html).
3. Create `vivo` index by running:
   
```
curl -k -u '<ES_USERNAME>:<ES_PASSWORD>' -X PUT "https://localhost:9200/vivo" -H 'Content-Type: application/json' -d index-config.json
```

## Alternatively - Run OpenSearch locally

1. Download OpenSearch (suited for your platform) from the [official website](https://opensearch.org/versions/opensearch-2-18-0.html).
2. Run `./opensearch` (or `./opensearch.bat` on Windows) to start OpenSearch [with security enabled](https://opensearch.org/docs/latest/security/).
3. Create `vivo` index by running:
   
```
curl -k -u '<OS_USERNAME>:<OS_PASSWORD>' -X PUT "https://localhost:9200/vivo" -H 'Content-Type: application/json' -d index-config.json
```

# Adding security
By default, docker configuration sets up Elasticsearch/OpenSearch without any security measures. A configuration like that is only viable if you are running your ES/OS instance inside of an internal local-area network without exposing it to the internet. If you need to expose your ES/OS instance to the internet you MUST activate necessary security mesures.

In order to setup security (SSL + basic authentication) you have to do the following steps:

- Comment-out or remove the following line from the Dockerfile `ENV xpack.security.enabled=false` for Elasticsearch or `ENV plugins.security.disabled=true` for OpenSearch. If you use OS, you have to provide an initial administrator password through `OPENSEARCH_INITIAL_ADMIN_PASSWORD` variable.

- Build the image and run the respected container as explained above

- If you are using ES, upon startup, the script will generate a new secure password for you to use when connecting to the instance. Find the console output that looks like this: `The new password for the elastic user is: <PASSWORD_VALUE>` and save the password value, you cannot access it later. Keep in mind that, at this moment, VIVO only supports basic authentication for ES/OS (API key authentication will be added in the future).

- Then, simply use your new password (username is always `elastic`/`admin`) to connect to your ES/OS instance (respectfully) from VIVO application.
