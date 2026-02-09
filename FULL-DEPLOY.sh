#!/bin/bash
# FULL AUTO DEPLOY - Jarvis Dashboard to GitHub Pages
# This script handles everything including browser automation guidance

set -e

REPO_NAME="jarvis-dashboard"
GITHUB_USER="madiarineta"
LOCAL_PATH="$HOME/.openclaw/workspace/mini-app"
ZIP_PATH="$HOME/jarvis-dashboard-deploy.zip"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     🤖 JARVIS DASHBOARD - COMPLETE DEPLOY SYSTEM         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_step() {
    echo -e "${BLUE}▶${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Step 1: Prepare deployment package
print_step "Preparing deployment package..."
cd "$LOCAL_PATH"
zip -q -r "$ZIP_PATH" . -x "*.git*" -x "*.zip"
print_success "Package ready: $ZIP_PATH (10KB)"

# Step 2: Check for GitHub CLI
if command -v gh &> /dev/null; then
    print_success "GitHub CLI detected"
    
    # Check authentication
    if gh auth status &> /dev/null; then
        print_success "GitHub authenticated"
        
        # Check if repo exists
        if gh repo view "$GITHUB_USER/$REPO_NAME" &> /dev/null; then
            print_warning "Repository already exists"
            print_step "Pushing latest code..."
            cd "$LOCAL_PATH"
            git add -A 2>/dev/null || true
            git commit -m "Update dashboard" 2>/dev/null || true
            git push origin main
            print_success "Code updated!"
        else
            print_step "Creating repository..."
            gh repo create "$REPO_NAME" --public --source="$LOCAL_PATH" --push
            print_success "Repository created!"
        fi
        
        # Enable Pages via API
        print_step "Enabling GitHub Pages..."
        gh api -X POST "repos/$GITHUB_USER/$REPO_NAME/pages" \
            -f source='{"branch":"main","path":"/"}' 2>/dev/null || {
            print_warning "Pages API call failed, manual enable needed"
        }
        
        DEPLOY_URL="https://$GITHUB_USER.github.io/$REPO_NAME/"
        
    else
        print_warning "GitHub CLI not authenticated"
        USE_MANUAL=true
    fi
else
    print_warning "GitHub CLI not installed"
    USE_MANUAL=true
fi

# Step 3: Manual method with guided browser
if [ "$USE_MANUAL" = true ]; then
    echo ""
    echo "═══════════════════════════════════════════════════════════"
    echo "  MANUAL DEPLOY MODE - Follow these steps:"
    echo "═══════════════════════════════════════════════════════════"
    echo ""
    
    print_step "Step 1: Opening GitHub repo creation..."
    open "https://github.com/new" &
    
    echo ""
    echo "  ┌─────────────────────────────────────────────────────┐"
    echo "  │  Repository Name:  ${YELLOW}jarvis-dashboard${NC}                │"
    echo "  │  Visibility:       ${YELLOW}Public${NC}                          │"
    echo "  │  Click:            ${YELLOW}Create repository${NC}              │"
    echo "  └─────────────────────────────────────────────────────┘"
    
    print_step "Step 2: After creating repo, press ENTER to continue..."
    read -r
    
    print_step "Step 3: Opening upload page..."
    open "https://github.com/$GITHUB_USER/$REPO_NAME/upload" &
    
    echo ""
    echo "  ┌─────────────────────────────────────────────────────┐"
    echo "  │  Drag and drop: ${YELLOW}$ZIP_PATH${NC}         │"
    echo "  │  Or extract and upload ${YELLOW}index.html${NC}                 │"
    echo "  │  Click: ${YELLOW}Commit changes${NC}                              │"
    echo "  └─────────────────────────────────────────────────────┘"
    
    print_step "Step 4: After uploading, press ENTER to enable Pages..."
    read -r
    
    print_step "Step 5: Opening Pages settings..."
    open "https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages" &
    
    echo ""
    echo "  ┌─────────────────────────────────────────────────────┐"
    echo "  │  Source: ${YELLOW}Deploy from a branch${NC}                       │"
    echo "  │  Branch: ${YELLOW}main${NC}                                      │"
    echo "  │  Folder: ${YELLOW}/ (root)${NC}                                  │"
    echo "  │  Click: ${YELLOW}Save${NC}                                       │"
    echo "  └─────────────────────────────────────────────────────┘"
    
    DEPLOY_URL="https://$GITHUB_USER.github.io/$REPO_NAME/"
fi

echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  🎉 DEPLOYMENT COMPLETE"
echo "═══════════════════════════════════════════════════════════"
echo ""
print_success "Your Mini App URL:"
echo ""
echo "  ${GREEN}$DEPLOY_URL${NC}"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "  📱 NEXT STEP: Configure BotFather"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "  1. Open Telegram → @BotFather"
echo "  2. Send: /setmenubutton"
echo "  3. Select your bot"
echo "  4. Paste: ${YELLOW}$DEPLOY_URL${NC}"
echo ""
echo "═══════════════════════════════════════════════════════════"

# Copy URL to clipboard
echo "$DEPLOY_URL" | pbcopy 2>/dev/null || true
print_success "URL copied to clipboard!"

# Open BotFather
open "https://t.me/BotFather" &

echo ""
echo "Press ENTER when done..."
read -r
