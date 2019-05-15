#!/bin/bash

redis=false
while [ -n "$1" ]
do
case "$1" in
-redis) redis=true ;;
esac
shift
done

#Создание базы и пользователя
mysql -e "CREATE USER 'wordpressuser'@'localhost' IDENTIFIED BY '4680';"
mysql -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -e "GRANT ALL PRIVILEGES ON wordpress . * TO 'wordpressuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

#Установка дополнительных пакетов
apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip -y

#Замена файла конфинурации Nginx
mv default /etc/nginx/sites-available/default

#установка wp-cli
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

#настройка прав
useradd -d /var/www/html wpuser -p 4680
usermod -aG www-data wpuser
chown -R wpuser:www-data /var/www
chown -R wpuser:www-data /var/lib/nginx
chown -R wpuser:www-data /var/log/nginx
chown -R wpuser:www-data /var/lib/php/sessions

#меняет юзера для nginx, php-fpm
sed -i 's/.*user www-data;.*/user wpuser;/' /etc/nginx/nginx.conf
sed -i 's/.*user = www-data.*/user = wpuser/' /etc/php/7.2/fpm/pool.d/www.conf

service php7.2-fpm restart
service nginx restart

#wp-cli устанавливает wordpress, отключает дефолтные плагины
cd /var/www/html
su - wpuser -c "wp core download --locale=ru_RU"
su - wpuser -c "wp config create --dbname=wordpress --dbuser=wordpressuser --dbpass=4680 --locale=ru_RU"
su - wpuser -c "wp core install --url=example.com --title=Example --admin_user=root --admin_password=4680 --admin_email=kerzhakov.08@mail.ru"
su - wpuser -c "wp plugin uninstall hello akismet"
nan
if $redis; then
        apt install redis-server php-redis -y
        systemctl start redis.service
        systemctl enable redis.service

        cd /var/www/html
        su - wpuser -c "wp plugin install redis-cache"
        su - wpuser -c "wp plugin activate redis-cache"
        su - wpuser -c "wp redis enable"
fi

#passwd wpuser
