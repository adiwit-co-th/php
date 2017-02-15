#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on adiwitcoth\php
#####################################################

# Set the base image
FROM 		adiwitcoth/php:7.1-fpm-alpine

# File Author / Maintainer
MAINTAINER 	Adiwit Co., Ltd. <info@adiwit.co.th>

# Change System TimeZone to Asia/Bangkok
RUN         apk add -U tzdata
RUN         cp /usr/share/zoneinfo/Asia/Bangkok /etc/localtime

# PostgreSQL
RUN 		apk add -U postgresql-dev \
    		&& docker-php-ext-install pdo_pgsql

CMD         ["start.sh"]