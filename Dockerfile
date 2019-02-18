FROM openjdk:8-jre-alpine
MAINTAINER Michael Eamma
COPY build/libs/demo-0.0.1-SNAPSHOT.jar /app/test.jar
ENTRYPOINT ["java"]
CMD ["-jar", "/app/test.jar"]
EXPOSE 8080
