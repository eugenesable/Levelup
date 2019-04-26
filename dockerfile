FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y tomcat8

ENV CATALINA_HOME /usr/share/tomcat8
ENV PATH $CATALINA_HOME/bin:$PATH

RUN mkdir -p $CATALINA_HOME/conf && \
    cp -R /etc/tomcat8/* $CATALINA_HOME/conf && \
    apt-get install -y maven && \
    apt-get install -y git && \
    cd /opt/ && \ 
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git && \
    cd /opt/boxfuse-sample-java-war-hello/ && \ 
    mvn package && \
    mkdir $CATALINA_HOME/webapps/ && \
    cp /opt/boxfuse-sample-java-war-hello/target/hello-1.0.war $CATALINA_HOME/webapps/hello-1.0.war

EXPOSE 8080
CMD ["catalina.sh", "run"]


