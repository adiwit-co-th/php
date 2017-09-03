#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on the official PHP-FPM 7.1
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
                autoconf \
                pkg-config \
                apt-utils \
                apt-transport-https \
                git \
                nano \
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
            
# Memcached
RUN         apt-get update \
            && apt-get install -fy \
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
            && apt-mark manual $doNotUninstall \
            && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
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

# SQL Server
ENV         ACCEPT_EULA=Y
RUN         sed -i "s/jessie/stretch/g" /etc/apt/sources.list \
            && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
            && curl https://packages.microsoft.com/config/ubuntu/16.04/prod.list > /etc/apt/sources.list.d/mssql.list \
            && apt-get update \
            && apt-get install --no-install-recommends -y \
                unixodbc \
                odbcinst1debian2 \
                unixodbc-dev \
                locales \
                msodbcsql \
                mssql-tools \
            && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
            && locale-gen \
            && pecl install sqlsrv-4.1.6.1 \
            && pecl install pdo_sqlsrv-4.1.6.1 \
            && docker-php-ext-enable \
                sqlsrv \
                pdo_sqlsrv \
            && sed -i "s/stretch/jessie/g" /etc/apt/sources.list \
            && apt-get update \
            && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
            && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
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