FROM  golang:1.12-alpine

# Speed up the apk
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# Preparing for cpp client
RUN apk update && apk add git build-base bash automake autoconf cmake libtool intltool zlib-dev bzip2-dev linux-headers 

# Build cpp client
COPY ./rocketmq-client-cpp /rocketmq-client-cpp 
RUN cd /rocketmq-client-cpp && ./build.sh && ./deploy.sh

RUN cp -r /rocketmq-client-cpp/include /usr/include/rocketmq
RUN cp -r /rocketmq-client-cpp/bin/librocketmq.* /usr/lib/ 
RUN cp -r /rocketmq-client-cpp/bin/lib/* /usr/lib/

