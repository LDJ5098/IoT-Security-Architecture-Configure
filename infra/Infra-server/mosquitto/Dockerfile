FROM eclipse-mosquitto:latest

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# ... 기타 설정
ENTRYPOINT ["sh", "/docker-entrypoint.sh"]