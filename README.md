# Mini CI/CD Pipeline with Docker, Trivy, Amazon ECR, and EC2

This project demonstrates a production-style CI/CD pipeline that builds, scans, and deploys a Dockerized Node.js application to an EC2 instance using GitHub Actions and Amazon ECR, with security scanning and rollback support.

---

## Tech Stack

- Node.js (demo application)
- Docker
- GitHub Actions
- Amazon ECR
- Amazon EC2
- Trivy (container security scanning)
- Nginx (host-level web server)

---

## CI/CD Pipeline Overview

1. Code is pushed to the `main` branch
2. GitHub Actions builds a Docker image
3. Image is pushed to Amazon ECR
4. Trivy scans the image for vulnerabilities
5. CRITICAL vulnerabilities block deployment
6. Image is deployed to EC2 via SSH
7. Rollback is triggered automatically on failure

---

## Rollback Strategy

Before deploying a new container, the pipeline records the currently running
image digest. If the new deployment fails, the pipeline automatically rolls
back to the previously known-good image to prevent downtime.


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
