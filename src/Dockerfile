FROM centos:7

MAINTAINER Minh Phan <mphan@wengo.com>

RUN yum -y update
RUN yum install -y yum-utils
RUN yum install -y epel-release
RUN yum-config-manager --enable cr
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
########

RUN yum install -y nginx supervisor git postgresql-server php56w-cli php56w-fpm php56w-pgsql php56w-xmlwriter php56w-mbstring php56w-intl nodejs which

#----------------- Install Node.js by using nvm ----------------------------
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.13.1/install.sh | bash
RUN source /root/.bash_profile; nvm install v4.2.6; nvm alias default v4.2.6; n=$(which node);n=${n%/bin/node}; chmod -R 755 $n/bin/*; cp -r $n/{bin,lib,share} /usr/local  # Install node globally
RUN npm install protractor gulpjs/gulp-cli#4.0 tsd -g

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

#---------- NGINX user setup -------------
RUN mkdir /home/nginx
RUN chown nginx:nginx /home/nginx
RUN usermod -u 1000 -s /bin/bash nginx -d /home/nginx

#------- PHP UNIT ------#
RUN curl -O https://phar.phpunit.de/phpunit.phar
RUN chmod +x phpunit.phar
RUN mv phpunit.phar /usr/local/bin/phpunit

RUN rm /etc/php-fpm.d/www.conf

ADD php/php.ini /etc/php/
ADD fpm/app.ini /etc/php-fpm.d/
ADD fpm/app.ini /etc/php.d/
ADD fpm/app.pool.conf /etc/php-fpm.d/

#--------------- Add test running scripts ---------------------------

USER nginx
ADD commands /commands
ADD composer/auth.json /home/nginx/.composer/auth.json

USER root

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.d/supervisord.conf"]

EXPOSE 80
EXPOSE 443
EXPOSE 5432
