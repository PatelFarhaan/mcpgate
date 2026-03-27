.PHONY: help up down clean build publish

REGISTRY   ?= ghcr.io/patelfarhaan
IMAGE      := mcpgate
TAG        ?= latest
FULL_IMAGE := $(REGISTRY)/$(IMAGE):$(TAG)

# ── Help ─────────────────────────────────────────────

help: ## Show all available commands
	@echo ""
	@echo "  MCPGate"
	@echo "  ────────────────────────────────────"
	@echo ""
	@echo "  Local:"
	@grep -E '^(up|down|clean):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[36mmake %-10s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "  CI:"
	@grep -E '^(build|publish):.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "    \033[36mmake %-10s\033[0m %s\n", $$1, $$2}'
	@echo ""

# ── Local ────────────────────────────────────────────

up: ## Start all services
	docker compose up -d
	@echo ""
	@echo "  MCPGate   → http://localhost:8001"
	@echo "  Postgres  → localhost:5434"
	@echo ""

down: ## Stop all services
	docker compose down

clean: ## Stop services and remove all volumes
	docker compose down -v

# ── CI ───────────────────────────────────────────────

build: ## Build production image (TAG=latest)
	docker build -t $(FULL_IMAGE) .

publish: build ## Build and push image to registry (TAG=latest)
	docker push $(FULL_IMAGE)
