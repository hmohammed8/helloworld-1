FROM openjdk:8-jdk-alpine
WORKDIR /tmp
EXPOSE 8082
CMD java - jar helloworld.jar
