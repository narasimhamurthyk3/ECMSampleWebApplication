FROM openjdk:8
EXPOSE 8084
ADD /target/ECMSampleApplication.jar ECMSampleApplication.jar
ENTRYPOINT ["java", "-jar", "ECMSampleApplication.jar"]