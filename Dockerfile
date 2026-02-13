# 1단계: 실행 환경만 정의 (Alpine 기반으로 가볍게 유지)
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# [핵심] GitHub Actions VM에서 빌드된 jar 파일을 컨테이너 안으로 복사
# YAML 파일의 ./gradlew bootJar 결과물이 보통 build/libs/ 아래에 생성됩니다.
COPY build/libs/*.jar app.jar

# 환경변수 설정
ENV PROFILES=prod

# 실행 명령어
ENTRYPOINT ["java", "-Dspring.profiles.active=${PROFILES}", "-jar", "app.jar"]
