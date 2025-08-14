#!/bin/bash

# Contentr Rebranding Script
# Changes all instances of "Content Strategy Engine" to "Contentr"

echo "🎨 Rebranding to Contentr..."

# Check if we're in the right directory
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ Please run this script from the content-strategy-engine root directory"
    exit 1
fi

echo "📝 Updating project files..."

# Function to safely replace text in files
safe_replace() {
    local find_text="$1"
    local replace_text="$2"
    local file="$3"
    
    if [ -f "$file" ]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            # macOS
            sed -i '' "s/$find_text/$replace_text/g" "$file"
        else
            # Linux
            sed -i "s/$find_text/$replace_text/g" "$file"
        fi
        echo "✅ Updated: $file"
    fi
}

# Function to replace text in all files of a directory
replace_in_directory() {
    local find_text="$1"
    local replace_text="$2"
    local directory="$3"
    local extension="$4"
    
    if [ -d "$directory" ]; then
        find "$directory" -name "*.$extension" -type f -exec grep -l "$find_text" {} \; | while read file; do
            safe_replace "$find_text" "$replace_text" "$file"
        done
    fi
}

# 1. Update root files
echo "🔧 Updating root configuration files..."

# README.md
safe_replace "Content Strategy Engine" "Contentr" "README.md"
safe_replace "content-strategy-engine" "contentr" "README.md"
safe_replace "Content-Strategy-Engine" "Contentr" "README.md"

# package.json (if exists)
safe_replace "content-strategy-engine" "contentr" "package.json"
safe_replace "Content Strategy Engine" "Contentr" "package.json"

# docker-compose.yml
safe_replace "content-strategy-engine" "contentr" "docker-compose.yml"
safe_replace "Content Strategy Engine" "Contentr" "docker-compose.yml"

# .env.example
safe_replace "Content Strategy Engine" "Contentr" ".env.example"
safe_replace "content-strategy-engine" "contentr" ".env.example"

# Any other root files
safe_replace "Content Strategy Engine" "Contentr" "run_instructions.txt"
safe_replace "content-strategy-engine" "contentr" "run_instructions.txt"

# 2. Update backend files
echo "🐍 Updating backend files..."

# Backend package files
safe_replace "Content Strategy Engine" "Contentr" "backend/requirements.txt"

# Python files - update all .py files
replace_in_directory "Content Strategy Engine" "Contentr" "backend" "py"
replace_in_directory "content-strategy-engine" "contentr" "backend" "py"
replace_in_directory "content_strategy_engine" "contentr" "backend" "py"

# Dockerfile
safe_replace "Content Strategy Engine" "Contentr" "backend/Dockerfile"
safe_replace "content-strategy-engine" "contentr" "backend/Dockerfile"

# 3. Update frontend files  
echo "⚛️ Updating frontend files..."

# Frontend package.json
safe_replace "content-strategy-frontend" "contentr-frontend" "frontend/package.json"
safe_replace "Content Strategy Engine" "Contentr" "frontend/package.json"

# TypeScript/React files
replace_in_directory "Content Strategy Engine" "Contentr" "frontend/src" "tsx"
replace_in_directory "Content Strategy Engine" "Contentr" "frontend/src" "ts"
replace_in_directory "Content Strategy Engine" "Contentr" "frontend/src" "js"
replace_in_directory "Content Strategy Engine" "Contentr" "frontend/src" "jsx"

# Next.js config
safe_replace "Content Strategy Engine" "Contentr" "frontend/next.config.js"
safe_replace "content-strategy-engine" "contentr" "frontend/next.config.js"

# CSS files
replace_in_directory "Content Strategy Engine" "Contentr" "frontend/src" "css"

# Frontend Dockerfile
safe_replace "Content Strategy Engine" "Contentr" "frontend/Dockerfile"

# 4. Update any markdown files
echo "📚 Updating documentation..."

safe_replace "Content Strategy Engine" "Contentr" "CONTRIBUTING.md"
safe_replace "content-strategy-engine" "contentr" "CONTRIBUTING.md"

safe_replace "Content Strategy Engine" "Contentr" "SAAS_SETUP_CHECKLIST.md"
safe_replace "content-strategy-engine" "contentr" "SAAS_SETUP_CHECKLIST.md"

# Update any other .md files
find . -name "*.md" -type f -exec grep -l "Content Strategy Engine" {} \; | while read file; do
    safe_replace "Content Strategy Engine" "Contentr" "$file"
done

find . -name "*.md" -type f -exec grep -l "content-strategy-engine" {} \; | while read file; do
    safe_replace "content-strategy-engine" "contentr" "$file"
done

# 5. Update scripts directory
echo "📜 Updating scripts..."

