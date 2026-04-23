FROM python:3.12-alpine

WORKDIR /app

ARG CODEARTIFACT_INDEX_URL
ARG CODEARTIFACT_TOKEN

COPY requirements.txt .
RUN if [ -n "$CODEARTIFACT_INDEX_URL" ]; then \
      pip config set global.index-url "https://aws:${CODEARTIFACT_TOKEN}@${CODEARTIFACT_INDEX_URL#https://}"; \
    fi && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["python", "app/main.py"]
