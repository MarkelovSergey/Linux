#!/bin/bash

mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY '4680';"
mysql -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -e "GRANT ALL PRIVILEGES ON wordpress . * TO 'wordpressuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
systemctl restart php7.2-fpm

