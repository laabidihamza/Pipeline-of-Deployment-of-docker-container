FROM node:20-alpine

COPY /src ./

COPY package*.json ./

COPY tsconfig.json ./

RUN npm install

EXPOSE 3000

CMD ["npm", "run", "start:dev"]