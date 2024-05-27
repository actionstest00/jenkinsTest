FROM openjdk:11
COPY *.jar /usr/local/jenkinsTest.jar
WORKDIR /usr/local/
ENTRYPOINT ["java", "-jar", "jenkinsTest.jar"]
