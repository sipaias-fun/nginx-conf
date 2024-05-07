#!/bin/bash

# Function to check if sipaias_web service is ready
wait_for_sipaias_web() {
    until $(curl --output /dev/null --silent --head --fail http://sipaias_web:3000); do
        echo "Waiting for sipaias_web service to be ready..."
        sleep 2
    done
}

# Check if sipaias_web service is ready before starting NGINX
wait_for_sipaias_web

# Start NGINX
exec "$@"
