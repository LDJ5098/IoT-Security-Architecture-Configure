#!/bin/sh
set -e

IMAGE="ghcr.io/ldj5098/iot-security-architecture-configure/backend"
COMPOSE_FILE="/infra-server/docker-compose-infra.yml"
COMPOSE_FILE_SUB="/infra-server/docker-compose-sub.yml"
IMAGE_TAG="${1:-latest}"

echo ">> GHCR 로그인..."
# 질문자님이 지시하신 로그인 방식 유지
echo "${GITHUB_TOKEN}" | docker login ghcr.io -u ldj5098 --password-stdin

echo ">> 배포 이미지: ${IMAGE}:${IMAGE_TAG}"

# [추가된 부분] 1. 이미지의 내용을 로컬 폴더로 복사 (OS 동기화)
# 이 줄이 추가되어야 로컬 폴더에 최신 이미지가 나타납니다.
echo ">> 로컬 파일 시스템 최신화 중..."
docker run --rm -v /infra-server/backend:/target ${IMAGE}:${IMAGE_TAG} cp -rf /app/. /target/

# 2. pull 및 up 과정
echo ">> docker-compose 이미지 태그 적용..."
IMAGE_TAG="${IMAGE_TAG}" docker compose -f "${COMPOSE_FILE}" -f "${COMPOSE_FILE_SUB}" pull backend && \
docker compose -f "${COMPOSE_FILE}" -f "${COMPOSE_FILE_SUB}" up -d --no-build --no-deps backend

echo ">> 배포 완료"