#####################################################
# Dockerfile to customeize PHP for Laravel project
# Based on adiwitcoth\php
# https://github.com/Microsoft/msphpsql/wiki/Dockerfile-for-getting-pdo_sqlsrv-for-PHP-7.0-on-Debian-in-3-ways
#####################################################

# Set the base image
FROM        adiwitcoth/php:7-fpm

# File Author / Maintainer
MAINTAINER  Adiwit Co., Ltd. <info@adiwit.co.th>

# Environmental Variables
VOLUME      ["/opt/results"]
ARG         DEBIAN_FRONTEND=noninteractive

# Add PHP 7 repository for Debian jessie and System upgrade
RUN         echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
            && echo "deb http://packages.dotdeb.org jessie all" \
                | tee /etc/apt/sources.list.d/dotdeb.list \
            && wget -qO- https://www.dotdeb.org/dotdeb.gpg \
                | apt-key add - \
            && apt-get update \
            && apt-get upgrade -qq

# Install UnixODBC
# Compile odbc_config as it is not part of unixodbc package
RUN         apt-get install -y whiptail \
                unixodbc libgss3 odbcinst devscripts debhelper dh-exec dh-autoreconf libreadline-dev libltdl-dev \
            && dget -u -x http://http.debian.net/debian/pool/main/u/unixodbc/unixodbc_2.3.1-3.dsc \
            && cd unixodbc-*/ \
            && dpkg-buildpackage -uc -us -B \
            && cp -v ./exe/odbc_config /usr/local/bin/

# Fake uname for install.sh
RUN         printf '#!/bin/bash\nif [ "$*" == "-p" ]; then echo "x86_64"; else /bin/uname "$@"; fi' \
                | tee /usr/local/bin/uname \
            && chmod +x /usr/local/bin/uname

# Microsoft ODBC Driver 13 for Linux
RUN         wget -nv -O msodbcsql-13.0.0.0.tar.gz \
                "https://meetsstorenew.blob.core.windows.net/contianerhd/Ubuntu%2013.0%20Tar/msodbcsql-13.0.0.0.tar.gz?st=2016-10-18T17%3A29%3A00Z&se=2022-10-19T17%3A29%3A00Z&sp=rl&sv=2015-04-05&sr=b&sig=cDwPfrouVeIQf0vi%2BnKt%2BzX8Z8caIYvRCmicDL5oknY%3D" \
            && tar -xf msodbcsql-13.0.0.0.tar.gz \
            && cd msodbcsql-*/ \
            && ldd lib64/libmsodbcsql-13.0.so.0.0 \
            && ./install.sh install --accept-license \
            && ls -l /opt/microsoft/msodbcsql/ \
            && odbcinst -q -d -n "ODBC Driver 13 for SQL Server"

RUN         apt-get install -y \
                unixodbc-dev \
                locales \
            && locale-gen \
            && pecl install sqlsrv-4.1.6.1 pdo_sqlsrv-4.1.6.1 \
            && docker-php-ext-enable sqlsrv \
                pdo_sqlsrv \
            && apt-get install -fy

CMD         ["start.sh"]