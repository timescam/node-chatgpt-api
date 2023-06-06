FROM node:16-alpine

RUN apk add curl

ENV API_HOST=0.0.0.0
WORKDIR /app
COPY . .

COPY ./settings.example.js settings.js
ARG COOKIE_FILE
RUN cookies=$(curl -fsSL $COOKIE_FILE)
RUN sed -i "s/cookies: '/cookies: '${cookies}/" settings.js
RUN sed -i "s/clientToUse: '/clientToUse: 'bing/" settings.js

RUN npm install
EXPOSE 3000

CMD ["npm", "run", "start"]
