#!/bin/bash

echo "Deploying the images..."

docker compose down
docker compose up -d

echo "Deployment completed successfully."