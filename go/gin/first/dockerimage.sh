#!/bin/bash
IMAGE=jucce/hello-world:develop
BUILDER_IMAGE=jucce/hello-world:builder
#第一次先拉取
#docker build  --target builder -t $BUILDER_IMAGE .
#docker build   -t $IMAGE .
#exit 0



# 拉取builder镜像以及生产镜像，|| true用于确保语句执行成功（拉取的镜像可能不存在）
docker pull $IMAGE || true
docker pull $BUILDER_IMAGE || true

# 用--target指定构建builder镜像，使用cache-from指定之前的builder镜像作为cache
docker build \
    --target builder \
    --cache-from $BUILDER_IMAGE \
    -t $BUILDER_IMAGE .

# 构建生产镜像， 使用cache-from指定之前的builder镜像以及生产镜像作为cache
docker build \
    --cache-from $BUILDER_IMAGE \
    --cache-from $IMAGE \
    -t $IMAGE .

# 将builder镜像和生产镜像推到docker仓库
docker push $BUILDER_IMAGE
docker push $IMAGE