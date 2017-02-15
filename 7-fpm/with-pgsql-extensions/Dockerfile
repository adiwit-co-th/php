#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on adiwitcoth\php
#####################################################

# Set the base image
FROM 		adiwitcoth/php:7.1-fpm

# File Author / Maintainer
MAINTAINER 	Adiwit Co., Ltd. <info@adiwit.co.th>

# Environmental Variables
ARG 		DEBIAN_FRONTEND=noninteractive

# Update Repositories
RUN 		apt-get update

# PostgreSQL
RUN 		apt-get install -fy \
				libpq-dev \
    		&& docker-php-ext-install pdo_pgsql

CMD         ["start.sh"]