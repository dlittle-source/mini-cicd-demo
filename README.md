# Mini CI/CD Demo – Docker + AWS + GitHub Actions

A production-style **CI/CD pipeline demo** that builds, scans, pushes, and deploys a Dockerized Node.js application to an Amazon EC2 instance using Amazon ECR as the container registry.

This project is designed to demonstrate **real-world DevOps practices**, including security scanning, rollback mechanisms, concurrency control, and automated deployments.

---

## 🚀 Project Overview

This pipeline automates the following workflow:

1. **Build** a Docker image for a Node.js demo application
2. **Push** the image to **Amazon ECR**
3. **Scan** the image using **Trivy** (informational + gated security scans)
4. **Deploy** the image to an **EC2 instance** via SSH
5. **Rollback** automatically if deployment fails

---

## 🧱 Architecture

**High-level flow:**

Developer → GitHub → GitHub Actions → Amazon ECR → EC2 Instance → Docker Container

* GitHub Actions handles CI/CD
* Amazon ECR stores versioned Docker images
* EC2 runs the containerized application
* Trivy ensures container security

(Diagram included separately)

---

## 🛠️ Tech Stack

* **Application**: Node.js (Express)
* **Containerization**: Docker
* **CI/CD**: GitHub Actions
* **Container Registry**: Amazon ECR
* **Compute**: Amazon EC2 (Ubuntu)
* **Security Scanning**: Trivy
* **Deployment**: SSH-based Docker deployment

---

## 🔐 Security Scanning Strategy

The pipeline includes **two Trivy scans**:

### 1️⃣ Informational Scan (Non-blocking)

* Severity: `HIGH, CRITICAL`
* Purpose: Visibility and reporting
* Pipeline impact: **Never fails**

### 2️⃣ Gate Scan (Blocking)

* Severity: `CRITICAL`
* Purpose: Prevent high-risk deployments
* Pipeline impact: **Fails build if critical issues are found**

Scan reports are exported as **GitHub Actions artifacts**.

---

## 🔁 Rollback Mechanism

Before deploying a new image, the pipeline:

1. Captures the **currently running image digest**
2. Attempts to deploy the new image
3. If deployment fails:

   * Stops the failed container
   * Restarts the previous known-good image

This ensures **zero-downtime recovery** during failed releases.

---

## ⚙️ CI/CD Workflow Stages

1. **Build & Push**

   * Build Docker image
   * Tag with `latest` and commit SHA
   * Push to Amazon ECR

2. **Security Scan**

   * Trivy image scan
   * Artifact export

3. **Deploy**

   * SSH into EC2
   * Login to ECR
   * Pull latest image
   * Stop existing container
   * Start new container
   * Rollback on failure

4. **Concurrency Control**

   * Ensures only one deployment runs at a time
   * Automatically cancels in-progress deployments

---

## 📦 Demo Application

The deployed application is a simple Node.js frontend demo that confirms:

* Docker build success
* ECR image pull
* EC2 container deployment

Accessed via:

```
http://<EC2_PUBLIC_IP>
```

---

## 🧪 Prerequisites

* AWS Account
* EC2 Instance (Docker installed)
* Amazon ECR Repository
* GitHub Repository
* GitHub Secrets configured:

  * `AWS_ACCESS_KEY_ID`
  * `AWS_SECRET_ACCESS_KEY`
  * `AWS_REGION`
  * `ECR_REGISTRY`
  * `ECR_REPOSITORY`
  * `EC2_HOST`
  * `EC2_SSH_KEY`

---

## 📈 What This Project Demonstrates

✔ Real-world CI/CD pipeline design
✔ Secure container workflows
✔ AWS ECR integration
✔ Rollback-safe deployments
✔ Production-minded DevOps practices

---

## 🔮 Future Improvements

* Blue/Green deployments
* ECS or EKS migration (separate project)
* Slack / email notifications
* Terraform infrastructure provisioning

---

## 👤 Author

**Demarko Little**
Cloud & DevOps Engineer

---

## 📄 License

MIT License
