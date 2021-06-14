#!/bin/bash

service docker start

java -jar /usr/share/jenkins/jenkins.war --accessLoggerClassName=winstone.accesslog.SimpleAccessLogger --simpleAccessLogger.format=combined --simpleAccessLogger.file=/var/log/jenkins/access_log
