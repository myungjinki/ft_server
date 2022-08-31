FROM	debian:buster
RUN		apt-get update;\
		apt-get -y upgrade;\
		apt-get -y install nginx\
		openssl\
		vim\
		php7.3-fpm\
		mariadb-server\
		php-mysql\
		wget
RUN		wget https://wordpress.org/latest.tar.gz;\
		wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz;\
		tar -xvf phpMyAdmin-5.0.2-all-languages.tar.gz;\
		tar -xvf latest.tar.gz
RUN		openssl req -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=KR/ST=Seoul/L=Seoul/O=42Seoul/OU=mki/CN=localhost" -keyout localhost.dev.key -out localhost.dev.crt	
COPY	/srcs/run.sh /
COPY	/srcs/default /
COPY	/srcs/config.inc.php /
COPY	/srcs/wp-config.php /
CMD		bash run.sh
EXPOSE	80 443
