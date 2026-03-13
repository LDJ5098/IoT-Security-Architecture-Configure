#!/bin/sh

# 로그아웃 시 무조건 배포 차단을 해제(false)하여 다음 자동 배포가 가능하게 함
STATUS_FILE="/deploy-setting/deploy_status.txt"

if [ -f "$STATUS_FILE" ]; then
    sed -i "s/SSH_ACCESS:.*/SSH_ACCESS: false/" "$STATUS_FILE"
fi