#!/bin/bash
# Complete GitHub Deploy Script for Jarvis Dashboard
# Run this in Terminal after creating repo

REPO_URL="https://github.com/madiarineta/jarvis-dashboard"
LOCAL_PATH="$HOME/.openclaw/workspace/mini-app"

echo "🚀 Jarvis Dashboard GitHub Deploy"
echo "================================"
echo ""

# Step 1: Check if gh CLI is installed
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI found"
    
    # Check auth status
    if gh auth status &> /dev/null; then
        echo "✅ Already authenticated"
    else
        echo "🔐 Authenticating with GitHub..."
        gh auth login --web
    fi
    
    # Create repo if doesn't exist
    echo "📁 Checking repository..."
    if ! gh repo view madiarineta/jarvis-dashboard &> /dev/null; then
        echo "Creating repository..."
        gh repo create jarvis-dashboard --public --source="$LOCAL_PATH" --push
    else
        echo "Repository exists, pushing code..."
        cd "$LOCAL_PATH"
        git push -u origin main
    fi
    
else
    echo "⚠️  GitHub CLI not found. Using manual method..."
    echo ""
    echo "Step 1: Create repo at https://github.com/new"
    echo "   Name: jarvis-dashboard"
    echo "   Visibility: Public"
    echo ""
    echo "Step 2: Upload files:"
    echo "   Go to: https://github.com/madiarineta/jarvis-dashboard/upload"
    echo "   Drag and drop: $HOME/jarvis-dashboard-deploy.zip"
    echo "   Or extract and upload index.html directly"
    echo ""
    echo "Step 3: Enable Pages:"
    echo "   Go to: https://github.com/madiarineta/jarvis-dashboard/settings/pages"
    echo "   Source: Deploy from a branch → main → / (root)"
    echo ""
    
    # Open browser for manual setup
    open "https://github.com/new"
fi

echo ""
echo "📝 After deployment:"
echo "   BotFather: /setmenubutton"
echo "   URL: https://madiarineta.github.io/jarvis-dashboard/"
