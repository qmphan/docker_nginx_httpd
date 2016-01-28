FROM centos

MAINTAINER Minh Phan <mphan@wengo.com>

RUN yum -y update
RUN yum install -y yum-utils
RUN yum install -y epel-release
RUN yum-config-manager --enable cr
########

RUN yum install -y nginx supervisor git php-cli php-fpm php-pgsql php-mysql php-xmlwriter php-mbstring nodejs

#----------------- NGINX configuration ----------------
RUN rm /etc/nginx/nginx.conf
ADD nginx/nginx.conf /etc/nginx/
ADD nginx/app.conf /etc/nginx/conf.d/
ADD nginx/fastcgi_params /etc/nginx/
ADD supervisord.conf /etc/supervisord.d/

#---------- NGINX user setup -------------
RUN mkdir /home/nginx
RUN chown nginx:nginx /home/nginx
RUN usermod -u 1000 -s /bin/bash nginx -d /home/nginx

RUN rm /etc/php-fpm.d/www.conf

ADD fpm/app.ini /etc/php-fpm.d/
ADD fpm/app.ini /etc/php.d/
ADD fpm/app.pool.conf /etc/php-fpm.d/

#--------------- Add test running scripts ---------------------------
ADD commands/setup_env.sh /commands/setup_env.sh
ADD commands/symfony_test.sh /commands/symfony_test.sh

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.d/supervisord.conf"]

EXPOSE 80
EXPOSE 443
