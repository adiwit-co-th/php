#####################################################
# Dockerfile to deploy Laravel & Node
# Based on the official PHP
#####################################################

# Set the base image
FROM        php:latest

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
            && apt-get install --no-install-recommends -fy \
                autoconf \
                pkg-config \
                apt-utils \
                apt-transport-https \
                git \
                wget \
                openssh-client \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# Zip
RUN         apt-get update \
            && apt-get install --no-install-recommends -fy \
                zip \
                unzip \
            && docker-php-ext-install zip \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && docker-php-source delete \
            && rm -rf /var/lib/apt/lists/*

# Composers
RUN         curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# NodeJS
RUN         curl -sL https://deb.nodesource.com/setup_8.x | bash - \
            && apt-get install -y nodejs build-essential \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && rm -rf /var/lib/apt/lists/*

# Yarn
RUN         curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
            && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
            && apt-get update && apt-get install yarn \
            && apt-get autoremove -fy \
            && apt-get clean \
            && apt-get autoclean -y \
            && rm -rf /var/lib/apt/lists/*

# Configurations
COPY        php.ini /usr/local/etc/php/php.ini