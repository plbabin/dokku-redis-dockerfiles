# Forked from https://github.com/luxifer/dokku-redis-dockerfiles

FROM ubuntu:trusty
MAINTAINER Brian Pattison "brian@brianpattison.com"

RUN apt-get update
RUN apt-get install -y build-essential wget

RUN wget https://github.com/antirez/redis/archive/3.0.0-rc1.tar.gz
RUN tar xzf 3.0.0-rc1.tar.gz
RUN mkdir -p /etc/redis/
RUN cd redis-3.0.0-rc1 && cp redis.conf /etc/redis/dokku.conf && make install

RUN sed -i 's@bind 127.0.0.1@bind 0.0.0.0@' /etc/redis/dokku.conf
RUN sed -i 's@daemonize yes@daemonize no@' /etc/redis/dokku.conf

ADD . /bin
RUN chmod +x /bin/start_redis.sh
RUN mkdir -p /var/lib/redis
