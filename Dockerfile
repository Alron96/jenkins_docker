FROM maven:3.8.4-openjdk-17 as builder
WORKDIR /opt/image_name
COPY pom.xml ./
COPY ./src ./src

RUN mvn clean install
FROM maven:3.8.4-openjdk-17
WORKDIR /opt/image_name
COPY --from=builder /opt/image_name/target/*.jar /opt/image_name/*.jar
EXPOSE 8484
ENTRYPOINT ["java", "-jar", "/opt/image_name/*.jar"]