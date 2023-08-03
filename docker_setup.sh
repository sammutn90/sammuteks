#!/bin/bash

# Function to start Docker daemon if not running
start_docker_daemon() {
  sudo systemctl start docker
}

# Function to check Docker installation and version
check_docker_installation() {
  if ! command -v docker &>/dev/null; then
    echo "Docker is not installed. Please install Docker on this machine."
    exit 1
  fi
}

# Function to add current user to the "docker" group
add_user_to_docker_group() {
  sudo usermod -aG docker $USER
  echo "Please log out and log back in to apply the changes."
}

# Function to restart Docker service
restart_docker_service() {
  sudo systemctl restart docker
}

# Check if Docker daemon is running
if ! docker info &>/dev/null; then
  echo "Docker daemon is not running. Starting Docker daemon..."
  start_docker_daemon
fi

# Check Docker installation and version
check_docker_installation

# Check Docker permissions
if ! docker info &>/dev/null; then
  echo "Docker permissions issue. Adding current user to the 'docker' group..."
  add_user_to_docker_group
  echo "Please run the pipeline again after logging out and logging back in."
  exit 1
fi

# Restart Docker service after adding to 'docker' group (if necessary)
if [ -n "$DOCKER_GROUP_ADDED" ]; then
  echo "Restarting Docker service..."
  restart_docker_service
fi
