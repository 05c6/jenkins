FROM tomcat 
WORKDIR webapps 
COPY /var/lib/jenkins/workspace/Deekshith_MVN_PJT@2/target/WebApp.war .
RUN rm -rf ROOT && mv WebApp.war ROOT.war
ENTRYPOINT ["sh", "/usr/local/tomcat/bin/startup.sh"]
