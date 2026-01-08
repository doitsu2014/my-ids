# CLAUDE.MD - My IDS Project Guide

## Project Overview

This repository contains **My IDS** - an Identity Server solution based on Skoruba's IdentityServer4.Admin template. The project provides a complete identity and access management system with administrative interfaces and APIs.

## Architecture

### Components

The project consists of three main services:

1. **IDS Admin** - Administrative UI for managing identity resources
   - Dockerfile: `services/IdentityServer.Admin.Dockerfile`
   - Workflow: `.github/workflows/docker_build_ids_admin.yml`

2. **IDS Admin API** - REST API for administrative operations
   - Dockerfile: `services/IdentityServer.Admin.Api.Dockerfile`
   - Workflow: `.github/workflows/docker_build_ids_admin_api.yml`

3. **IDS STS** (Security Token Service) - Core authentication server
   - Dockerfile: `services/IdentityServer.Api.Dockerfile`
   - Workflow: `.github/workflows/docker_build_ids_sts.yml`

### Technology Stack

- **Framework**: .NET 9 (Microservices.Ids.sln)
- **Authentication**: Duende IdentityServer
- **Containerization**: Docker
- **Orchestration**: Kubernetes (Helm charts available)
- **CI/CD**: GitHub Actions

## Repository Structure

```
my-ids/
├── services/           # Main service implementations
│   ├── src/           # Source code
│   ├── *.Dockerfile   # Docker build files
│   └── Microservices.Ids.sln
├── charts/            # Helm charts for Kubernetes deployment
├── deployments/       # Deployment configurations
├── docs/              # Documentation
├── .github/           # GitHub Actions workflows
└── index.yaml         # Helm repository index
```

## Development Setup

### Prerequisites

- .NET 9 SDK or later
- Docker and Docker Compose
- kubectl (for Kubernetes deployments)
- Helm 3 (for chart deployments)

### Building Services

From the `services/` directory:

```bash
# Build all services
dotnet build Microservices.Ids.sln

# Build specific project
dotnet build src/<ProjectName>/<ProjectName>.csproj
```

### Docker Build

```bash
# Use the helper script
cd services
./docker-build.sh

# Or build individual services
docker build -f services/IdentityServer.Admin.Dockerfile -t ids-admin .
docker build -f services/IdentityServer.Admin.Api.Dockerfile -t ids-admin-api .
docker build -f services/IdentityServer.Api.Dockerfile -t ids-sts .
```

## Deployment

### Helm Chart Deployment

The project includes Helm charts for Kubernetes deployment:

```bash
# Install from local charts
helm install my-ids ./charts/<chart-name>

# Or from Helm repository
helm repo add my-ids https://doitsu2014.github.io/my-ids/
helm install my-ids my-ids/<chart-name>
```

## CI/CD

### GitHub Actions Workflows

The project uses GitHub Actions for automated builds:

- **IDS Admin Build**: Builds and pushes admin UI Docker image
- **IDS Admin API Build**: Builds and pushes admin API Docker image
- **IDS STS Build**: Builds and pushes STS Docker image

All workflows trigger on:
- Push to main branch
- Pull requests to main branch

## Working with Claude Code

### Common Tasks

**Building the solution:**
```bash
cd services
dotnet build
```

**Running tests:**
```bash
cd services
dotnet test
```

**Updating Helm charts:**
```bash
cd charts
# Make changes to chart values or templates
helm package <chart-name>
helm repo index .
```

**Checking service status:**
```bash
# Docker containers
docker ps | grep ids

# Kubernetes pods
kubectl get pods -l app=ids
```

### Key Files to Know

- `services/Microservices.Ids.sln` - Main solution file
- `services/src/` - Service source code
- `charts/` - Helm deployment charts
- `.github/workflows/` - CI/CD pipeline definitions

## Notes

- The project follows microservices architecture
- Each service has its own Dockerfile for independent deployment
- Helm charts enable easy Kubernetes deployment and configuration management
- GitHub Actions handle automated building and publishing of Docker images
- **Upgraded to .NET 9**: All projects target .NET 9 with updated package dependencies

## Resources

- [Duende IdentityServer Documentation](https://docs.duendesoftware.com/identityserver/v7/)
- [Skoruba Duende IdentityServer Admin](https://github.com/skoruba/Duende.IdentityServer.Admin)
- [.NET 9 Documentation](https://learn.microsoft.com/en-us/dotnet/core/whats-new/dotnet-9/overview)
- Project README: `README.md`
- Service README: `services/README.md`

---

*This file is maintained for use with Claude Code to provide context about the project structure and common operations.*
