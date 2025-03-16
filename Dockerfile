FROM tomcat:9.0-jdk11
COPY target/NumberGuessGame.war /usr/local/tomcat/webapps/
EXPOSE 8080
