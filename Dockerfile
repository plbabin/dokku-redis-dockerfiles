# Forked from https://github.com/luxifer/dokku-redis-dockerfiles

FROM ubuntu:trusty
MAINTAINER Brian Pattison "brian@brianpattison.com"

RUN wget http://download.redis.io/releases/redis-2.8.17.tar.gz
RUN tar xzf redis-2.8.17.tar.gz
RUN cd redis-2.8.17 && make install

RUN sed -i 's@bind 127.0.0.1@bind 0.0.0.0@' /etc/redis/redis.conf
RUN sed -i 's@daemonize yes@daemonize no@' /etc/redis/redis.conf

ADD . /bin
RUN chmod +x /bin/start_redis.sh
RUN mkdir -p /var/lib/redis
