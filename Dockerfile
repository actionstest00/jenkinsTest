FROM openjdk:11
COPY *.jar /usr/local/
WORKDIR /usr/local/
ENTRYPOINT ["java", "-jar", "jenkinsTest.jar"]
