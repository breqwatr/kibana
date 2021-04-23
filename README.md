# Kibana
## Build Image
Clone this repo and run following command to build elasticsearch docker image.
```
docker build . -t <image-name>:<image-tag>
```

## Create Kibana Container
Run following command to create kibana container.
```
docker run -d -it --name <container-name> --network host -v /<path to>/kibana.yml:/etc/kibana/kibana.yml <image-name>:<tag>
```

## Traffic Encryption Between Browser And Kibana
You can either use your organization's cert or you can generate a self-signed one using elasticsearch-certutil.
To generate self-signed cert, go to you elasticsearch container and run following commands.
```
cd /usr/share/elasticsearch/
bin/elasticsearch-certutil ca --pem
# It will ask for name you want to assign to zip file. Default is elastic-stack-ca.zip
```
Copy this zip file to host and unzip it. It will have following files.
```
/ca/ca.crt
/ca/ca.key
```
Copy this ca/ directory to kibana container.
```
docker cp ca/ <container-name>:/
```
Add these configs in kibana.yml.
```
server.ssl.enabled: true
server.ssl.certificate: /ca/ca.crt
server.ssl.key: /ca/ca.key
```
Then restart kibana container.
```
docker restart <container-name>
```
Now try accessing your kibana dashboard with https.
