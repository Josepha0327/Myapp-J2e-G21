FROM maven:3.9.2-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean install package

FROM quay.io/lib/tomcat
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/
