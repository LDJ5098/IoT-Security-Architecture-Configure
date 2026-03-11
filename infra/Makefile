# 변수 설정 (디렉토리 경로)
INFRA_SERVER_DIR = infra-server
CLIENT_DEVICE_DIR = infra-c-client-device
SSH_DIR = ssh
DEPLOY_DIR = deploy

## 1. 인프라 전체 실행 (순서: 서버 -> SSH -> 클라이언트 -> 배포도구)
up:
	docker-compose -f $(INFRA_SERVER_DIR)/infra-compose.yml up -d
	docker-compose -f $(CLIENT_DEVICE_DIR)/docker-compose.yml up -d
	docker-compose -f $(DEPLOY_DIR)/deploy-compose.yml up -d
	docker-compose -f $(SSH_DIR)/ssh-compose.yml up -d

up--build:
	docker-compose -f $(INFRA_SERVER_DIR)/infra-compose.yml up -d --build
	docker-compose -f $(CLIENT_DEVICE_DIR)/docker-compose.yml up -d --build
	docker-compose -f $(DEPLOY_DIR)/deploy-compose.yml up -d --build
	docker-compose -f $(SSH_DIR)/ssh-compose.yml up -d --build

## 2. 전체 중지 및 삭제
down:
	docker-compose -f $(SSH_DIR)/ssh-compose.yml down
	docker-compose -f $(DEPLOY_DIR)/deploy-compose.yml down
	docker-compose -f $(CLIENT_DEVICE_DIR)/docker-compose.yml down
	docker-compose -f $(INFRA_SERVER_DIR)/infra-compose.yml down