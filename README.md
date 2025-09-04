# Mini CI with Docker-in-Docker (DinD)

A simple CI pipeline that builds, runs, and tests a Node.js app using Docker-in-Docker.

## 🚀 Quick Start

```bash
docker compose up --build
```

## 📦 What It Does

- Builds `myapp:ci` image inside DinD container
- Runs Node.js app with Hello World endpoint
- Tests with curl and shows results
- Cleans up automatically

## 📁 Structure

```
dind/
├── app/                 # Node.js app (Express server)
├── ci/run.sh           # CI pipeline script
├── docker-compose.yml  # DinD + CI runner services
└── README.md
```

## 🔧 Architecture

- **DinD**: `docker:dind` with privileged access
- **CI Runner**: `alpine:latest` with docker-cli + curl
- **Network**: Custom bridge for service communication

## 🐛 Debug

```bash
# Check logs
docker compose logs dind

# Interactive access
docker compose run --rm ci-runner sh

# Inspect images
docker compose exec dind docker images
```

## ✅ Requirements Met

All functional and non-functional requirements satisfied:
- DinD service with health checks
- Image built inside DinD (not host)
- App runs on private network
- Curl test with cleanup
- Single command execution
- Cross-platform compatibility
