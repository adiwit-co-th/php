#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on adiwitcoth\php
#####################################################

# Set the base image
FROM        adiwitcoth/php:7.1-fpm

# File Author / Maintainer
MAINTAINER  Adiwit Co., Ltd. <info@adiwit.co.th>

# Environmental Variables
ARG         DEBIAN_FRONTEND=noninteractive

# Update Repositories
RUN         apt-get update

# BZ2
RUN         apt-get install -fy \
                bzip2 \
                bzip2-doc \
                libbz2-dev \
            && docker-php-ext-install bz2

# GD
RUN         apt-get install -fy \
                libfreetype6-dev \
                libjpeg62-turbo-dev \
                libpng12-dev \
            && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
            && docker-php-ext-install gd

# GetText
RUN         docker-php-ext-install gettext

# MCrypt
RUN         apt-get install -fy \
                libmcrypt-dev \
            && docker-php-ext-install mcrypt

# MySQL
RUN         docker-php-ext-install mysqli \
                pdo_mysql

# Zip
RUN         docker-php-ext-install zip

CMD         ["start.sh"]