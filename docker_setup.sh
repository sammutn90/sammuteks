#!/bin/bash

# Function to start Docker daemon if not running
start_docker_daemon() {
  sudo service docker start  # Use 'sudo service docker start' instead of 'sudo systemctl start docker'
}

# Function to check Docker installation and version
check_docker_installation() {
  if ! command -v docker &>/dev/null; then
    echo "Docker is not installed. Please install Docker on this machine."
    exit 1
  fi
}

# Function to add current user to the "docker" group (not needed in CodeBuild)
# CodeBuild environment already has Docker access without needing to add the user to the "docker" group.

# Function to restart Docker service (not needed in CodeBuild)
# CodeBuild environment handles Docker service management, so no need for manual restarts.

# Check if Docker daemon is running
if ! docker info &>/dev/null; then
  echo "Docker daemon is not running. Starting Docker daemon..."
  start_docker_daemon
fi

# Check Docker installation and version
check_docker_installation
