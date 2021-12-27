FROM node:lts-alpine3.12

WORKDIR /home/

RUN npm install -g @nestjs/cli