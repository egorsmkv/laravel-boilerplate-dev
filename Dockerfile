FROM bitnami/php-fpm:8.3

RUN apt update && apt install -y autoconf php-dev pkg-php-tools unzip zlib1g-dev wget build-essential && \
    pecl install excimer

RUN wget https://pecl.php.net/get/redis-6.0.2.tgz && \
    tar xzf redis-6.0.2.tgz &&  \
    cd redis-6.0.2 &&  \
    phpize &&  \
    ./configure &&  \
    make &&  \
    make install

ADD ./apps /app

RUN cp prod-frontend.env apps/frontend/.env
RUN cp ./phpfpm/env.conf /opt/bitnami/php/etc/php-fpm.d/env.conf
RUN cp ./phpfpm/custom.ini /opt/bitnami/php/etc/conf.d/custom.ini

WORKDIR /app/frontend

RUN composer install --optimize-autoloader --no-dev

RUN php artisan key:generate
