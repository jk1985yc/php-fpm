FROM php:7.3.25-fpm
#FROM php:5.6.34-fpm
#FROM php:5.6.31-fpm-alpine

#Set unicode
ENV LANG C.UTF-8

#install mcrypt、mysql Module
RUN apt-get update && apt-get install -y \
        git zip unzip \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        cron vim \
        libxslt-dev \
        libbz2-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysqli sysvsem \
    && docker-php-ext-install bz2 calendar exif gettext pcntl pdo_mysql shmop sockets sysvmsg sysvshm wddx xsl
    
#install redis Module
RUN pecl install redis && docker-php-ext-enable redis

# 安裝環境、安裝工具
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Time
ENV TW=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TW /etc/localtime && echo $TW > /etc/timezone  

RUN mkdir /logs

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
