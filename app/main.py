from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def root():
    return {
        "message": "Welcome to Notification Service!",
        "version": "0.1.0",
        "status": "running"
    }

@app.get("/health")
def health():
    return {
        "status": "healthy",
        "service": "Notification Service",
        "environment": "development"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8001)
