FROM quay.io/ibm/maven:3.6.3 AS builder
WORKDIR /app
COPY . .
RUN mvn clean install package

FROM quay.io/lib/tomcat
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
