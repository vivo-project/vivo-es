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

# Adding security
By default, this configuration sets up Elasticsearch without any security measures. This configuration is only viable if you are running your ES instance in side of internal local-area network without exposing it to the internet. In order to activate security you have to do the following steps:

- Comment-out or remove the following line from the Dockerfile `ENV xpack.security.enabled=false`

- Upon startup, the script will generate a new secure password for you to use when connecting to ES. Keep in mind that at this moment VIVO only supports basic authentication (API key authentication will be added in the future). Find the console output that looks like this: `The new password for the elastic user is: <PASSWORD_VALUE>` and save the password value, you cannot access it later.

- Then, simply use your new password (username is always `elastic`) to connect to your ES instance from VIVO application.