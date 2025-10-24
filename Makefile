.PHONY: build run stop clean test

# Build the application
build:
	go install ./cmd/mcp-server

# Run the application
run: build
	$(GOPATH)/bin/mcp-server

# Stop the application (kills all mcp-server processes)
stop:
	@echo "Stopping MCP server..."
	@pkill -f "mcp-server" || echo "No mcp-server processes found"
	@echo "MCP server stopped"

# Clean build artifacts
clean:
	rm -f $(GOPATH)/bin/mcp-server

# Run tests
test:
	go test ./...

# Install dependencies
deps:
	go mod download
	go mod tidy

# Development server with auto-restart (requires air)
dev:
	air -c .air.toml

# Format code
fmt:
	go fmt ./...

# Lint code (requires golangci-lint)
lint:
	golangci-lint run

# Check for vulnerabilities (requires govulncheck)
vuln:
	govulncheck ./...