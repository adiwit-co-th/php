#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on the official PHP-FPM 5.6
#####################################################

# Set the base image
FROM        php:5.6-fpm

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
                autoconf \
                pkg-config \
                apt-utils \
                apt-transport-https \
                git \
                nano \
                wget

# BZ2
RUN         apt-get update \
            && apt-get install -fy \
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

# Memcached - 2.2.0 is the last version supporting PHP 5.6
RUN         apt-get update \
            && apt-get install -fy \
                libmemcached-dev \
                zlib1g-dev \
            && doNotUninstall=" \
                libmemcached11 \
                libmemcachedutil2 \
            " \
            && pecl install memcached-2.2.0 \
            && docker-php-ext-enable memcached

# MySQL
RUN         docker-php-ext-install mysqli \
                pdo_mysql

# PostgreSQL
RUN 		    apt-get update \
            && apt-get install -fy \
                libpq-dev \
            && docker-php-ext-install pdo_pgsql

# Redis
RUN         pecl channel-update pecl.php.net \
            && pecl install redis \
            && docker-php-ext-enable redis

# SQL Server - not supported on Linux PHP 5.6
#RUN         apt-get install -fy freetds-dev \
#            && docker-php-ext-configure pdo_odbc --with-mssql --with-pdo-odbc=generic \
#            && docker-php-ext-install pdo_odbc \
#            && docker-php-ext-enable pdo_odbc
#            #mssql

# Zip
RUN         docker-php-ext-install zip

# PDF
RUN         apt-get install -fy \
                libthai0 \
                xfonts-thai \
                pdftk

# CleanUps
RUN         apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# Configurations
COPY        php.ini /usr/local/etc/php/php.ini

# Set working directory for BASH
WORKDIR     /var/www
