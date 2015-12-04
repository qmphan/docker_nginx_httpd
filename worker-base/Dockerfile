FROM centos

MAINTAINER Minh Phan <mphan@wengo.com>

RUN yum -y update 
RUN yum install -y epel-release
########

RUN yum install -y nginx supervisor git postgresql-server php-cli php-fpm php-pgsql php-xmlwriter php-mbstring

#----------------- NGINX configuration ----------------
RUN rm /etc/nginx/nginx.conf
ADD nginx/nginx.conf /etc/nginx/
ADD nginx/app.conf /etc/nginx/conf.d/
ADD nginx/upstream.conf /etc/nginx/conf.d/upstream.conf
ADD nginx/fastcgi_params /etc/nginx/
ADD supervisord.conf /etc/supervisord.d/

#---------- Postgresql installation and configuration -------------
USER postgres
RUN /usr/bin/initdb -D /var/lib/pgsql/data -U postgres
ADD postgres/postgres.conf /var/lib/pgsql/data/postgresql.conf
ADD postgres/pg_hba.conf /var/lib/pgsql/data/pg_hba.conf
#-------------------------------------------------------------------

USER root

#--------------- Add test running scripts ---------------------------
ADD commands/setup_env.sh /commands/setup_env.sh
ADD commands/symfony_test.sh /commands/symfony_test.sh

#---------- NGINX user setup -------------
RUN mkdir /home/nginx
RUN chown nginx:nginx /home/nginx
RUN usermod -u 1000 -s /bin/bash nginx -d /home/nginx

#------- PHP UNIT ------#
RUN curl -O https://phar.phpunit.de/phpunit-old.phar
RUN chmod +x phpunit-old.phar
RUN mv phpunit-old.phar /usr/local/bin/phpunit

RUN rm /etc/php-fpm.d/www.conf

ADD fpm/app.ini /etc/php-fpm.d/
ADD fpm/app.ini /etc/php.d/
ADD fpm/app.pool.conf /etc/php-fpm.d/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.d/supervisord.conf"]

EXPOSE 80
EXPOSE 443
EXPOSE 5432
