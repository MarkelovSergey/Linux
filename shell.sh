#!/bin/bash

apt update
apt upgrade -y
apt install nginx nano zip -y
apt install mysql-server -y
apt install php-fpm php-mysql -y
php conf.php
systemctl restart php7.2-fpm.service
php unistall.php
