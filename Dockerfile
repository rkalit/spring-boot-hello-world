# Use the official OpenJDK image to run the application
FROM openjdk:11-jre

ADD target/*.jar hello-app.jar
ENTRYPOINT ["java", "-jar", "hello-app.jar"]