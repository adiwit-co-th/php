#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on the official PHP-FPM 7.1
#####################################################

# Set the base image
FROM        php:5.6-fpm

# File Author / Maintainer
LABEL       maintainer=info@adiwit.co.th

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
                wget \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# BZ2
RUN         apt-get update \
            && apt-get install -fy \
                bzip2 \
                bzip2-doc \
                libbz2-dev \
            && docker-php-ext-install bz2 \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*
# GD
RUN         apt-get update \
            && apt-get install -fy \
                libfreetype6-dev \
                libjpeg62-turbo-dev \
                libpng12-dev \
            && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
            && docker-php-ext-install gd \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# GetText
RUN         docker-php-ext-install gettext \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# MCrypt
RUN         apt-get update \
            && apt-get install -fy \
                libmcrypt-dev \
            && docker-php-ext-install mcrypt \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# MySQL
RUN         docker-php-ext-install mysqli \
                pdo pdo_mysql \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# PostgreSQL
RUN         apt-get update \
            && apt-get install -y libpq-dev \
            && docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql \
            && docker-php-ext-install pdo pdo_pgsql pgsql \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# Redis
RUN         apt-get update \
            && apt-get install -y libhiredis-dev \
            && pecl channel-update pecl.php.net \
            && pecl install redis \
            && docker-php-ext-enable redis \
            && git clone https://github.com/nrk/phpiredis.git \
            && ( \
                cd phpiredis \
                && git checkout v1.0.0 \
                && phpize \
                && ./configure --enable-phpiredis \
                && make \
                && make install \
            ) \
            && rm -r phpiredis \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-ext-enable phpiredis \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# Zip
RUN         apt-get update \
            && apt-get install -fy \
                zip \
                unzip \
            && docker-php-ext-install zip \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# PDF
RUN         apt-get update \
            && apt-get install -fy \
                libthai0 \
                xfonts-thai \
                pdftk \
                libxrender1 \
                libfontconfig1 \
                libxtst6 \
                libx11-dev \
                libjpeg62 \
            && wget https://github.com/h4cc/wkhtmltopdf-amd64/blob/master/bin/wkhtmltopdf-amd64?raw=true -O /usr/local/bin/wkhtmltopdf \
            && chmod +x /usr/local/bin/wkhtmltopdf \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y

# Configurations
COPY        php.ini /usr/local/etc/php/php.ini

# Set working directory for BASH
WORKDIR     /var/www