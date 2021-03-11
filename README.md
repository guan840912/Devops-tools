# Devops-tools



# 目前使用者先都用 Root

## RHEL 8.2 安裝 docker 
1. 安裝 CentOS8 Base Repo 
   ```bash
   sudo cp yum/CentOS8-base.repo /etc/yum.repos.d/CentOS8-base.repo
   ```
2. 執行 Shell Script 安裝 docker
   ```bash
   bash centos8-docker.bash
   ```
3. 檢查服務是否啟用正常
   ```bash
   systemctl status docker

   # docker 服務未正常啟動 檢查指令.
   journalctl -u docker

   # C-trl + C 結束 tail file. 
   tail -f /var/log/messages

   # 重啟 docker service 
   systemctl restart docker 
   ```

### Gitlab
(請先裝好 docker)
官方安裝手冊
https://docs.gitlab.com/omnibus/docker/README.html
```bash
#先切為 root
cd /root
bash centos8-gitlab.bash
```

### Jenkins
(請先裝好 docker)
官方安裝手冊
https://www.jenkins.io/doc/book/installing/docker/
```bash
bash centos8-jenkins.bash

docker logs jks
```

### Nexus
(請先裝好 docker)
官方安裝手冊

https://hub.docker.com/r/sonatype/nexus/

https://github.com/sonatype/docker-nexus

https://help.sonatype.com/repomanager3/installation/run-behind-a-reverse-proxy
```bash
bash centos8-nexus.bash

# Get default admin password
cat /home/nexus/nexus-data/admin.password
```

### SonarQube
(請先裝好 docker)
官方安裝手冊
https://docs.sonarqube.org/latest/setup/install-server/
```bash
bash centos8-sq.bash
```

#### 機本上都幫各位寫好 docker-compose.yml 了 ，目前皆在 /root 下
故 重啟服務皆用
```bash
cd /root

# 查看服務狀態
docker-compose ps -a

# 服務重啟
docker-compose restart

# 關閉服務 （非必要請不要隨意使用）
docker-compose down 
```

## Docker 相關資訊
- https://docs.docker.com/
- https://github.com/guan840912/docker-tutorial


## Docker Compose 相關資訊
- https://docs.docker.com/compose/


