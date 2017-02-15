#!/bin/sh
# Enable Redis, if provided as environments
if [ ${REDIS_HOST} ]; then
    if ! grep -Fxq "session.save_handler = redis" /usr/local/etc/php/php.ini; then
        echo "session.save_handler = redis" >> /usr/local/etc/php/php.ini
        echo "session.save_path = \"tcp://$REDIS_HOST:6379\"" >> /usr/local/etc/php/php.ini
    fi
fi
php-fpm