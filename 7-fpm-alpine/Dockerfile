#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on the official PHP-FPM 7
#####################################################

# Set the base image
FROM        php:7.1-fpm-alpine

# File Author / Maintainer
MAINTAINER  Adiwit Co., Ltd. <info@adiwit.co.th>

# Change System TimeZone to Asia/Bangkok
RUN         apk add -U tzdata
RUN         cp /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

# Update Repositories
RUN         apk add -U \
                git \
                autoconf \
                gcc \
                g++ \
                make \
                wget

# xDebug
RUN         pecl install xdebug \
                && docker-php-ext-enable xdebug

# Composers
RUN         apk add openssl \
                curl \
            && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Memcached
RUN         apk add cyrus-sasl-dev \
                libmemcached-dev \
                zlib-dev \
            && docker-php-source extract \
            && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached/ \
            && docker-php-ext-install memcached \
            && docker-php-source delete

# Redis
RUN         pecl install redis \
                && docker-php-ext-enable redis

# GD
RUN         apk add freetype-dev \
libjpeg-turbo-dev \
libpng-dev \
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-install gd

# Configurations
COPY        php.ini /usr/local/etc/php/php.ini

# CleanUps
RUN         rm -rf /tmp/* /var/cache/apk/* \
            && docker-php-source delete

# Set working directory for BASH
WORKDIR     /usr/local/etc/php/

# Dynamic Redis Environments
ADD         start.sh /usr/bin/start.sh
RUN         chmod 755 /usr/bin/start.sh
CMD         ["start.sh"]
