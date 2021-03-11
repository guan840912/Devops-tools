#!/bin/bash
mkdir -p /home/gitlab/gitlab-docker-compose/{config,log,data}
sudo setenforce 0
getenforce
function dockercompose {
cat << EOF
version: "3.7"
services:
  gitlab:
    image: "gitlab/gitlab-ce:13.9.2-ce.0"
    restart: always
    hostname: "tgitlab.cathay-ins.com.tw"
    # environment:
      # GITLAB_OMNIBUS_CONFIG: |
      #   external_url "https://tgitlab.cathay-ins.com.tw"
      #   nginx["redirect_http_to_https"] = true
      #   registry_nginx["redirect_http_to_https"] = true
      #   mattermost_nginx["redirect_http_to_https"] = true
      #   nginx["ssl_certificate"] = "/etc/gitlab/ssl/fullchain1.pem"
      #   nginx["ssl_certificate_key"] = "/etc/gitlab/ssl/privkey1.pem"
    ports:
      - "80:80"
      - "443:443"
      - "2022:22"
    volumes:
      - "/home/gitlab/gitlab-docker-compose/config:/etc/gitlab:Z"
      - "/home/gitlab/gitlab-docker-compose/logs:/var/log/gitlab:Z"
      - "/home/gitlab/gitlab-docker-compose/data:/var/opt/gitlab:Z"
EOF
}


dockercompose > docker-compose.yml
dnf install -y curl
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

docker-compose up -d