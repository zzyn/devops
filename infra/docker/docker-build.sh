#!/usr/bin/env bash

DOCKER_IMAGE_NAME=""

while getopts i:j:p: option
do
    case "$option" in
        i)
            DOCKER_IMAGE_NAME=$OPTARG
            #echo "option:i, value $OPTARG"
            echo "option:i, value $DOCKER_IMAGE_NAME";;
        p)
            DOCKER_FILE_PATH=$OPTARG
            cp "$DOCKER_FILE_PATH/Dockerfile" ./
            echo "option:p, value $DOCKER_FILE_PATH";;
        \?)
            echo "Usage: args [-i]"
            echo "-i means docker images name"
            exit 1;;
    esac
done

docker rmi $DOCKER_IMAGE_NAME -f

# TODO remove bff host
docker build -t $DOCKER_IMAGE_NAME \
--add-host=nexus3-cn.englishtown.com:10.17.10.17 \
--add-host=mt-student-exam-bff.qa.edtech.kt:123.206.238.221 \
./
