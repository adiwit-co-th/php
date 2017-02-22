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

# Add PHP 7 repository
# for Debian jessie
# And System upgrade
RUN         apt-get update \
            && apt-get install -fy \
                wget
RUN         echo "deb http://packages.dotdeb.org jessie all" \
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

RUN         apt-get install -y unixodbc-dev
RUN         pecl install sqlsrv-4.1.6.1 pdo_sqlsrv-4.1.6.1
RUN         docker-php-ext-enable sqlsrv \
            pdo_sqlsrv

RUN         apt-get install -fy locales \
            && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
            && locale-gen

# (1) Install PDO driver from pecl
# RUN         apt-get install -y unixodbc-dev php7.0-dev php-pear
# RUN         pecl channel-update pecl.php.net
# RUN         pecl install pdo_sqlsrv
#            && printf "; priority=20\nextension=pdo_sqlsrv.so" \
#            | tee /etc/php/7.0/mods-available/pdo_sqlsrv.ini \
#            && phpenmod pdo_sqlsrv \
#            && php --rextinfo pdo_sqlsrv \
#            && phpdismod pdo_sqlsrv \
#            && pecl uninstall pdo_sqlsrv

# (2) Or Build PDO driver with phpize
# RUN         apt-get install -y unixodbc-dev php7.1-dev \
#             && wget -nv "https://github.com/Microsoft/msphpsql/archive/PHP-7.1-Linux.tar.gz" \
#             && tar -xf PHP-7.0-Linux.tar.gz \
#             && cd msphpsql-PHP-7.0-Linux/source/ \
#             && cp -r shared/ pdo_sqlsrv/ \
#             && cd pdo_sqlsrv/ \
#             && phpize \
#             && ./configure CXXFLAGS=-std=c++11 \
#             && make \
#             && make "INSTALL=$(pwd)/build/shtool install -c --mode=0644" install \
#             && printf "; priority=20\nextension=pdo_sqlsrv.so" \
#                 | tee /etc/php/7.0/mods-available/pdo_sqlsrv.ini \
#             && phpenmod pdo_sqlsrv \
#             && php --rextinfo pdo_sqlsrv \
#             && phpdismod pdo_sqlsrv \
#             && rm -f /usr/lib/php/20151012/pdo_sqlsrv.so
# 
# (3) Or Download precompiled pdo_sqlsrv extension binaries
# RUN         apt-get install -y php7.0-cli \
#             && wget -nv "https://github.com/Microsoft/msphpsql/releases/download/4.0.8-Linux/Ubuntu15.tar" \
#             && tar -xf Ubuntu15.tar \
#             && cp -v ./Ubuntu15/php_pdo_sqlsrv_7_nts.so /usr/lib/php/20151012/pdo_sqlsrv.so \
#             && printf "; priority=20\nextension=pdo_sqlsrv.so" \
#                 | tee /etc/php/7.0/mods-available/pdo_sqlsrv.ini \
#             && phpenmod pdo_sqlsrv \
#             && php --rextinfo pdo_sqlsrv \
#             && phpdismod pdo_sqlsrv \
#             && rm -f /usr/lib/php/20151012/pdo_sqlsrv.so

CMD         ["start.sh"]