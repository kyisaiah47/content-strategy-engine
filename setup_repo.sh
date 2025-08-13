#!/bin/bash

# Content Strategy Engine Repository Setup Script
# Run this script to create the complete repository structure

echo "🚀 Setting up Content Strategy Engine repository..."

# Create root directory
mkdir -p content-strategy-engine
cd content-strategy-engine

# Initialize git
git init

# Create directory structure
echo "📁 Creating directory structure..."
mkdir -p backend/app/{database,services,api/routes,workers,utils}
mkdir -p backend/scripts
mkdir -p frontend/src/app
mkdir -p frontend/src/components/{dashboard,ui,layout}
mkdir -p frontend/src/{lib,hooks}
mkdir -p docs
mkdir -p scripts

# Create .gitignore
echo "📝 Creating .gitignore..."
cat > .gitignore << 'EOF'
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
venv/
env/
ENV/
.venv/
.env
.env.local
.env.production
*.egg-info/
dist/
build/

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
.next/
out/
.vercel/

# Database
*.db
*.sqlite3

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
logs/
*.log

# Docker
.dockerignore
EOF

# Create LICENSE (MIT)
echo "📄 Creating LICENSE..."
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2025 Content Strategy Engine

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# Create package.json for root (optional)
echo "📦 Creating root package.json..."
cat > package.json << 'EOF'
{
  "name": "content-strategy-engine",
  "version": "1.0.0",
  "description": "AI-powered content strategy engine for TiDB AgentX Hackathon 2025",
  "private": true,
  "workspaces": ["frontend"],
  "scripts": {
    "dev": "concurrently \"npm run dev:backend\" \"npm run dev:frontend\"",
    "dev:backend": "cd backend && uvicorn app.main:app --reload",
    "dev:frontend": "cd frontend && npm run dev",
    "setup": "cd backend && pip install -r requirements.txt && cd ../frontend && npm install",
    "docker:up": "docker-compose up -d",
    "docker:down": "docker-compose down"
  },
  "devDependencies": {
    "concurrently": "^8.2.0"
  },
  "keywords": ["ai", "content-strategy", "tidb", "hackathon", "automation"],
  "author": "Your Name",
  "license": "MIT"
}
EOF

echo "✅ Repository structure created!"
echo ""
echo "📋 Next steps:"
echo "1. Copy the files from the artifact into their respective directories"
echo "2. cd content-strategy-engine"
echo "3. Create GitHub repository and push:"
echo "   git add ."
echo "   git commit -m 'Initial commit: Content Strategy Engine'"
echo "   git branch -M main"
echo "   git remote add origin https://github.com/yourusername/content-strategy-engine.git"
echo "   git push -u origin main"
echo ""
echo "🎯 Repository ready for TiDB AgentX Hackathon 2025!"
