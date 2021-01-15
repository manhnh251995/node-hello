FROM node:12

WORKDIR /app

COPY index.js *.json ./
RUN npm install

EXPOSE 3000

CMD npm start


