FROM alpine:latest
RUN echo 'http://mirrors.ustc.edu.cn/alpine/v3.3/main/' > /etc/apk/repositories
RUN apk -U add dnsmasq
#RUN ln -sf /dev/stdout /var/log/dnsmasq.log
EXPOSE 53 53/udp
ENTRYPOINT ["dnsmasq", "-k"]
