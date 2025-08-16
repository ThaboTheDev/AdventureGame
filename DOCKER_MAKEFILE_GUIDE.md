# 🐳 Docker & Makefile Guide

Quick guide for using Docker and Makefile with your Adventure Game.

## 🚀 Quick Start

```bash
# Show all commands
make help

# Quick development
make dev

# Build and run with Docker
make docker-build
make docker-run
```

## 📋 Makefile Commands

- `make install` - Install dependencies
- `make test` - Run tests
- `make analyze` - Static analysis
- `make format` - Format code
- `make build` - Build executable
- `make run` - Run the game
- `make clean` - Clean build files
- `make docker-build` - Build Docker image
- `make docker-run` - Run in Docker
- `make docker-clean` - Clean Docker
- `make version` - Show version
- `make tag` - Create git tag
- `make tag-push` - Create and push git tag
- `make dev` - Install + run
- `make lint` - Analyze + format

## 🐳 Docker Commands

```bash
# Build image
docker build -t adventure-game:latest .

# Run container
docker run -it --rm adventure-game:latest

# Using Docker Compose
docker-compose up
docker-compose down
```

## 📁 Files

- `Dockerfile` - Production Docker image
- `docker-compose.yml` - Docker Compose setup
- `.dockerignore` - Docker ignore rules
- `Makefile` - Development automation

## 🎯 Benefits

- **Consistency**: Same commands everywhere
- **Simplicity**: Easy to use and understand
- **Portability**: Run anywhere with Docker
- **Automation**: Common tasks simplified

---

**Ready to play! 🎮**
