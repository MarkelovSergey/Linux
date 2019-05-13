#!/bin/bash

apt update
apt upgrade -y
apt install nginx nano -y
apt install mysql-server -y
apt install php7.2-fpm php7.2-mysql -y
php conf.php
systemctl restart php7.2-fpm.service
#php unistall.php
