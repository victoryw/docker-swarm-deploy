FROM openjdk:8-jdk-alpine
COPY /build/libs/demo-0.0.1-SNAPSHOT.jar app.jar
RUN mkdir /application-log
RUN touch /application-log/1.out
RUN echo '12345' > /application-log/1.out
VOLUME /application-log/
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]