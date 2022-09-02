#!/bin/bash

service mysql start

# SSL
openssl req -newkey rsa:4096 -nodes -x509 \
    -keyout localhost.dev.key -out localhost.dev.crt \
    -days 365 -subj "/C=KR/ST=Seoul/L=Gangnam/O=42Seoul/OU=jjoo/CN=localhost"

mv localhost.dev.crt etc/ssl/certs/
mv localhost.dev.key etc/ssl/private/
chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key

# Install phpMyAdmin
tar -xvf phpMyAdmin-5.0.2.tar.gz
mv phpMyAdmin-5.0.2-all-languages phpmyadmin
mv phpmyadmin/* /var/www/html/phpmyadmin/
rm phpMyAdmin-5.0.2.tar.gz
rm -rf /phpmyadmin

# Authorization 
cd /var/www/html
chown -R root:root  phpmyadmin
chmod -R 707 phpmyadmin
cd phpmyadmin
chmod 705 config.inc.php
cd /

# Config MYSQL
echo "CREATE DATABASE IF NOT EXISTS wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# Wordpress
tar -xvf wordpress-5.5.1.tar.gz
mv wordpress/* /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress
rm wordpress-5.5.1.tar.gz

service php7.3-fpm start
service nginx start

bash
