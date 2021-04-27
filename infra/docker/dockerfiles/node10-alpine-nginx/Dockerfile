FROM node:10.15.0-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update && \
	apk upgrade && \
	apk add --no-cache nginx

RUN mkdir -p /var/log/nginx
