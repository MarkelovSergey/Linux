#!/bin/bash

mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY '4680';"
mysql -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -e "GRANT ALL PRIVILEGES ON wordpress . * TO 'wordpressuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip -y
systemctl restart php7.2-fpm

mv default /etc/nginx/sites-available/default
systemctl restart nginx

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

useradd -d /var/www/html wpuser -p 4680
usermod -aG www-data wpuser
chown -R wpuser:www-data /var/www
chown -R wpuser:www-data /var/lib/nginx
chown -R wpuser:www-data /var/log/nginx
chown -R wpuser:www-data /var/lib/php/sessions
php conf.php

service php7.2-fpm restart
service nginx restart

cd /var/www/html
su - wpuser -c "wp core download --locale=ru_RU"
su - wpuser -c "wp config create --dbname=wordpress --dbuser=wordpressuser --dbpass=4680 --locale=ru_RU"
su - wpuser -c "wp core install --url=example.com --title=Example --admin_user=root --admin_password=4680 --admin_email=kerzhakov.08@mail.ru"
su - wpuser -c "wp plugin uninstall hello akismet"

#passwd wpuser