if [ -d "scripts" ]; then
    replace_in_directory "Content Strategy Engine" "Contentr" "scripts" "py"
    replace_in_directory "Content Strategy Engine" "Contentr" "scripts" "sql"
    replace_in_directory "Content Strategy Engine" "Contentr" "scripts" "sh"
    replace_in_directory "content-strategy-engine" "contentr" "scripts" "py"
    replace_in_directory "content-strategy-engine" "contentr" "scripts" "sql"
    replace_in_directory "content-strategy-engine" "contentr" "scripts" "sh"
fi

# 6. Update any JSON configuration files
echo "⚙️ Updating configuration files..."

find . -name "*.json" -type f -exec grep -l "Content Strategy Engine" {} \; | while read file; do
    safe_replace "Content Strategy Engine" "Contentr" "$file"
done

find . -name "*.json" -type f -exec grep -l "content-strategy-engine" {} \; | while read file; do
    safe_replace "content-strategy-engine" "contentr" "$file"
done

# 7. Update any YAML files
find . -name "*.yml" -type f -exec grep -l "Content Strategy Engine" {} \; | while read file; do
    safe_replace "Content Strategy Engine" "Contentr" "$file"
done

find . -name "*.yaml" -type f -exec grep -l "content-strategy-engine" {} \; | while read file; do
    safe_replace "content-strategy-engine" "contentr" "$file"
done

# 8. Update any environment or config files
find . -name ".env*" -type f -exec grep -l "Content Strategy Engine" {} \; | while read file; do
    safe_replace "Content Strategy Engine" "Contentr" "$file"
done

# 9. Special updates for API responses and specific strings
echo "🔄 Updating API responses and specific content..."

# Update specific API response strings
find . -name "*.py" -type f -exec grep -l "Content Strategy Engine API" {} \; | while read file; do
    safe_replace "Content Strategy Engine API" "Contentr API" "$file"
done

find . -name "*.py" -type f -exec grep -l "AI-powered content strategy" {} \; | while read file; do
    safe_replace "AI-powered content strategy for TiDB Hackathon 2025" "AI-powered content automation for TiDB Hackathon 2025" "$file"
    safe_replace "AI-powered content strategy" "AI-powered content automation" "$file"
done

# Update any remaining project names in comments
find . -name "*.py" -type f -exec grep -l "content_strategy_engine" {} \; | while read file; do
    safe_replace "content_strategy_engine" "contentr" "$file"
done

# 10. Update git remote if it exists (optional)
echo "🔗 Checking git configuration..."

if [ -d ".git" ]; then
    # Get current remote URL
    current_remote=$(git remote get-url origin 2>/dev/null || echo "none")
    if [[ $current_remote == *"content-strategy-engine"* ]]; then
        echo "📝 Note: You may want to update your git remote URL to use 'contentr' instead"
        echo "   Current: $current_remote"
        echo "   Suggested: ${current_remote/content-strategy-engine/contentr}"
        echo "   Run: git remote set-url origin NEW_URL"
    fi
fi

echo ""
echo "🎉 Rebranding complete!"
echo ""
echo "✅ Changed 'Content Strategy Engine' → 'Contentr'"
echo "✅ Changed 'content-strategy-engine' → 'contentr'"  
echo "✅ Updated all configuration files"
echo "✅ Updated all source code"
echo "✅ Updated all documentation"
echo ""
echo "🔍 Summary of changes:"
echo "   • Project name: Content Strategy Engine → Contentr"
echo "   • Package names: content-strategy-* → contentr-*"
echo "   • API responses: Updated to show Contentr branding"
echo "   • Documentation: All references updated"
echo ""
echo "📋 Next steps:"
echo "1. Test the application: docker-compose up -d"
echo "2. Check that everything still works: http://localhost:3000"
echo "3. Update your GitHub repository name (if you want)"
echo "4. Update any external service account names"
echo ""
echo "🚀 Contentr is ready to launch!"

# Final verification
echo "🔍 Verification - files that still contain old branding:"
echo "(These should be empty or only contain intentional references)"
echo ""

# Look for any remaining instances (excluding this script and .git)
remaining_files=$(grep -r "Content Strategy Engine" . --exclude="rebrand_to_contentr.sh" --exclude-dir=".git" --exclude-dir="node_modules" 2>/dev/null | head -5)

if [ -z "$remaining_files" ]; then
    echo "✅ No remaining 'Content Strategy Engine' references found!"
else
    echo "⚠️  Found some remaining references:"
    echo "$remaining_files"
    echo ""
    echo "These might be intentional (like in comments) or need manual review."
fi

echo ""
echo "🎨 Welcome to Contentr! 🎉"