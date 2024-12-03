# vivo-es
Configuration for ElasticSearch index used by VIVO

# How to setup?

## Build the Docker Image:

```
docker build -t vivo-elasticsearch .
```

## Run the Container:

```
docker run -p 9200:9200 -p 9300:9300 --name vivo_es vivo-elasticsearch
```

This setup will start Elasticsearch, expose it on localhost:9200, and create the vivo index with the specified mapping by loading the configuration from index-config.json.

## Alternatively - Run Elasticsearch locally

1. Download Elasticsearch (suited for your platform) from the [official website](https://www.elastic.co/downloads/elasticsearch).
2. Run `bin/elasticsearch` (or `bin\elasticsearch.bat` on Windows) to start Elasticsearch [with security enabled](https://www.elastic.co/guide/en/elasticsearch/reference/current/configuring-stack-security.html).
3. Create `vivo` index by running:
   
```
curl -k -u <ES_USERNAME>:<ES_PASSWORD> -X PUT "https://localhost:9200/vivo" -H 'Content-Type: application/json' -d index-config.json
```

# Adding security
By default, this configuration sets up Elasticsearch without any security measures. A configuration like that is only viable if you are running your ES instance inside of an internal local-area network without exposing it to the internet. If you need to expose your ES instance to the internet you MUST activate necessary security mesures.

In order to setup security (SSL + basic authentication) you have to do the following steps:

- Comment-out or remove the following line from the Dockerfile `ENV xpack.security.enabled=false`

- Build the image and run the container as explained above

- Upon startup, the script will generate a new secure password for you to use when connecting to ES instance. Keep in mind that, at this moment, VIVO only supports basic authentication for ES (API key authentication will be added in the future). Find the console output that looks like this: `The new password for the elastic user is: <PASSWORD_VALUE>` and save the password value, you cannot access it later.

- Then, simply use your new password (username is always `elastic`) to connect to your ES instance from VIVO application.
