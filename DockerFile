FROM openjdk:8-jdk-alpine
WORKDIR /tmp
ADD helloworld.jar helloworld.jar
EXPOSE 8082
CMD java - jar helloworld.jar
