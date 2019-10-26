FROM node:11

RUN mkdir -p /usr/src/app

RUN apt update && apt upgrade -y && apt -y install make g++ 

RUN npm install -g node-gyp

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .