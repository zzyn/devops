FROM node:10.19.0-stretch

RUN apt-get update \
    && apt-get install -y \
        vim

RUN mkdir -p /root/.yarn-cache
RUN yarn config set cache-folder /root/.yarn-cache
