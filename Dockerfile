FROM tomcat:8.5-jdk11-openjdk
MAINTAINER Karl Dahlgren <karl.dahlgren@castlemock.com>

# Delete the default applications
RUN rm -rf /usr/local/tomcat/webapps/ROOT
RUN rm -rf /usr/local/tomcat/webapps/docs
RUN rm -rf /usr/local/tomcat/webapps/examples
RUN rm -rf /usr/local/tomcat/webapps/manager
RUN rm -rf /usr/local/tomcat/webapps/host-manager

RUN useradd castlemock -g 0 
RUN usermod -g root -G 0 castlemock && mkdir /home/castlemock
RUN chown -R castlemock:0 /tomcat/tomcat && chown -R castlemock:0 /home/castlemock
RUN mkdir /usr/local/tomcat/castlemock && chown -R castlemock:0 /usr/local/tomcat/castlemock

# Change directory to Tomcat webapps folder and download the latest Castle Mock war file
RUN cd /usr/local/tomcat/webapps && curl -o castlemock.war -fSL https://github.com/castlemock/castlemock/releases/download/v1.55/castlemock.war

# Expose HTTP port 8080
EXPOSE 8080

USER castlemock
