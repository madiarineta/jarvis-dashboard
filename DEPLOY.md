# Quick Deploy Guide — Jarvis Dashboard Mini App

## Option 1: One-Command (if GitHub CLI installed)
```bash
bash ~/.openclaw/workspace/mini-app/deploy-github.sh
```

## Option 2: Manual Upload (Easiest)

### Step 1: Download the ZIP
File location: `~/jarvis-dashboard-deploy.zip`

### Step 2: Create Repo
Go to: https://github.com/new
- Repository name: `jarvis-dashboard`
- Visibility: **Public**
- Click **Create repository**

### Step 3: Upload Files
Go to: https://github.com/madiarineta/jarvis-dashboard/upload
- Drag and drop `jarvis-dashboard-deploy.zip` OR
- Extract ZIP and upload `index.html` directly
- Click **Commit changes**

### Step 4: Enable GitHub Pages
Go to: https://github.com/madiarineta/jarvis-dashboard/settings/pages
- Source: **Deploy from a branch**
- Branch: **main** / **/(root)**
- Click **Save**
- Wait 1-2 minutes for deploy

### Step 5: Configure BotFather
1. Open Telegram, message @BotFather
2. Send: `/setmenubutton`
3. Select your bot
4. Paste: `https://madiarineta.github.io/jarvis-dashboard/`
5. Menu button now opens your dashboard!

## Verification
Test URL: https://madiarineta.github.io/jarvis-dashboard/

Should show: Jarvis Dashboard with arc reactor theme

## Troubleshooting
- **404 error**: Pages still deploying, wait 2-3 minutes
- **Blank page**: Check browser console (right-click → Inspect)
- **Wrong URL**: Ensure repo is public and Pages enabled

## Alternative: Cloudflare Pages (Faster)
If GitHub Pages is slow:
```bash
export CLOUDFLARE_API_TOKEN=your_token
npx wrangler pages deploy ~/.openclaw/workspace/mini-app --project-name=jarvis-dashboard
```
