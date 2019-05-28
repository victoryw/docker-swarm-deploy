FROM openjdk:8-jdk-alpine
COPY /build/libs/demo-0.0.1-SNAPSHOT.jar app.jar
RUN mkdir /log
RUN touch /log/1.out
RUN echo '12345' > /log/1.out
VOLUME /log/
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]