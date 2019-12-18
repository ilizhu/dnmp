ARG REDIS_VERSION
FROM redis:${REDIS_VERSION}
#FROM redis:alpine
# 更换到上海时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# 使用自定义conf启动
CMD [ "redis-server", "/etc/redis.conf" ]
# 解决常见问题
##  1.WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
#RUN echo 511 > /proc/sys/net/core/somaxconn
##  2. WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis.
#RUN echo never > /sys/kernel/mm/transparent_hugepage/enabled
