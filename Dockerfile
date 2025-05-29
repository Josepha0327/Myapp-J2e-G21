# Étape de compilation (Build stage)
# FROM quay.io/snowdrop/maven-openjdk8:latest AS build

FROM csanchez/maven:3.8-openjdk-11 AS build

USER root
RUN chmod -R 777 /root

WORKDIR /app

# Copie des fichiers nécessaires à la construction
COPY pom.xml .
COPY src ./src

# Construction du projet (package WAR)
RUN mvn clean package

# Étape de déploiement (Runtime stage)
FROM quay.io/lib/tomcat:9-jdk11-corretto
# Remarque : `quay.io/lib/tomcat` semble incorrect, `quay.io/library/tomcat` ou `tomcat` depuis Docker Hub est plus fiable

# Copier l'artefact WAR dans le répertoire de déploiement de Tomcat
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/myapp.war
