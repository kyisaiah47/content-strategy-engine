#!/bin/bash

# Wait for database to be ready (optional)
echo "Starting Contentr API..."

# Run database migrations if needed
# python -m alembic upgrade head

# Start the FastAPI server
exec uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
