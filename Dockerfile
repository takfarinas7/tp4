FROM maven:3-openjdk-17 AS build 

WORKDIR /app
COPY . . 
RUN mvn clean package -DskipTests



FROM eclipse-temurin:17-jre-alpine

RUN mkdir -p /data
VOLUME /data 

WORKDIR /app
EXPOSE 8080

COPY --from=build /app/target/todo-0.0.1-SNAPSHOT.jar app.jar 
ENTRYPOINT ["java", "-jar", "app.jar"]
