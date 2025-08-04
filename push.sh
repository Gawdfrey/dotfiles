#!/bin/bash

echo "🚀 Pushing dotfiles to GitHub..."

# Add all changes
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "No changes to commit"
    exit 0
fi

# Commit with timestamp
git commit -m "Update dotfiles - $(date '+%Y-%m-%d %H:%M:%S')

🤖 Generated with Claude Code"

# Push to GitHub
git push origin main

echo "✅ Changes pushed successfully!"