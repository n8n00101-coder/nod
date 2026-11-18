#!/bin/bash
# Nod self-host boot for Codespaces — run from repo root
set -e
cd deployment/self-host
if [ ! -f .env ]; then sh setup.sh; fi
docker compose --file compose.yaml --env-file .env up -d --build --wait || docker compose up -d
echo "=== NOD READY ==="
echo "Open forwarded port 4310, then paste NOD_AUTH_TOKEN from deployment/self-host/.env"
grep '^NOD_AUTH_TOKEN=' .env || true
