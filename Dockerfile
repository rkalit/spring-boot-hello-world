# Use the official Maven image to build the application
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Use the official OpenJDK image to run the application
FROM openjdk:11-jre
WORKDIR /app
COPY --from=build /app/target/*.jar hello-app.jar
ENTRYPOINT ["java", "-jar", "hello-app.jar"]