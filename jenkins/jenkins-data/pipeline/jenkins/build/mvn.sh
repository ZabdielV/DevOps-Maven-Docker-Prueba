#!/bin/bash

echo "***************************"
echo "** Building jar ***********"
echo "** Running commands inside docker image, not vagrant ***********"
echo "** WORKSPACE variable refers to host location where app code is located***********"
echo "***************************"

WORKSPACE=/home/Jenkins-Pipeline-Docker-Project/jenkins/jenkins-data/jenkins_home/workspace/pipeline-docker-maven

docker run --rm  -v  $WORKSPACE/java-app:/app -v /root/.m2/:/root/.m2/ -w /app maven:3-alpine "$@"
