#!/bin/bash
yum update -y
yum install -y nginx
echo "<h1>Hello World!</h1>" > /usr/share/nginx/html/index.html
service nginx start
