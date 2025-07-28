# Start from official Python image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create and set working directory
WORKDIR /UK_MEDICAL_BOT

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    netcat-openbsd \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy entrypoint and make executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy rest of the project
COPY . .

# Collect static files
RUN python manage.py collectstatic --noinput

# Expose default ASGI port
EXPOSE 8000

# Default command (overridden by docker-compose)
CMD ["uvicorn", "uk_medical_bot.asgi:application", "--host", "0.0.0.0", "--port", "8000"]




# #start from original python image
# FROM python:3.11-slim

# #set environment variables
# ENV PYTHONDONTWRITEBYTECODE=1
# ENV PYTHONUNBUFFERED=1

# # Create working directory
# WORKDIR /DIRECTORY

# # Install OS dependencies
# RUN apt-get update && apt-get install -y \
#     build-essential \
#     libpq-dev \
#     curl \
#     && rm -rf /var/lib/apt/lists/*

# # Install python dependencies
# COPY requirements.txt .
# # RUN pip install -r requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt
# COPY entrypoint.sh ./entrypoint.sh
# RUN chmod +x ./entrypoint.sh

# RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*


# # Copy project files
# COPY . .

# # Collect static files (Optional for production)
# RUN python manage.py collectstatic --noinput

# # Expose port 8000
# EXPOSE 8000

# # Default command (can be overridden in docker-compose)
# CMD ["uvicorn", "uk_medical_bot.asgi:application", "--host", "0.0.0.0", "--port", "8000"]