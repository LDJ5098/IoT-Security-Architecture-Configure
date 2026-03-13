#!/with-contenv sh

# linuxserver 이미지는 /config이 사용자 홈 디렉터리 역할을 수행함
USER_HOME="/config"
STATUS_FILE="/deploy-setting/deploy_status.txt"

# 로그인하는 순간 일단 배포 차단 상태로 만듦
cat <<EOF >> ${USER_HOME}/.bashrc
sed -i "s/SSH_ACCESS:.*/SSH_ACCESS: true/" /deploy-setting/deploy_status.txt
echo ">> [auto] 관리자 접속이 감지되어 배포를 차단합니다.
echo ">> 허용하려면 접속을 종료하거나, deploy_status.txt를 수정하세요."
echo ">> 현재 배포 상태 체크 명령어 : check"

# --- 커스텀 상태 확인 명령어 'check' ---
alias check='echo "------------------------------------------"; \\
             echo ">> 현재 배포 프로토콜 상태:"; \\
             grep "SSH_ACCESS" /deploy-setting/deploy_status.txt; \\
             grep "TIME_LOCK" /deploy-setting/deploy_status.txt; \\
             echo "------------------------------------------"; \\
             STATUS=\$(grep "SSH_ACCESS" /deploy-setting/deploy_status.txt | cut -d":" -f2 | tr -d " "); \\
             if [ "\$STATUS" = "true" ]; then \\
                 echo ">> 결과: [배포 불가] 관리자 승인(false)이 필요합니다."; \\
             else \\
                 echo ">> 결과: [배포 가능] 가동 준비 완료."; \\
             fi; \\
             echo "------------------------------------------"'
EOF

# 로그아웃 스크립트 연결
ln -sf /deploy-protocol/ssh-logout.sh ${USER_HOME}/.bash_logout