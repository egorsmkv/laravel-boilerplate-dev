FROM bitnami/php-fpm:8.3

RUN apt update && apt install -y autoconf php-dev pkg-php-tools unzip wget build-essential && \
    pecl install excimer

RUN wget https://pecl.php.net/get/redis-6.0.2.tgz && \
    tar xzf redis-6.0.2.tgz &&  \
    cd redis-6.0.2 &&  \
    phpize &&  \
    ./configure &&  \
    make &&  \
    make install && \
    cd /app && \
    rm redis-6.0.2.tgz

RUN wget https://github.com/caddyserver/caddy/releases/download/v2.7.6/caddy_2.7.6_linux_arm64.tar.gz && \
    tar xzf caddy_2.7.6_linux_arm64.tar.gz && \
    rm caddy_2.7.6_linux_arm64.tar.gz LICENSE README.md

WORKDIR /tmp

COPY . .

RUN mv /tmp/caddy/Caddyfile /app
RUN mv /tmp/apps/frontend /app

RUN cp prod-frontend.env /app/frontend/.env
RUN cp ./phpfpm/env.conf /opt/bitnami/php/etc/php-fpm.d/env.conf
RUN cp ./phpfpm/custom.ini /opt/bitnami/php/etc/conf.d/custom.ini
RUN rm -rf /app/frontend/node_modules

WORKDIR /app/frontend

RUN composer install --optimize-autoloader --no-dev

RUN php artisan key:generate && \
    php artisan view:cache && \
    php artisan route:cache && \
    php artisan config:cache

RUN chown -R daemon:daemon /app/frontend/
