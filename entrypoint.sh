#!/bin/bash
# Wait for PostgreSQL to be ready
echo "Waiting for postgres..."
while ! nc -z postgres 5432; do
  sleep 0.5
done
echo "PostgreSQL started"

# Run migrations
python manage.py migrate --noinput

# Run passed CMD
exec "$@"
