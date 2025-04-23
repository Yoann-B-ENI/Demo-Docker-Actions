# BUILD
FROM maven:3.9.9-eclipse-temurin-24 AS builder
WORKDIR /app
COPY src ./src
COPY pom.xml .
RUN mvn clean package -Dskiptests

# PACKAGE
FROM eclipse-temurin:24
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]