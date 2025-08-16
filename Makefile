.PHONY: help install test analyze format clean build run docker-build docker-run

help: ## Show this help message
	@echo "Adventure Game - Available Commands:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	dart pub get

test: ## Run all tests
	dart test

analyze: ## Run static analysis
	dart analyze

format: ## Format code
	dart format .

build: ## Build the application
	dart compile exe bin/main.dart -o bin/adventure_game

run: ## Run the game
	dart run bin/main.dart

clean: ## Clean build artifacts
	rm -rf build/ .dart_tool/ coverage/
	rm -f bin/adventure_game

docker-build: ## Build Docker image
	docker build -t adventure-game:latest .

docker-run: ## Run game in Docker container
	docker run -it --rm adventure-game:latest

docker-clean: ## Clean Docker images and containers
	docker stop adventure-game || true
	docker rm adventure-game || true
	docker rmi adventure-game:latest || true

version: ## Show current version
	@echo "Current version: $(shell grep 'version:' pubspec.yaml | cut -d' ' -f2)"

tag: ## Create git tag from current version
	@version=$$(grep 'version:' pubspec.yaml | cut -d' ' -f2); \
	echo "Creating git tag v$$version"; \
	git tag v$$version; \
	echo "Tag v$$version created successfully"

tag-push: ## Create and push git tag
	@version=$$(grep 'version:' pubspec.yaml | cut -d' ' -f2); \
	echo "Creating and pushing git tag v$$version"; \
	git tag v$$version; \
	git push origin v$$version; \
	echo "Tag v$$version created and pushed successfully"

dev: install run ## Development workflow (install + run)

lint: analyze format ## Run linting (analyze + format)

.DEFAULT_GOAL := help
