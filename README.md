# zt-be-notification-service

Notification Service for the ZeroTheft platform.

## Local Development

```bash
pip install -r requirements.txt
python app/main.py
```

## Docker

```bash
docker build -t zt-be-notification-service .
docker run -p 8001:8001 zt-be-notification-service
```

- **Port:** 8001
- **Health Check:** `GET /health`
- **Root Endpoint:** `GET /`

---

## CI/CD Pipeline

Every push to `main` (and every pull request) triggers the full CI pipeline defined in `.github/workflows/ci.yml`.

### Pipeline Stages

1. **Security Scans** (parallel)
   - Secret scanning with Gitleaks
   - SAST with Semgrep
   - Dependency vulnerability & license scanning with Trivy

2. **Backend CI**
   - Lint with `flake8`
   - Run `pytest` tests

3. **Docker Build, Scan & Push**
   - Smoke-test private dependencies from AWS CodeArtifact
   - Build Docker image with private pip index
   - Scan image with Trivy (HIGH/CRITICAL vulnerability gate)
   - Push to Amazon ECR

### ECR Registry

```
744561091152.dkr.ecr.us-east-1.amazonaws.com/zt/notification-service
```

Images are tagged with an immutable `gitsha-<short-sha>`. Feature branches also get a `<branch>-latest` floating tag.

### Shared Dependencies

This service consumes the `common` package from our private AWS CodeArtifact repository:

```text
# requirements.txt
common>=0.1.0
```

- **CodeArtifact Domain:** `zt`
- **Repository:** `zt-python`
- **Account:** Shared-Services (`744561091152`)

The CI pipeline automatically authenticates to CodeArtifact and injects the private pip index into the Docker build. No manual setup is required.

For more details on developing with shared packages, see:
- [zt-plat-python-sdk README](https://github.com/zerotheft-org/zt-plat-python-sdk/blob/main/README.md)
- [CI/CD Developer Guide](../../docs/ci-cd-developer-guide.md)

<!-- CI trigger: 2026-05-01T04:06:40Z -->
