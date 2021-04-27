FROM node:12.16.1-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update && \
	apk upgrade && \
	apk add --no-cache nginx

RUN mkdir -p /var/log/nginx

RUN npm install pm2 -g

