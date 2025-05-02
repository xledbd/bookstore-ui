FROM node:16-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:16-alpine

WORKDIR /app

COPY --from=build /app/build ./build
COPY --from=build /app/server.js ./

RUN npm init -y && npm install serve-handler http-proxy-middleware

EXPOSE 3000

CMD [ "node", "server.js" ]
