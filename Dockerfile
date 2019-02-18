FROM openjdk:8-jre-alpine
MAINTAINER Michael Eamma
COPY /tmp/workspace/demo-0.0.1-SNAPSHOT.jar /app/test.jar
ENTRYPOINT ["java"]
CMD ["-jar", "/app/test.jar"]
EXPOSE 8080
