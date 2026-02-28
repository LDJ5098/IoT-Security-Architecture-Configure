# 1. 베이스 이미지: 5MB 초경량 알파인 리눅스
FROM alpine:latest

# 2. 필수 개발 도구 및 '미리 컴파일된 Paho MQTT C 라이브러리' 한 번에 설치!
RUN apk update && \
    apk add --no-cache build-base paho-mqtt-c-dev

# 3. 작업 폴더 설정
WORKDIR /app

# 4. 컨테이너가 바로 꺼지지 않게 대기
CMD ["/bin/sh"]