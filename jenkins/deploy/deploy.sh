#!/bin/bash

echo maven-project > /tmp/.auth
echo $BUILD_TAG >> /tmp/.auth
echo $PASS >> /tmp/.auth

echo "Connecting to remote machine"

scp -i /opt/prod /tmp/.auth prod-user@$REMOTE_HOST:/tmp/.auth
scp -i /opt/prod ./jenkins/deploy/publish prod-user@$REMOTE_HOST:/tmp/publish
ssh -i /opt/prod prod-user@$REMOTE_HOST "/tmp/publish"
