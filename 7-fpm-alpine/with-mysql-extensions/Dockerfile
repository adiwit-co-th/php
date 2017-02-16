#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on adiwitcoth\php
#####################################################

# Set the base image
FROM        adiwitcoth/php:7.1-fpm-alpine

# File Author / Maintainer
MAINTAINER  Adiwit Co., Ltd. <info@adiwit.co.th>

# Update Repositories
RUN         apk add -U git \
                autoconf \
                gcc \
                g++ \
                make

# BZ2
RUN         apk add bzip2-dev \
            && docker-php-ext-install bz2

# GD
RUN         apk add freetype-dev \
                libjpeg-turbo-dev \
                libpng-dev \
            && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
            && docker-php-ext-install gd

# GetText
RUN         apk add gettext-dev \
            && docker-php-ext-install gettext

# MCrypt
RUN         apk add libmcrypt-dev \
            && docker-php-ext-install mcrypt

# MySQL
RUN         docker-php-ext-install mysqli \
                pdo_mysql

# Zip
RUN         docker-php-ext-install zip

CMD         ["start.sh"]
