#!/bin/bash
# serve-mini-app.sh — Serve Jarvis Dashboard Mini App locally

PORT=${1:-8080}
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🤖 Jarvis Mini App Server"
echo "========================"
echo "Directory: $DIR"
echo "Port: $PORT"
echo ""
echo "Starting HTTP server..."
echo "Local URL: http://localhost:$PORT"
echo ""
echo "For Telegram access, use ngrok:"
echo "  ngrok http $PORT"
echo ""
echo "Press Ctrl+C to stop"
echo ""

cd "$DIR" && python3 -m http.server $PORT
