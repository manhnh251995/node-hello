FROM node:12

WORKDIR /app

COPY index.js .

COPY *.json .

EXPOSE 3000

CMD rpm start
