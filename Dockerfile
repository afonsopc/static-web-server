FROM node:alpine

WORKDIR /server
COPY . .

RUN npm ci --only=production

CMD ["npm", "run", "serve"]