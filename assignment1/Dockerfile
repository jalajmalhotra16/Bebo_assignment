FROM python:3.9-slim

# Install Kubernetes client library
RUN pip install kubernetes

# Copy the script into the Docker image
COPY clean_final.py  /app/cleanup.py

# Set the working directory
WORKDIR /app

# Run the cleanup script
CMD ["python3", "cleanup.py"]
