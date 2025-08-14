#!/bin/bash
echo "Starting Contentr API on port $PORT"
uvicorn app.main:app --host 0.0.0.0 --port $PORT
