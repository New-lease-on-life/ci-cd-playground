# --------------------------------------------------------
# 1단계: 빌드 환경 (Builder) - 여기서 요리를 합니다.
# --------------------------------------------------------
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

# Wrapper 실행에 필요한 파일들을 먼저 복사
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

# 실행 권한 부여 및 의존성 다운로드
RUN chmod +x ./gradlew
RUN ./gradlew dependencies --no-daemon

# 이제 소스 코드를 복사하고 빌드합니다.
COPY src ./src
RUN gradle clean bootJar --no-daemon

# --------------------------------------------------------
# 2단계: 실행 환경 (Runner) - 완성된 요리만 서빙합니다.
# --------------------------------------------------------
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# 1단계(builder)에서 만든 jar 파일만 쏙 가져옵니다.
COPY --from=builder /app/build/libs/*.jar app.jar

# 환경변수 설정 (기본값)
ENV PROFILES=prod

# 실행 명령어
ENTRYPOINT ["java", "-Dspring.profiles.active=${PROFILES}", "-jar", "app.jar"]
