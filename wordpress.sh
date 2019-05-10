#!/bin/bash

mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY '4680';"
mysql -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -e "GRANT ALL PRIVILEGES ON wordpress . * TO 'wordpressuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip -y
systemctl restart php7.2-fpm

mv ./wordpress/default /etc/nginx/sites-available/default
systemctl restart nginx

wget https://ru.wordpress.org/latest-ru_RU.tar.gz
tar xzvf latest-ru_RU.tar.gz

rm -r /var/www/html/
mv wordpress html
mv html /var/www

chown -R www-data:www-data /var/www/html
