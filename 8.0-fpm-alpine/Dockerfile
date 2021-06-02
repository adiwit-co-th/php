#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on the official PHP-FPM 8.0
#####################################################

# Set the base image
FROM        php:8.0-fpm-alpine

# File Author / Maintainer
LABEL       maintainer=info@adiwit.co.th

# Change System TimeZone to Asia/Bangkok
RUN         apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/Asia/Bangkok /etc/localtime \
    && echo "Asia/Bangkok" > /etc/timezone \
    && apk del tzdata

# BZ2
RUN         apk add --no-cache bzip2-dev \
    && docker-php-ext-install bz2

# GD
RUN         apk add --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
    && docker-php-ext-configure gd --with-jpeg=/usr/include --with-freetype=/usr/include/freetype2 \
    && docker-php-ext-install gd

# GetText
RUN         apk add --no-cache \
        icu-dev \
        gettext \
        gettext-dev \
    && docker-php-ext-install gettext

# MCrypt
RUN         apk add --no-cache libmcrypt-dev ${PHPIZE_DEPS} \
    && pecl install mcrypt \
    && docker-php-ext-enable mcrypt \
    && apk del ${PHPIZE_DEPS}

# Memcached
# RUN         apk add --no-cache libmemcached-dev ${PHPIZE_DEPS} \
#     && pecl install memcached \
#     && docker-php-ext-enable memcached \
#     && apk del ${PHPIZE_DEPS}

# MySQL
RUN         docker-php-ext-install mysqli pdo pdo_mysql

# PostgreSQL
RUN         apk add --no-cache postgresql-dev \
    && docker-php-ext-install pdo pdo_pgsql pgsql

# Redis
RUN         apk add --no-cache ${PHPIZE_DEPS} \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && apk del ${PHPIZE_DEPS}

# SQL Server
# RUN         apk add --no-cache unixodbc-dev ${PHPIZE_DEPS} \
#     && pecl install sqlsrv pdo_sqlsrv \
#     && docker-php-ext-enable sqlsrv pdo_sqlsrv \
#     && apk del ${PHPIZE_DEPS}

# Zip
RUN         docker-php-ext-install zip

# PDF
# RUN         apk add --no-cache libx11-dev \
#     && wget https://github.com/h4cc/wkhtmltopdf-amd64/blob/master/bin/wkhtmltopdf-amd64?raw=true --no-verbose -O /usr/local/bin/wkhtmltopdf \
#     && chmod +x /usr/local/bin/wkhtmltopdf

# IMAP
RUN         apk add --no-cache imap-dev ${PHPIZE_DEPS} \
        # krb5 krb5-libs \
    && docker-php-ext-configure imap --with-imap-ssl \
#     && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && apk del ${PHPIZE_DEPS}

# BCMATH
RUN         docker-php-ext-install bcmath

# ActiveDirectory / LDAP
# RUN         apk add --no-cache ldb-dev libldap openldap-dev \
#     && docker-php-ext-install ldap
#     && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \

# Graphviz
RUN         apk add --no-cache graphviz

# Calendar
RUN         docker-php-ext-install calendar

# Intl
RUN         docker-php-ext-install intl

# EXIF
RUN         docker-php-ext-install exif

# IGBINARY
RUN         apk add --no-cache ${PHPIZE_DEPS} \
    && pecl install --onlyreqdeps --force igbinary \
    && docker-php-ext-enable igbinary \
    && apk del ${PHPIZE_DEPS}

# XDEBUG - can cause Composer to take minutes even when running a command as simple as composer --version
# RUN         apk add --no-cache ${PHPIZE_DEPS} \
#     && pecl install xdebug \
#     && docker-php-ext-enable xdebug \
#     && apk del ${PHPIZE_DEPS}

# SSH
RUN         apk add --no-cache openssh-client

# Composer
RUN         apk add --no-cache git \
    && wget https://getcomposer.org/installer -O - -q | php -- --no-ansi --install-dir=/usr/bin --filename=composer \
    && composer config --global repo.packagist composer https://packagist.org \
    # && composer global require laravel/installer \
    # && composer global require phpunit/phpunit \
    # && composer global require squizlabs/php_codesniffer \
    # && composer global require beyondcode/laravel-self-diagnosis dev-master \
    # && composer global require beyondcode/laravel-er-diagram-generator dev-master --ignore-platform-reqs \
    && export PATH="~/.composer/vendor/bin:$PATH" \
    && mkdir -p /root/.ssh \
    && echo "StrictHostKeyChecking no" > /root/.ssh/config

# Configurations
COPY        php.ini /usr/local/etc/php/php.ini
COPY        zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf