FROM	debian:buster
LABEL	maintainer="dsohn@student.42seoul.kr"
RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get -y install nginx curl
RUN apt-get -y install php7.3-fpm
RUN apt-get -y install mariadb-server php-mysql php-mbstring
RUN apt-get -y install wget

EXPOSE 80 443

COPY ./srcs/default ./
COPY ./srcs/wp-config.php ./
COPY ./srcs/config-inc.php ./
COPY ./srcs/setting.sh ./

CMD bash setting.sh