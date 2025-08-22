#!/bin/bash

echo "building the images..."

if [ "$BRANCH_NAME" = "dev" ]; then
    docker build -t final-dev:latest .
elif [ "$BRANCH_NAME" = "master" ]; then
    docker build -t final-prod:latest .
fi