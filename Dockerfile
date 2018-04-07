# Build command:
# docker build -t moriorgames/java-rest-api .
# Run command:
# docker run -td --name java_rest_api -p 8080:8080 moriorgames/java-rest-api
FROM java:8-jdk
MAINTAINER MoriorGames "moriorgames@gmail.com"


# Install packages
RUN         apt-get update
RUN         apt-get update -y
RUN         apt-get upgrade -y
RUN         apt-get install -y vim


# Gradle
WORKDIR /usr/bin
RUN wget https://services.gradle.org/distributions/gradle-4.6-all.zip && \
    unzip gradle-4.6-all.zip && \
    ln -s gradle-4.6 gradle && \
    rm gradle-4.6-all.zip


# Set Appropriate Environmental Variables
ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin


# Create Application directory
RUN         mkdir -p /app
COPY        . /app
WORKDIR     /app


EXPOSE 8080

CMD ["./gradlew", "bootRun"]
