#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on adiwitcoth\php
#####################################################

# Set the base image
FROM        adiwitcoth/php:7-fpm-alpine

# File Author / Maintainer
MAINTAINER  Adiwit Co., Ltd. <info@adiwit.co.th>

# Update Repositories
RUN         apk add -U git \
                autoconf \
                gcc \
                g++ \
                make

# Microsoft ODBC Driver 13 for Linux
# Note: There's a copy of this tar on my hubiC
RUN         wget -nv -O msodbcsql-13.0.0.0.tar.gz \
                "https://meetsstorenew.blob.core.windows.net/contianerhd/Ubuntu%2013.0%20Tar/msodbcsql-13.0.0.0.tar.gz?st=2016-10-18T17%3A29%3A00Z&se=2022-10-19T17%3A29%3A00Z&sp=rl&sv=2015-04-05&sr=b&sig=cDwPfrouVeIQf0vi%2BnKt%2BzX8Z8caIYvRCmicDL5oknY%3D" \
            && tar -xf msodbcsql-13.0.0.0.tar.gz \
            && cd msodbcsql-*/ \
            && ldd lib64/libmsodbcsql-13.0.so.0.0 \
            && ./install.sh install --accept-license \
            && ls -l /opt/microsoft/msodbcsql/ \
            && odbcinst -q -d -n "ODBC Driver 13 for SQL Server"
            
# SQL Server
RUN         apk add unixodbc-dev \
            && pecl install sqlsrv-4.1.6.1 \
            	pdo_sqlsrv-4.1.6.1 \
			&& docker-php-ext-enable sqlsrv \
                pdo_sqlsrv

CMD         ["start.sh"]
