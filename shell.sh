#!/bin/bash

apt update
apt upgrade -y
apt install nano nginx mysql-server php7.2-fpm php7.2-mysql -y
sed -i 's/.*;cgi.fix_pathinfo=1.*/cgi.fix_pathinfo=0/' /etc/php/7.2/fpm/php.ini
systemctl restart php7.2-fpm.service
