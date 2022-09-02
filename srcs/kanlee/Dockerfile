# to create image using this dockerfile, run:
# docker build -t ftserver .

# to change SQL password, add an option:
#	--build-arg SQL_PWD=xxxxx 

# to create and start container, run:
# docker run -d -p 80:80 -p 443:443 --name aaa ftserver

# to disable autoindex, run:
# docker run -d -p 80:80 -p 443:443 --name aaa -e autoindex=off ftserver

FROM debian:buster
MAINTAINER kanlee

ARG SQL_PWD=admin
ENV autoindex=on

# install nginx, php, mariadb and additional tools
RUN apt-get update && \
		apt-get install -y vim && \
		apt-get install -y nginx && \
		apt-get install -y php-fpm && \
		apt-get install -y mariadb-server && \
		apt-get install -y php-mysql && \
		apt-get install -y wget


# setting nginx
COPY ./srcs/nginx_template /etc/nginx/sites-available/default
RUN sed -i "s/%PHP_FPM%/$(find /etc/init.d -name 'php*' -printf '%f')/" /etc/nginx/sites-available/default && \
		openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=Test/CN=ftserver" -keyout /etc/nginx/common.key -out /etc/nginx/common.crt && \
		rm -f /var/www/html/index*

WORKDIR /var/www/html

# install phpmyadmin
RUN wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz &&\
		mkdir phpmyadmin && \
		tar -xvf phpMyAdmin-latest-all-languages.tar.gz -C ./phpmyadmin --strip-components=1 && \
		rm -f phpMyAdmin-latest-all-languages.tar.gz

# install wordpress
RUN wget -O wordpress-latest.tar.gz https://wordpress.org/latest.tar.gz && \
		mkdir wordpress && \
		tar -xvf wordpress-latest.tar.gz -C ./wordpress --strip-components=1 && \
		rm -f wordpress-latest.tar.gz && \
		cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php && \
		sed -i "s/database_name_here/wordpress/" wordpress/wp-config.php && \
		sed -i "s/username_here/admin/" wordpress/wp-config.php && \
		sed -i "s/password_here/$SQL_PWD/" wordpress/wp-config.php

# create sql user and set wordpress db
RUN service mysql start && \
		mysql -u root -e "CREATE USER 'admin'@'localhost' identified by '$SQL_PWD';" && \
		mysql -u root -e "GRANT ALL on *.* to 'admin'@'localhost' identified by '$SQL_PWD';" && \
		mysql -u admin -p$SQL_PWD -e "CREATE DATABASE IF NOT EXISTS wordpress;"

COPY ./srcs/index.html /var/www/html/test.html

EXPOSE 80 443

CMD sed -i "s/%autoindex%/$autoindex/" /etc/nginx/sites-available/default && \
		service mysql start && \
		service $(find /etc/init.d -name 'php*' -printf '%f') start && \
		nginx -g "daemon off;"
