#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on adiwitcoth\php
#####################################################

# Set the base image
FROM 		adiwitcoth/php:7-fpm-alpine

# File Author / Maintainer
MAINTAINER 	Adiwit Co., Ltd. <info@adiwit.co.th>

# PostgreSQL
RUN 		apk add -U postgresql-dev \
    		&& docker-php-ext-install pdo_pgsql \
        && docker-php-source delete

CMD         ["start.sh"]
