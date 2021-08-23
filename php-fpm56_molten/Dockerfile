FROM php:5.6.40-fpm
#FROM php:5.6.34-fpm
#FROM php:5.6.31-fpm-alpine

#Set unicode
ENV LANG C.UTF-8

#install mcrypt、mysql Module
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        cron vim \
        libxslt-dev \
        libbz2-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install mysql mysqli sysvsem \
    && docker-php-ext-install bz2 calendar exif gettext pcntl pdo_mysql shmop sockets sysvmsg sysvshm wddx xsl zip bcmath
    
#install redis Module
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mkdir -p /usr/src/php/ext/ \
    && mv phpredis-2.2.7 /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# 安裝環境、安裝工具
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Add Molten Module
RUN apt-get update && apt-get install -y libcurl4-openssl-dev
COPY ./Molten /Molten
RUN cd /Molten && phpize && ./configure --enable-zipkin-header=yes && make && make install


#Time
ENV TW=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TW /etc/localtime && echo $TW > /etc/timezone  

RUN mkdir /logs

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
