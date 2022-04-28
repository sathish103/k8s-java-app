FROM maven:4.0.0 AS build
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat
COPY --from=build /app/target/maven-web-application.war /usr/local/tomcat/webapps 