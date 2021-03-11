#!/bin/bash

mkdir -p /home/sonarqube || exit 1
sudo setenforce 0
getenforce

function dockercompose {
cat << EOF
version: "3.7"
services:
  sonarqube:
    image: sonarqube:8-community
    depends_on:
      - db
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://db:5432/sonar
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: sonar
    volumes:
      - /home/sonarqube/sonarqube_data:/opt/sonarqube/data:Z
      - /home/sonarqube/sonarqube_extensions:/opt/sonarqube/extensions:Z
      - /home/sonarqube/sonarqube_logs:/opt/sonarqube/logs:Z
      - /home/sonarqube/sonarqube_temp:/opt/sonarqube/temp:Z
    ports:
      - "9000:9000"
  db:
    image: postgres:12
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonar
    volumes:
      - /home/postgresql/postgresql:/var/lib/postgresql:Z
      - /home/postgresql/postgresql_data:/var/lib/postgresql/data:Z
EOF
}

dockercompose > docker-compose.yml
dnf install -y curl
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

echo "Setting Configure"
sysctl -w vm.max_map_count=524288
sysctl -w fs.file-max=131072
sh -c "echo 'vm.max_map_count=524288' >> /etc/sysctl.conf"
sh -c "echo 'fs.file-max=131072' >> /etc/sysctl.conf"
sysctl -p
sh -c "echo \"OPTIONS='--default-ulimit nofile=131072:131072'\" >> /etc/sysconfig/docker"

docker-compose up -d