FROM openjdk:8
EXPOSE 8084
ADD /target/ecm-sample-web-application.jar ecm-sample-web-application.jar
ENTRYPOINT ["java", "-jar", "ecm-sample-web-application.jar"]
