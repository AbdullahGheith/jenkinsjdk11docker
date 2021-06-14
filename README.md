# jenkinsjdk11docker

Docker image with base in ubuntu. This is made for armhf (Raspberry pi4).
Contains:
- JDK 11
- Jenkins
- Docker daemon running on port 2375
- Git

# How to run:

```console
docker run -p 8080:8080 --privileged xabdullahx/rpi-jenkinsjdk11docker
```
