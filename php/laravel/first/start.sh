#!/bin/bash
#判断是否有.env文件
if [ ! -f ./.env ];
  then
    cp .env.example .env
fi

NETWORK=laravel

#创建指定网络
if [ ! $(docker network ls | grep "$NETWORK") ];
  then
    docker network create ${NETWORK}
fi

docker build -t my/laravel --target=laravel .
docker build -t my/nginx --target=nginx .

docker run -it --rm --name=laravel --network=laravel my/laravel
docker run -it --rm --network=laravel -p 8080:80 my/nginx