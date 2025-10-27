#!/bin/bash
# Create deploy directory if it doesn't exist
mkdir -p /home/ec2-user/deploy
chown -R ec2-user:ec2-user /home/ec2-user/deploy

echo "Files being deployed:"
ls -la /home/ec2-user/deploy/
