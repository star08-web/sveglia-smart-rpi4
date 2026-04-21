#!/bin/bash
BLUE='\033[0;34m'

echo -e "${BLUE} Installing PM2 and n8n, please wait..."
npm install -g pm2 n8n

echo -e "${BLUE} Starting n8n with PM2"
pm2 start n8n --cron-restart="0 0 * * *"

echo -e "${BLUE} Installing n8n service"
pm2 startup | tail -n 1 | bash
pm2 save

echo -e "${BLUE} Installing reverse proxy"
apt install -y debian-keyring debian-archive-keyring apt-transport-https curl
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
chmod o+r /usr/share/keyrings/caddy-stable-archive-keyring.gpg
chmod o+r /etc/apt/sources.list.d/caddy-stable.list
apt update
apt install caddy

