FROM jenkins/jenkins:alpine
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV JAVA_OPTS -Djavax.net.ssl.trustStore=/var/jenkins_home/keystore/cacerts
ENV CASC_JENKINS_CONFIG /var/jenkins_home/security.yaml
#adding certificate for Unable to connect to SSL services due to "PKIX Path Building Failed" error
COPY ./certs /var/jenkins_home/keystore

#coping plugin file to container directory and installing 
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# coping login id pass file 
COPY security.yaml /var/jenkins_home/security.yaml

# security authorization jenkins api
# https://www.jenkins.io/doc/developer/extensions/jenkins-core/#authorizationstrategy