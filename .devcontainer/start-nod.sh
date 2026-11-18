#!/bin/bash
# Nod self-host boot for Codespaces — run from repo root
# IMPORTANT: do NOT --build on every start. Rebuilding fills the 32 GB
# codespace disk (Postgres then dies with ENOSPC). Build only if the
# plain up fails because images are missing (first run).
set -e
cd deployment/self-host
if [ ! -f .env ]; then sh setup.sh; fi
docker compose --file compose.yaml --env-file .env up -d || \
  docker compose --file compose.yaml --env-file .env up -d --build
echo "=== NOD READY ==="
echo "Open forwarded port 4310, then paste NOD_AUTH_TOKEN from deployment/self-host/.env"
grep '^NOD_AUTH_TOKEN=' .env || true
