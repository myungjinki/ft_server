#!/bin/bash
mv localhost.dev.crt etc/ssl/certs/
mv localhost.dev.key etc/ssl/private/
mv default etc/nginx/sites-available/default
chmod 600 etc/ssl/certs/localhost.dev.crt etc/ssl/private/localhost.dev.key
mv phpMyAdmin-5.0.2-all-languages phpmyadmin/
mv phpmyadmin/ /var/www/html/
mv config.inc.php var/www/html/phpmyadmin/
mv wordpress/ /var/www/html/
mv wp-config.php var/www/html/wordpress/
chown -R www-data:www-data /var/www/html/wordpress
service mysql start
echo 'CREATE DATABASE IF NOT EXISTS wordpress;' | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON *.* TO 'user'@'%' IDENTIFIED BY '1111' WITH GRANT OPTION;" | mysql -u root --skip-password
service nginx start
service php7.3-fpm start
service php7.3-fpm status
bash
