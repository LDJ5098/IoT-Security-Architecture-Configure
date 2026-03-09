FROM node:20-slim

# git, docker cli 설치
RUN apt-get update && apt-get install -y git docker.io && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json .
RUN npm install

COPY tsconfig.json .
COPY src/ ./src/
RUN npm run build

CMD ["npm", "start"]