#!/bin/bash    
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf remove -y docker  docker-client  docker-client-latest  docker-common docker-latest docker-latest-logrotate docker-logrotatedocker-engine
dnf install -y wget
dnf remove podman buildah containerd.io-1.2.6-3.3.fc30.x86_64 -y
#wget https://download.docker.com/linux/fedora/30/x86_64/stable/Packages/containerd.io-1.2.6-3.3.fc30.x86_64.rpm
wget https://download.docker.com/linux/centos/8/x86_64/stable/Packages/containerd.io-1.4.4-3.1.el8.x86_64.rpm
dnf install -y containerd.io-1.4.4-3.1.el8.x86_64.rpm
dnf install -y docker-ce docker-ce-cli iptables
dnf list docker-ce docker-ce-cli containerd.io


systemctl enable --now docker
systemctl status docker
exit 0