#!/bin/bash

# running this if you want bash can run this script
# chmod +x deploy_swarm.sh


# Set variables
IMAGE_NAME="simple-nodejs-app"
STACK_NAME="nodejs-stacks"
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Initialize Docker Swarm
echo "Initializing Docker Swarm..."
docker swarm init 2>/dev/null || echo "Swarm already initialized."

# Remove existing stack if it exists
if docker stack ls | grep -q $STACK_NAME; then
  echo "Removing existing stack: $STACK_NAME..."
  docker stack rm $STACK_NAME

  # Wait for services to fully shut down
  echo "Waiting for existing services to stop..."
  sleep 10  # Adjust this delay as necessary based on service shutdown time
fi

# Remove existing Docker image if it exists
if docker images | grep -q $IMAGE_NAME; then
  echo "Removing existing image: $IMAGE_NAME..."
  docker rmi -f $IMAGE_NAME
fi

# Build Docker image
echo "Building Docker image..."
docker build -t $IMAGE_NAME .

# Deploy the stack
echo "Deploying stack '$STACK_NAME'..."
docker stack deploy -c $DOCKER_COMPOSE_FILE $STACK_NAME

# Wait a moment to let services start up
echo "Waiting for services to start up..."
sleep 10

# Check stack services
echo "Checking stack services..."
docker stack services $STACK_NAME

echo "Check all service status"
docker service ps $STACK_NAME"_"$IMAGE_NAME

echo "Check logs"
docker service logs --follow $STACK_NAME"_"$IMAGE_NAME

# Instructions for the user
echo -e "\nDeployment complete! Use the following commands to manage your stack:\n"
echo "Check services status: docker stack services $STACK_NAME"
echo "Check logs: docker service logs --follow $STACK_NAME_$IMAGE_NAME"
echo "Check all services status: docker service ps $STACK_NAME_$IMAGE_NAME"
echo "Remove stack when done: docker stack rm $STACK_NAME"
echo -e "\nTo update the stack, modify '$DOCKER_COMPOSE_FILE' and re-run this script.\n"