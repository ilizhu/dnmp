ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}

#更换到上海时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN  usermod -aG www-data nginx
