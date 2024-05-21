#!/bin/bash
echo "DAMN";
# Function to check if a service is ready
wait_for_service() {
    local service_url=$1
    until $(curl --output /dev/null --silent --head --fail "$service_url"); do
        echo "Waiting for $service_url to be ready..."
        sleep 2
    done
}

# Check if sipaias_web and express services are ready before starting NGINX
wait_for_service "http://sipaias_web:3000"
wait_for_service "http://express:5000"

# Start NGINX
exec "$@"
