#!/bin/bash
PASSWD=$(cat /run/secrets/db_password)
PASSWD_ROOT=$(cat /run/secrets/db_root_password)
mysqld_safe &
while ! mysqladmin ping -h localhost --silent; do
    sleep 1
done

if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
	mysql << EOF
	CREATE DATABASE $MYSQL_DATABASE;
	CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$PASSWD';
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$PASSWD_ROOT';
	FLUSH PRIVILEGES;
EOF
fi
wait
