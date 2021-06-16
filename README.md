# jenkinsjdk11docker

Docker image with base in ubuntu. This is made for armhf (Raspberry pi4).
Contains:
- JDK 11
- Jenkins
- Requires docker to be running on host with port 2375 exposed
- Git

Starts on port 8585

# How to run:

```console
docker run --net=host --pid=host --ipc=host -it --rm -v /home/pi/jenkins_home/:/var/lib/jenkins/ --privileged xabdullahx/rpi-jenkinsjdk11docker
```
