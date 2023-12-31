FROM bitnami/php-fpm:8.3

RUN apt update && apt install -y autoconf php-dev pkg-php-tools unzip git zlib1g-dev wget build-essential && \
    curl -fsSL https://bun.sh/install | bash && \
    mv /root/.bun/bin/bun /usr/local/bin && \
    pecl install excimer

RUN wget https://pecl.php.net/get/redis-6.0.2.tgz && \
    tar xzf redis-6.0.2.tgz &&  \
    cd redis-6.0.2 &&  \
    phpize &&  \
    ./configure &&  \
    make &&  \
    make install

RUN git clone https://github.com/NoiseByNorthwest/php-spx.git && \
    cd php-spx &&  \
    phpize &&  \
    ./configure &&  \
    make &&  \
    make install

WORKDIR /app/frontend
