#!/bin/sh
set -e

# scripts -> src -> CD-server -> deploy -> infra(REPO_ROOT) : 총 4단계 위

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
REPO_ROOT=$(cd "$SCRIPT_DIR/../../../.." && pwd)

DEVICE_DIR="$REPO_ROOT/Infra-c-client-device"
SERVER_DIR="$REPO_ROOT/Infra-server"

git fetch origin main

echo ">> GitHub:Dev/ -> Server:infra/ 동기화 시작"

# 1. Device 관련 (Infra-c-client-device)
git show origin/main:Dev/Dev-c-client-device/device.c > "$DEVICE_DIR/device.c"
git show origin/main:Dev/Dev-c-client-device/Dockerfile > "$DEVICE_DIR/Dockerfile"
git show origin/main:Dev/Dev-c-client-device/docker-compose.yml > "$DEVICE_DIR/docker-compose.yml"

# 2. Server 관련 (Infra-server)
git show origin/main:Dev/Dev-server/mosquitto/docker-entrypoint.sh > "$SERVER_DIR/mosquitto/docker-entrypoint.sh"

# 1. Device 서비스 (Dockerfile 빌드 후 재시작)
echo ">> Infra-c-client-device 적용 중..."
cd "$DEVICE_DIR"
docker-compose up -d --build

# 2. Server 서비스 (mosquitto만 타겟팅 재시작)
echo ">> Mosquitto 적용 중..."
cd "$SERVER_DIR"
# infra-compose.yml 파일을 사용하며, mosquitto 서비스만 새로 올립니다.
docker-compose -f infra-compose.yml up -d --no-deps mosquitto

echo ">> 동기화 완료"