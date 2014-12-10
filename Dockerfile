# Forked from https://github.com/luxifer/dokku-redis-dockerfiles
# and from https://github.com/brianpattison/dokku-redis-dockerfiles
# and inspired by https://github.com/dokku-alt/redis-dockerfiles

FROM ubuntu:14.10
MAINTAINER Pierre-Luc Babin "plbabin@gmail.com"

RUN apt-get update
RUN apt-get install -y build-essential wget

RUN wget http://download.redis.io/releases/redis-2.8.17.tar.gz
RUN tar xzf redis-2.8.17.tar.gz
RUN mkdir -p /etc/redis/
RUN cd redis-2.8.17 && cp redis.conf /etc/redis/dokku.conf && make install

RUN sed -i 's@bind 127.0.0.1@bind 0.0.0.0@' /etc/redis/dokku.conf
RUN sed -i 's@daemonize yes@daemonize no@' /etc/redis/dokku.conf

RUN mkdir -p /var/lib/redis

ADD start_redis.sh /usr/bin/start_redis.sh

RUN chmod +x /usr/bin/start_redis.sh

EXPOSE 6379
