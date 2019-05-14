apt install redis-server php-redis -y
systemctl start redis.service
systemctl enable redis.service

cd /var/www/html
su - wpuser -c "wp plugin install redis-cache"
su - wpuser -c "wp plugin activate redis-cache"
su - wpuser -c "wp redis enable"
