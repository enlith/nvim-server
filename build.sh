#!/bin/bash

set -e

if command -v podman &> /dev/null
then
    echo "Using Podman"
    DOCKER_CMD="podman"
else
    echo "Using Docker"
    DOCKER_CMD="docker"
fi

read -sp 'Enter password for docker user: ' password

DOCKER_IMAGE=nvim-server
#DOCKER_TAG=$($DOCKER_CMD images --format "{{.Tag}}" $DOCKER_IMAGE | sort -r | head -n1 | awk -F. '{print $1"."$2+1"."$3}')
DOCKER_TAG=$(date +"%Y%m%d-%H%M%S")
# Get the SHA value of the latest image
LAST_SHA=$($DOCKER_CMD inspect --format='{{.Id}}' $DOCKER_IMAGE:latest 2>/dev/null || echo '')

$DOCKER_CMD build \
    --build-arg username=$USER \
    --build-arg password=$password \
    -t $DOCKER_IMAGE:latest \
    .

# Get the SHA value of the newly built image
NEW_SHA=$($DOCKER_CMD inspect --format='{{.Id}}' $DOCKER_IMAGE:latest)

# Compare the SHA values
if [ "$LAST_SHA" == "$NEW_SHA" ]
then
    echo "New image has the same SHA value as the latest image. No new version tag will be added."
else
    # Generate a new version tag based on the current date and time
    VERSION=$(date +"%Y%m%d-%H%M%S")
    $DOCKER_CMD tag $DOCKER_IMAGE $DOCKER_IMAGE:$VERSION
    $DOCKER_CMD tag $DOCKER_IMAGE $DOCKER_IMAGE:latest
    echo "New image has a different SHA value than the latest image. New version tag $VERSION has been added."
fi

echo "Successfully built $DOCKER_IMAGE:$VERSION"
