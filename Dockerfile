# --------------------------------------------------------
# 1단계: 빌드 환경 (Builder) - 여기서 요리를 합니다.
# --------------------------------------------------------
FROM eclipse-temurin:17-jdk AS builder
WORKDIR /app

# 캐싱 효율을 위해 의존성 파일(build.gradle)만 먼저 복사해서 다운로드 받습니다.
# 소스 코드가 바뀌어도 라이브러리 다운로드는 스킵할 수 있어 빌드가 빨라집니다.
COPY build.gradle settings.gradle ./
RUN gradle dependencies --no-daemon

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
