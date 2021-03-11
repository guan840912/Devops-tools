#!/bin/bash
echo "Create /home/jenkins/jenkins-data"
mkdir -p /home/jenkins/jenkins-data
sudo setenforce 0
getenforce


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
      - /home/jenkins/jenkins-data:/var/jenkins_home:Z
      - /home/jenkins:/home:Z
      - /var/run/docker.sock:/var/run/docker.sock:Z
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
