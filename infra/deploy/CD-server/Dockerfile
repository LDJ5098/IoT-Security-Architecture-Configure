FROM node:20-slim

# git, docker cli 설치
RUN apt-get update && apt-get install -y git curl && \
    curl -fsSL https://get.docker.com | sh && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 패키지 설치
COPY package.json .
RUN npm install

# 소스코드 복사 및 빌드
COPY tsconfig.json .
COPY src/ ./src/
RUN npm run build

CMD ["npm", "start"]