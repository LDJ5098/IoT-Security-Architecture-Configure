#!/bin/sh
set -e

IMAGE="ghcr.io/ldj5098/iot-security-architecture-configure/backend"
COMPOSE_FILE="/infra-server/docker-compose-infra.yml"
COMPOSE_FILE_SUB="/infra-server/docker-compose-sub.yml"
IMAGE_TAG="${1:-latest}"  # 인자로 tag 받음, 없으면 latest

echo ">> GHCR 로그인..."
echo "${GITHUB_TOKEN}" | docker login ghcr.io -u ldj5098 --password-stdin

echo ">> 배포 이미지: ${IMAGE}:${IMAGE_TAG}"

echo ">> docker-compose 이미지 태그 적용..."
IMAGE_TAG="${IMAGE_TAG}" docker compose -f "${COMPOSE_FILE}" -f "${COMPOSE_FILE_SUB}" pull backend && \
docker compose -f "${COMPOSE_FILE}" -f "${COMPOSE_FILE_SUB}" up -d --no-build --no-recreate backend

echo ">> 배포 완료"