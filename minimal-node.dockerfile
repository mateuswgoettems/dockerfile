#Alpine image - minimal
FROM node:lts-alpine3.15

WORKDIR /home/app
#First copy package.json
COPY package.json .
# Install only production Dependencies
RUN yarn --prod
# Copy compiled js
COPY dist/ . 
#Copy the .env file
COPY .env .

CMD [ "node", "src/main" ]