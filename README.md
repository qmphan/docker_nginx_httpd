Docker containers for Nginx server
======================================================

This Docker container run an instance of Nginx web server with php-fpm. It is preconfigured to serve multiple website. Follow these steps to have your web server setup quickly for multiple web sites:

1. Create a base directory for all your web site. For example /home/webmaster/www
2. Inside /home/webmaster/www, place the source code for your different web site. The folder name should be the domain name. For domains that begins with 'www.', do not include 'www.' in the directory name. For example, for domain www.example.com, place the source in /home/webmaster/www/example.com
3. Create a symbolic link 'wwwroot' inside /home/webmaster/www/example.com that point to the web root directory. It can be the example.com directory itself. Eg: ln -s . wwwroot
4. Checkout the source code of thi project into <nginx-docker-src> directory.
5. Build docker image (You can skip this step and use image on docker hub instead): Build the docker with command: docker build -t mphan/nginx_httpd src
5. Update docker-compose.yml if the directory crreated at step 1 is not /home/webmaster/www.
6. Install docker-compose if it is not yet installed on your server (cf https://docs.docker.com/compose/install/)
7. Start the container with the commande:  docker-compose up -d
8. Update DNS server for your domain to point to your server.
9. Goto www.example.com and see your website (or not).

NOTE: You need to make sure to have a database server setup if your website need one.
