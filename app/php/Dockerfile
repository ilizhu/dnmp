ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm
ARG PHP_EXT_REDIS

#更换到上海时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 全局安装Composer
# RUN curl -sS https://install.phpcomposer.com/installer|php
# RUN mv composer.phar /usr/local/bin/composer

# 替换sources.list
COPY sources.list /etc/apt/sources.list
# RUN apt-get update
#******************************** 安装Linux环境基本命令 ********************************#
## 安装ping
#RUN apt-get install -y iputils-ping
## 安装ifconfig
#RUN apt-get install -y libnet-ifconfig-wrapper-perl
## 安装ps
#RUN apt-get install -y procps
## 安装vim
#RUN apt-get install -y vim


##************************************* 安装PHP扩展 ************************************#
COPY ./extensions /tmp/extensions
RUN chmod +x /tmp/extensions/install.sh \
    && /tmp/extensions/install.sh \
    && rm -rf /tmp/extensions

# 可直接安装和pecl安装的扩展
# 1. soap requires libxml2-dev.
# 2. xml, xmlrpc, wddx require libxml2-dev and libxslt-dev.
# 3. Line `&& :\` do nothing just for better reading.
# RUN apt-get install -y libicu-dev \
#     && docker-php-ext-install $mc intl \
#     && :\
#     && apt install -y libxml2-dev \
#     && apt install -y libxslt-dev \
#     && docker-php-ext-install $mc soap \
#     && docker-php-ext-install $mc xsl \
#     && docker-php-ext-install $mc xmlrpc \
#     && docker-php-ext-install $mc wddx \
#     && :\
#     && apt install -y libbz2-dev \
#     && docker-php-ext-install $mc bz2 \
#     && :\
#     && docker-php-ext-install $mc pcntl \
#     && docker-php-ext-install $mc bcmath \
#     && docker-php-ext-install $mc calendar \
#     && docker-php-ext-install $mc sockets \
#     && docker-php-ext-install $mc gettext \
#     && docker-php-ext-install $mc shmop \
#     && docker-php-ext-install $mc sysvmsg \
#     && docker-php-ext-install $mc sysvsem \
#     && docker-php-ext-install $mc sysvshm

RUN usermod -u 1000 www-data
