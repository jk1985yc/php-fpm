FROM php:8.0-fpm
#FROM php:5.6.34-fpm
#FROM php:5.6.31-fpm-alpine

#change repository
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

#Set unicode
ENV LANG C.UTF-8

#install mcrypt、mysql Module
RUN apt-get update && apt-get install -y \
    git zip unzip \
    cron vim 
    #libxslt-dev \
    #libbz2-dev 

# mysqli, pcntl, pdo_mysql, shmop, sysvmsg, sysvsem, sysvshm 擴充套件
RUN docker-php-ext-install -j$(nproc) bcmath calendar exif gettext sockets dba mysqli pcntl pdo_mysql shmop sysvmsg sysvsem sysvshm iconv

# GD 擴充套件
RUN apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev libwebp-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) gd

# imagick 擴充套件
RUN export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" \
    && apt-get update && apt-get install -y --no-install-recommends libmagickwand-dev \
    && rm -r /var/lib/apt/lists/* \
    && pecl install imagick \
    && docker-php-ext-enable imagick

# mcrypt 擴充套件 
RUN apt-get update && apt-get install -y --no-install-recommends libmcrypt-dev \
    && rm -r /var/lib/apt/lists/* \
    && pecl install mcrypt \
    && docker-php-ext-enable mcrypt

# Memcached 擴充套件 
RUN apt-get update && apt-get install -y --no-install-recommends libmemcached-dev zlib1g-dev \
    && rm -r /var/lib/apt/lists/* \
    && pecl install memcached \
    && docker-php-ext-enable memcached

#install redis Module
RUN pecl install redis && docker-php-ext-enable redis

# opcache 擴充套件 
RUN docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache

# xdebug 擴充套件
RUN pecl install xdebug && docker-php-ext-enable xdebug

# swoole 擴充套件
RUN pecl install swoole && docker-php-ext-enable swoole

# 安裝環境、安裝工具
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Time
ENV TW=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TW /etc/localtime && echo $TW > /etc/timezone  

RUN mkdir /logs

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
