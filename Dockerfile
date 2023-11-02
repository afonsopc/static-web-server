FROM node:slim

WORKDIR /server
COPY . .

RUN npm install .
RUN npm audit fix

CMD ["npm", "run", "serve"]