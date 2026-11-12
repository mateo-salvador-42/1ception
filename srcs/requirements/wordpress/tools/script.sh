#!/bin/bash
while ! mysqladmin ping -h mariadb --silent; do
	sleep 1
done
if [ ! -f /var/www/html/wp-config.php ]; then
	wp core download --path=/var/www/html --allow-root
fi
DB_PASSWORD=$(cat /run/secrets/db_password)
USER_PASS=$(cat /run/secrets/wp_password)
wp config create --path=/var/www/html --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --allow-root
wp core install --path=/var/www/html --title=Inception --admin_user=masalvad --admin_password=$WP_ROOT_PASSWORD --url=$DOMAIN_NAME --admin_email="mateo.salvador@learner.42.tech" --allow-root
wp user --path=/var/www/html create visiteur "salvador.mateo205@gmail.com" --role=subscriber --user_pass=$USER_PASS --allow-root
php-fpm8.2 -F -R
