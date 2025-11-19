FROM python:3.12-slim-bullseye

WORKDIR /application

# Optional system dependencies (remove gcc if not needed)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Add Gunicorn to requirements automatically if not already included
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Expose API port
EXPOSE 5000


# Command to run your app
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "4", "--timeout", "120", "application:app"]

