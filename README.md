# Mini CI/CD Demo – Docker, ECR, Trivy, EC2

## 📌 Project Overview

This project demonstrates a **production-style CI/CD pipeline** for a containerized Node.js application using **GitHub Actions**, **Docker**, **Amazon ECR**, **EC2**, and **Trivy security scanning**.

The pipeline automatically:
- Builds a Docker image
- Scans the image for vulnerabilities
- Pushes the image to Amazon ECR
- Deploys the container to an EC2 instance
- Supports rollback on deployment failure

This project was built to showcase **real-world DevOps practices** suitable for freelance work and production environments.

---

## 🛠 Tech Stack

- **Application**: Node.js (Express)
- **CI/CD**: GitHub Actions
- **Containerization**: Docker
- **Container Registry**: Amazon ECR
- **Deployment Target**: Amazon EC2
- **Security Scanning**: Trivy
- **Web Server**: Dockerized Node.js app
- **Cloud Provider**: AWS

---

## 🏗 Architecture Overview

![Architecture Diagram](diagrams/architecture.png)

### Flow:
1. Developer pushes code to GitHub
2. GitHub Actions triggers the CI/CD pipeline
3. Docker image is built
4. Image is scanned with Trivy
5. Image is pushed to Amazon ECR
6. EC2 pulls the latest image and runs the container
7. Application is accessible via browser

---

## 🔁 CI/CD Pipeline Stages

### 1️⃣ Build & Push
- Builds Docker image
- Tags image with `latest` and commit SHA
- Pushes image to Amazon ECR

### 2️⃣ Security Scan
- Trivy scans Docker image
- Informational scan for HIGH & CRITICAL
- Gate scan blocks only CRITICAL vulnerabilities
- Scan reports exported as GitHub artifacts

### 3️⃣ Deploy & Rollback
- Pulls latest image from ECR
- Stops existing container safely
- Starts new container
- Automatically rolls back if deployment fails

---

## 🔐 Security Scanning Strategy

This pipeline follows a **balanced security approach**:

| Severity | Behavior |
|--------|----------|
| HIGH | Logged (non-blocking) |
| CRITICAL | Blocks deployment |

This ensures security visibility **without slowing development**.

---

## 🚀 Deployment & Rollback Logic

- Deployment occurs over SSH to EC2
- Existing container image digest is saved
- If the new container fails:
- Previous image is restored automatically
- Service downtime is minimized

This simulates **real production rollback behavior**.

---

## ▶️ Run Locally

```bash
docker build -t mini-cicd-demo .
docker run -p 3000:3000 mini-cicd-demo

Visit
http://localhost:3000

