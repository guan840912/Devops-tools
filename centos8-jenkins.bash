#!/bin/bash
echo "Create /home/centos/jenkins-data"
mkdir /home/centos/jenkins-data

echo "Run Jenkins Server"
function dockercompose {
cat << EOF
version: "3.7"
services:
  nexus:
    image: "jenkinsci/blueocean"
    container_name: "jks"
    restart: always
    user: root
    ports:
      - "8080:8080"
      - "50000:50000"
    volumes:
      - /home/centos/jenkins-data:/var/jenkins_home
      - /home/centos:/home
      - /var/run/docker.sock:/var/run/docker.sock:z
    logging:
      driver: "json-file"
      options:
        max-size: "100k"
        max-file: "4"
EOF
}

dockercompose > docker-compose.yml
dnf install -y curl
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

docker-compose up -d

echo "Please \"docker logs -f jks \" to Get login Token"
exit 0
