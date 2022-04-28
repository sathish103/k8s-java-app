#FROM tomcat:8.0.20-jre8
#COPY target/maven-web-app*.war /usr/local/tomcat/webapps/maven-web-application.war

FROM maven:3.6.1-jdk-8 as build
WORKDIR /app
ADD pom.xml .
...
FROM tomcat:8.0.20-jre8
COPY --from=build /app/target/maven-web-app*.war /usr/local/tomcat/webapps