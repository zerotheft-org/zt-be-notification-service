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
