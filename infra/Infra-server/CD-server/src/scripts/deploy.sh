#!/bin/sh
set -e

IMAGE="ghcr.io/ldj5098/iot-security-architecture-configure/backend"
COMPOSE_FILE="/infra-server/docker-compose-infra.yml"
COMPOSE_FILE_SUB="/infra-server/docker-compose-sub.yml"
IMAGE_TAG="${1:-latest}"

echo ">> GHCR 로그인..."
echo "${GITHUB_TOKEN}" | docker login ghcr.io -u ldj5098 --password-stdin

echo ">> 배포 이미지: ${IMAGE}:${IMAGE_TAG}"

echo ">> 로컬 파일 동기화 중..."
docker run --rm -v /infra-server/backend:/target ${IMAGE}:${IMAGE_TAG} cp -rf /app/. /target/

echo ">> docker-compose 적용..."
TAG_FOR_BACKEND="${IMAGE_TAG}" docker compose -f "${COMPOSE_FILE}" -f "${COMPOSE_FILE_SUB}" pull backend && \
TAG_FOR_BACKEND="${IMAGE_TAG}" docker compose -f "${COMPOSE_FILE}" -f "${COMPOSE_FILE_SUB}" up -d --no-build backend

echo ">> 배포 완료"