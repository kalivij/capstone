#!/bin/bash

if [[ "$GIT_BRANCH" == "dev" ]]; then
    echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
    docker tag "reactapp:$image_version" "$DOCKER_REPO:$DOCKER_TAG"
    docker push "$DOCKER_REPO:$DOCKER_TAG"
    docker logout
elif [[ "$GIT_BRANCH" == "master" ]]; then
    echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
    docker tag "reactapp:$image_version" "$DOCKER_REPO:$DOCKER_TAG"
    docker push "$DOCKER_REPO:$DOCKER_TAG"
    docker logout
fi
