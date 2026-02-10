# Mini CI/CD Demo – Docker + AWS + GitHub Actions

A production-style CI/CD pipeline demo that builds, scans, pushes, and deploys a Dockerized Node.js application to an Amazon EC2 instance using Amazon ECR as the container registry.
This project is designed to demonstrate real-world DevOps practices, including security scanning, rollback mechanisms, concurrency control, and automated deployments.

# Project Overview

This pipeline automates the following workflow:
1. Build a Docker image for a Node.js demo application
2. Push the image to Amazon ECR
3. Scan the image using Trivy (informational + gated security scans)
4. Deploy the image to an EC2 instance via SSH
5. Rollback automatically if deployment fails

## Demo App
- `/` → Web UI
- `/health` → Health check endpoint

## Pipeline Stages
1. Build
2. Test
3. Security Scan
4. Deploy

This project is intentionally small to focus on CI/CD, security, and deployment best practices.
