# 🤖 Jarvis Dashboard Mini App

**Live URL**: https://madiarineta.github.io/jarvis-dashboard/

## BotFather Setup Instructions

1. **Open Telegram** and message [@BotFather](https://t.me/BotFather)
2. **Send command**: `/setmenubutton`
3. **Select your bot**: @vinzdbb (or your bot username)
4. **Paste the URL**: `https://madiarineta.github.io/jarvis-dashboard/`
5. **Done!** The menu button will now open the Jarvis Dashboard

## Alternative: Inline Button Setup

Add this button to your bot's messages:
```
[🤖 Open Jarvis Dashboard](https://t.me/vinzdbb?startapp=dashboard)
```

## Features

- 📊 **Real-time System Status** — Uptime, disk, load, heartbeat
- 📈 **Recent Activity** — Shows latest actions from MEMORY.md
- ⚡ **Quick Actions** — Run heartbeat, health check, get briefing
- 🛠️ **Skills & Tools Stats** — Custom skills, workspace skills, active crons
- 🎨 **Arc Reactor Theme** — GitHub Dark with animated status indicators
- 📱 **Mobile Optimized** — Full Telegram WebApp integration

## How It Works

The Mini App communicates with the bot via `tg.sendData()`:
- Dashboard requests data via `{action: 'get_dashboard_data'}`
- Commands sent via `{command: '/heartbeat'}` etc.
- The `mini-app-handler` skill processes these messages

## Files

- `index.html` — Main Mini App (single file, no build step)
- GitHub Pages hosts it directly from the `main` branch

---
*Deployed: 2026-02-09*
