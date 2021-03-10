#!/bin/bash
function dockercompose {
cat << EOF
version: "3.7"
services:
  nexus:
    image: "sonatype/nexus3:3.30.0"
    container_name: "nexus"
    restart: always
    ports:
      - "8081:8081"
      - "5000:5000"
    volumes:
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
      - /var/lib/docker/nexus/nexus-data:/nexus-data:z
    logging:
      driver: "json-file"
      options:
        max-size: "100k"
        max-file: "4"
EOF
}
mkdir -p /var/lib/docker/nexus/nexus-data

ls -l /var/lib/docker/nexus/nexus-data
dockercompose > docker-compose.yml
dnf install -y curl
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

docker-compose up -d

exit 0
## https://github.com/mlabouardy/nexus-cli