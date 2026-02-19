####### Stage BUILD ##########
FROM maven:3.9.11-amazoncorretto-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

####### Stage RUN ##########
FROM tomcat:9.0.112-jdk17-corretto-al2

# Supprimer les apps par défaut de Tomcat (optionnel mais propre)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copier ton WAR
COPY --from=build /app/target/myapp-g20.war /usr/local/tomcat/webapps/myapp.war

# Port utilisé par Tomcat
EXPOSE 8080

# Lancer Tomcat
CMD ["catalina.sh", "run"]
