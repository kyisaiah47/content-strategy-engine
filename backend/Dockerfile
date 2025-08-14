FROM python:3.11-slim

WORKDIR /app

# Copy and install requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Create startup script
COPY start.sh .
RUN chmod +x start.sh

# Expose port (Railway will set PORT env var)
EXPOSE $PORT

# Start the application
CMD ["./start.sh"]
