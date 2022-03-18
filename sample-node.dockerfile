FROM node:lts

WORKDIR /home/app

COPY package.json .

RUN npm i

COPY . .

CMD [ "node", "server.js" ]