FROM node:12

WORKDIR /app

COPY index.js *.json .

EXPOSE 3000

CMD rpm start
