# ===== Stage 1: Builder =====
FROM python:3.11-slim AS builder
WORKDIR /app

COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# ===== Stage 2: Runner =====
FROM python:3.11-slim

WORKDIR /app

# Copy dependencies from builder
COPY --from=builder /root/.local /root/.local
ENV PATH=/root/.local/bin:$PATH

# Copy application code
COPY app.py .

# Set environment variables
ENV FLASK_ENV=production
ENV PORT=5000

EXPOSE 5000
CMD ["python", "app.py"]
