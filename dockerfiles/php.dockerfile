FROM php:8.2-fpm-alpine

WORKDIR /var/www/html

RUN docker-php-ext-install pdo pdo_mysql mysqli

RUN echo 'memory_limit = 256M' >> /usr/local/etc/php/conf.d/docker-php-memlimit.ini;

RUN apk add --no-cache linux-headers \
	&& apk add --update --no-cache --virtual .build-dependencies $PHPIZE_DEPS\
	&& pecl install xdebug \
	&& docker-php-ext-enable xdebug \
	&& pecl clear-cache \
	&& apk del .build-dependencies
