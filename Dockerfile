FROM openjdk:11
EXPOSE 8000
ADD target/provider-search-0.0.1-SNAPSHOT.jar provider-search-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","provider-search-0.0.1-SNAPSHOT.jar"]
