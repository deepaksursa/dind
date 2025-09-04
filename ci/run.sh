#!/bin/sh
set -e

echo "🚀 Starting CI Pipeline..."

# Clean up any existing containers
docker rm -f myapp-container 2>/dev/null || true

# Wait for DinD to be ready
until docker info >/dev/null 2>&1; do sleep 2; done
echo "✅ DinD ready"

# Build the application image
docker build -t myapp:ci /app
echo "✅ Image built"

# Run the application container with port mapping
docker run -d --name myapp-container -p 3000:3000 myapp:ci
echo "✅ Container started"

# Wait for the application to be ready
echo "⏳ Waiting for application to be ready..."
sleep 10

# Check if container is running
if ! docker ps | grep -q myapp-container; then
  echo "❌ Container is not running"
  docker logs myapp-container
  exit 1
fi

# Simple health check - just test if we can reach the app
echo "🧪 Testing application directly..."
for i in $(seq 1 30); do
  if docker run --rm --network container:myapp-container curlimages/curl:8.11.1 -fsS http://localhost:3000/health >/dev/null 2>&1; then
    echo "✅ Application is ready!"
    break
  fi
  if [ $i -eq 30 ]; then
    echo "❌ Application not ready after 30 attempts"
    docker logs myapp-container
    exit 1
  fi
  sleep 1
done

# Test the application using the same network namespace
echo "🧪 Testing application..."
docker run --rm --network container:myapp-container curlimages/curl:8.11.1 -fsS http://localhost:3000/ | head -3
echo "✅ Test passed! Application is reachable"

# Show running containers
echo "📋 Running containers:"
docker ps

# Clean up
docker rm -f myapp-container
echo "✅ Cleanup completed"

echo "🎉 CI Pipeline completed successfully!"