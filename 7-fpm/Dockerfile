#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on the official PHP-FPM 7
#####################################################

# Set the base image
FROM        php:7.1-fpm

# File Author / Maintainer
MAINTAINER  Adiwit Co., Ltd. <info@adiwit.co.th>

# Environmental Variables
ARG         DEBIAN_FRONTEND=noninteractive

# Change System TimeZone to Asia/Bangkok
RUN         ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

# Update Repositories
RUN         apt-get update \
            && apt-get upgrade -fy \
            && apt-get dist-upgrade -fy \
            && apt-get install -fy \
                apt-utils \
                apt-transport-https \
                git \
                wget

# Memcached
RUN         apt-get install -fy \
                libmemcached-dev \
                zlib1g-dev \
            && doNotUninstall=" \
                libmemcached11 \
                libmemcachedutil2 \
            " \
            && rm -r /var/lib/apt/lists/* \
            && docker-php-source extract \
            && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached/ \
            && docker-php-ext-install memcached \
            && docker-php-source delete \
            && apt-mark manual $doNotUninstall \
            && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps
    
# Composers
RUN         curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Configurations
COPY        php.ini /usr/local/etc/php/php.ini

# Redis
RUN         pecl install redis \
            && docker-php-ext-enable redis

# CleanUps
RUN         apt-get autoremove -fy \
            && apt-get autoclean -y

# Set working directory for BASH
WORKDIR     /usr/local/etc/php/

# Dynamic Redis Environments
ADD         start.sh /usr/bin/start.sh
RUN         chmod 755 /usr/bin/start.sh
CMD         ["start.sh"]
