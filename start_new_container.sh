#!/bin/bash
set -e

DEPLOY_DIR=/home/ec2-user/deploy
CONTAINER_NAME=cohesion

# Read latest image URI
IMAGE=$(cat $DEPLOY_DIR/imageDetail.txt)

cd $DEPLOY_DIR

# Stop old container
echo "Stopping old container if exists..."
docker-compose down || true

# Create override docker-compose.yml with latest image
echo "Updating docker-compose.override.yml with new image..."
cat > docker-compose.override.yml <<EOL
version: '3.9'

services:
  myapp:
    image: $IMAGE
    container_name: $CONTAINER_NAME
    ports:
      - "8005:80"
    restart: unless-stopped
    environment:
      NODE_ENV: production
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
EOL

# Login to ECR
REGISTRY=$(echo $IMAGE | cut -d'/' -f1)
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $REGISTRY

# Pull latest image
docker-compose pull

# Start new container
echo "Starting container using docker-compose..."
docker-compose up -d

echo "Deployment complete!"

