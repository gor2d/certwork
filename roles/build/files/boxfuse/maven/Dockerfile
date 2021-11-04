FROM ubuntu:20.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt install default-jdk  maven git -y
RUN mkdir /opt/boxfuse 
RUN mkdir /opt/war
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /opt/boxfuse/
RUN mvn -f /opt/boxfuse/pom.xml package
RUN cp /opt/boxfuse/target/hello-1.0.war /opt/war/
