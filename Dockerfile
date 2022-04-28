FROM tomcat:8.0.20-jre8
COPY --from=build /app/target/maven-web-app*.war /usr/local/tomcat/webapps/maven-web-application.war
