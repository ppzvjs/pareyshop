FROM nginx:stable-alpine
WORKDIR /etc/nginx/conf.d
COPY ./nginx/conf/nginx.conf .
RUN mv nginx.conf default.conf
COPY ./nginx/ssl/localhost.crt  /etc/nginx/ssl/certs/localhost.crt
COPY ./nginx/ssl/localhost.key  /etc/nginx/ssl/private/localhost.key
#RUN ln -s /opt/wpthemes/om /var/www/html/wp-content/themes/MB-Template
WORKDIR /var/www/html
#COPY ../src .