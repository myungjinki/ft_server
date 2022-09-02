FROM	debian:buster
 
MAINTAINER	JJOO <jjoo@student.42seoul.kr>

ENV DEBIAN_FRONTEND noninteractive

RUN	apt-get update && apt-get install -y --no-install-recommends apt-utils \
	nginx \
	mariadb-server \
	php-fpm \
	php-mysql \
	openssl \
	vim

COPY	srcs/default /etc/nginx/sites-available/default
COPY	srcs/config.inc.php /var/www/html/phpmyadmin/config.inc.php
COPY	srcs/wp-config.php /var/www/html/wordpress/wp-config.php
COPY	srcs/phpMyAdmin-5.0.2.tar.gz ./
COPY    srcs/wordpress-5.5.1.tar.gz ./
COPY	srcs/init.sh ./

EXPOSE	80
EXPOSE	443

CMD	bash init.sh
