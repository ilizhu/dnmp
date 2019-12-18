#!/bin/bash

echo "============================================"
echo "Building extensions for $PHP_VERSION"
echo "============================================"


function phpVersion() {
    [[ ${PHP_VERSION} =~ ^([0-9]+)\.([0-9]+)\.([0-9]+) ]]
    num1=${BASH_REMATCH[1]}
    num2=${BASH_REMATCH[2]}
    num3=${BASH_REMATCH[3]}
    echo $[ $num1 * 10000 + $num2 * 100 + $num3 ]
}


version=$(phpVersion)
cd /tmp/extensions

# Use multicore compilation if php version greater than 5.4
# $(nproc)解释:nproc是操作系统级别对每个用户创建的进程数的限制
# -j$(nproc): 如make -j2则是使用2个线程编译
if [ ${version} -ge 50600 ]; then
    export mc="-j$(nproc)";
fi

# redis扩展
if [ "${PHP_EXT_REDIS}" != "false" ]; then
    mkdir redis \
    && tar -xf redis-${PHP_EXT_REDIS}.tgz -C redis --strip-components=1 \
    && ( cd redis && phpize && ./configure && make $mc && make install ) \
    && docker-php-ext-enable redis
fi

# mysql扩展
if [ "${PHP_EXT_MYSQL}" != "false" ]; then
    docker-php-ext-install $mc pdo_mysql
fi

# zip扩展
if [ "${PHP_EXT_ZIP}" != "false" ]; then
    apt-get install -y zlib1g-dev \
    && docker-php-ext-install $mc zip
fi

# gd和exif扩展
if [ "${PHP_EXT_GD}" != "false" ]; then
    apt-get install -y libwebp-dev libjpeg-dev libpng-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install $mc gd exif
fi

# iconv扩展
if [ "${PHP_EXT_ICONV}" != "false" ]; then
    docker-php-ext-install $mc iconv
fi