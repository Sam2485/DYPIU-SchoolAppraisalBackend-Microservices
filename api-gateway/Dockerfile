FROM maven:3.9.8-eclipse-temurin-21-alpine AS build
WORKDIR /app

COPY pom.xml .
COPY api-gateway/pom.xml api-gateway/
COPY auth-user-service/pom.xml auth-user-service/
COPY form-data-service/pom.xml form-data-service/
COPY submission-service/pom.xml submission-service/
COPY storage-service/pom.xml storage-service/
COPY admin-service/pom.xml admin-service/

RUN mvn dependency:go-offline -B -pl api-gateway -am

COPY api-gateway/src api-gateway/src
RUN mvn package -DskipTests -pl api-gateway -am -B

FROM eclipse-temurin:21-jre-alpine
RUN addgroup -S spring && adduser -S spring -G spring
WORKDIR /app

COPY --from=build /app/api-gateway/target/*.jar app.jar
USER spring:spring

EXPOSE 8080

ENTRYPOINT ["java", \
    "-XX:+UseContainerSupport", \
    "-XX:MaxRAMPercentage=75.0", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-Dfile.encoding=UTF-8", \
    "-jar", "app.jar"]
