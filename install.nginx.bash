#!/bin/bash

# https://www.cyberciti.biz/faq/how-to-install-and-use-nginx-on-centos-8/
# https://docs.nginx.com/nginx/admin-guide/basic-functionality/runtime-control/
sudo setenforce 0
getenforce

dnf install nginx -y 
exit 0
# test nginx config
# nginx -t

# reload nginx config
# nginx -s reload