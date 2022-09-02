# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: seoh <seoh@student.42seoul.kr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/10/04 00:31:57 by seoh              #+#    #+#              #
#    Updated: 2020/10/04 03:38:56 by seoh             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

LABEL MAINTAINER "seoh<seoh@student.42seoul.kr>"

ENV	AUTOINDEX on

# 필요한 프로그램 설치
RUN apt-get update 
RUN apt-get install -y nginx \
	vim \
	php-fpm \
	mariadb-server \
	php-mysql \
	wget

# nginx 기본 설정 파일 복사 (redirect, autoindex 설정)
COPY ./srcs/default ./etc/nginx/sites-available/default

# Phpmyadmin 설치 (패스워드 없이 root 로그인 가능한 설정 파일 복사)
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz; \
	tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz; \
	mv phpMyAdmin-5.0.2-all-languages phpmyadmin; \
	mv phpmyadmin /var/www/html/
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin

# WordPress 설치
RUN wget https://wordpress.org/latest.tar.gz; \
	tar -xvf latest.tar.gz; \
	mv wordpress /var/www/html/; \
	rm -rf latest.tar.gz; \
	chown -R www-data:www-data /var/www/html/wordpress
COPY ./srcs/wp-config.php /var/www/html/wordpress

# SSL 발급 및 설정 (mkcert - openssl은 잘 안 됨)
RUN mkdir ~/mkcert && cd ~/mkcert && \
	wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-amd64 && \
	mv mkcert-v1.4.1-linux-amd64 mkcert && chmod +x mkcert && \
	./mkcert -install && ./mkcert localhost

# DB 생성 (패스워드 없이)
RUN service mysql start && \
	echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password && \
	echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password && \
	echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password && \
	echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# 서비스 시작
CMD service nginx start && \
	service mysql start && \
	service php7.3-fpm start && \
	/bin/bash


#### DOCKER 명령어 모음 (from wpark 님 정리본)
#
# 1. download image from dockerhub
# docker pull debian:buster
#
# 2. see docker process
# docker ps (-a)
#
# 3. see images
# docker images
#
# 4. see containers
# docker contianer ls -a
# 
# 5. build another image using Dockerfile
# docker build --tag (tag_name) (Dockefile_path) 
#
# 6. create container by image
# docker create (image_name)
#
# 7. execute container
# docker start (container_name)
#
# 8. stop container
# docker stop (container_name)
#
# 9. enter into container
# docker attatch (container_name)
#
# 10.make container && execute container
# docker run --rm -it (image or container name)
#
# 11.communicate container <-> host 
# docker cp [host file path] [container name]:[container file path]
# docker cp [container name]:[container file path] [host file path]