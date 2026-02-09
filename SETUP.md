# Jarvis Dashboard Mini App — Setup Guide

## Overview
A Telegram Web App for monitoring and controlling Jarvis directly from Telegram.

## Features
- Real-time system status (uptime, disk, load)
- Quick action buttons (/heartbeat, /status, /briefing, etc.)
- Recent activity feed
- Error banners for cron issues
- localStorage caching (5min TTL)
- Auto-refresh on app open
- Haptic feedback support

## Hosting Options

### Option 1: Local + ngrok (Development)
1. Start the local server:
   ```bash
   cd ~/.openclaw/workspace/mini-app
   ./serve.sh
   ```
2. In another terminal, expose via ngrok:
   ```bash
   ngrok http 8080
   ```
3. Copy the HTTPS URL (e.g., `https://abc123.ngrok.io`)

### Option 2: GitHub Pages (Production)
1. Push mini-app/ to a GitHub repo
2. Enable GitHub Pages in repo settings
3. Use the Pages URL in BotFather

### Option 3: Cloudflare Pages (Production)
1. Create a new Cloudflare Pages project
2. Upload mini-app/ folder
3. Use the provided URL

## BotFather Configuration

1. Message [@BotFather](https://t.me/BotFather)
2. Send `/mybots` → select your bot
3. Tap **Bot Settings** → **Menu Button** → **Configure menu button**
4. Send button text: `Dashboard`
5. Send URL: Your hosted Mini App URL (must be HTTPS)
6. Done! The menu button will now open the Mini App

## Alternative: Inline Button Launch

Add a button to open the Mini App:

```
message action=send
  message="Open your Jarvis Dashboard:"
  buttons=[[{"text":"🤖 Open Dashboard","web_app":{"url":"https://your-url-here"}}]]
```

## Data Flow

```
User taps button → Mini App opens
     ↓
Mini App calls tg.sendData({action: 'get_dashboard_data'})
     ↓
OpenClaw receives web_app_data message
     ↓
OpenClaw replies with JSON data
     ↓
Mini App updates UI + caches to localStorage
```

## Required OpenClaw Handler

The bot needs to handle `web_app_data` messages. Add this to your message handling:

When a message with `web_app_data` arrives:
1. Parse the JSON payload
2. If action is `get_dashboard_data`:
   - Run system health check
   - Get recent activity from MEMORY.md
   - Count skills and crons
   - Return JSON with all data
3. If payload contains a `command`, execute it as a normal message

## Security Notes

- Mini App URL must be HTTPS
- localStorage is per-domain (data persists between sessions)
- No sensitive data should be stored in the Mini App
- All actual execution happens server-side in OpenClaw

## Troubleshooting

**Mini App doesn't open:**
- Check URL is HTTPS
- Verify URL is accessible from mobile
- Check BotFather configuration

**Data not loading:**
- Check browser console for errors
- Verify `tg.sendData()` is being called
- Ensure OpenClaw handles `web_app_data` messages

**Styling looks wrong:**
- Mini App uses Telegram theme variables
- Test inside Telegram, not browser
- Theme changes require app restart

## Files

- `index.html` — Main Mini App UI
- `serve.sh` — Local development server
- `SETUP.md` — This file
