FROM node:alpine

LABEL maintainer="juccexu" email="juccexu@gmail.com"

ENV PORT 3000

# 创建工作目录
WORKDIR /usr/src/app

# 复制依赖
COPY package*.json  yarn.lock /usr/src/app/

#RUN npm install
RUN yarn install --production && yarn cache clean


# Copying source files
COPY . /usr/src/app

# Building app
#RUN npm run build
RUN yarn build
EXPOSE 3000

# Running the app
#CMD ["npm","run","start"]
CMD ["yarn","start"]