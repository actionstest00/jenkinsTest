FROM openjdk:11
COPY jenkinsTest.jar /usr/local/
WORKDIR /usr/local/
ENTRYPOINT ["java", "-jar", "jenkinsTest.jar"]