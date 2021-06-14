FROM ubuntu:xenial-20210429

ENV DOCKER_HOST=tcp://127.0.0.1:2375
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-armhf
ENV JENKINS_HOME=/var/lib/jenkins

RUN apt-get -y update

RUN apt-get -y install apt-transport-https ca-certificates curl gnupg wget lsb-release software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

RUN echo "deb [arch=armhf signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get -y update

RUN apt-get -y install docker-ce docker-ce-cli

RUN sed 's/--containerd=\/run\/containerd\/containerd.sock/-H tcp:\/\/127.0.0.1:2375/' /lib/systemd/system/docker.service > /lib/systemd/system/docker.service.changed

RUN rm /lib/systemd/system/docker.service

RUN mv /lib/systemd/system/docker.service.changed /lib/systemd/system/docker.service

RUN mkdir /etc/docker

RUN echo '{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}' > /etc/docker/daemon.json

ADD docker.sh /

RUN chmod +x docker.sh

RUN add-apt-repository ppa:openjdk-r/ppa

RUN apt-get update

RUN apt-get -y install openjdk-11-jdk

RUN wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -

RUN sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

RUN apt-get update

RUN apt-get -y install jenkins git

RUN chown jenkins:jenkins -R /var/lib/jenkins/

RUN apt-get -y install ca-certificates-java

RUN update-ca-certificates -f

ADD cacerts /etc/ssl/certs/java/cacerts

ENTRYPOINT ["./docker.sh"]
