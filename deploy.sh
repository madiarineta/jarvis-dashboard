#!/bin/bash
# Deploy Jarvis Mini App to GitHub Pages

REPO_URL="https://github.com/madiarineta/jarvis-dashboard"

echo "🚀 Deploying Jarvis Dashboard to GitHub Pages..."

cd ~/.openclaw/workspace/mini-app

# Check if remote exists
if ! git remote | grep -q origin; then
    echo "Adding remote: $REPO_URL"
    git remote add origin $REPO_URL.git
fi

# Push to GitHub
echo "Pushing to GitHub..."
git push -u origin main

echo ""
echo "✅ Code pushed!"
echo ""
echo "Next steps (manual):"
echo "1. Go to: https://github.com/madiarineta/jarvis-dashboard/settings/pages"
echo "2. Under 'Source', select: Deploy from a branch"
echo "3. Select branch: main, folder: / (root)"
echo "4. Click Save"
echo ""
echo "Your Mini App will be live at:"
echo "https://madiarineta.github.io/jarvis-dashboard/"
echo ""
echo "Then in BotFather: /setmenubutton and paste that URL"
