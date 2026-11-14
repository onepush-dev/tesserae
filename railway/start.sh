#!/bin/sh
# Seed the admin password (first boot only), then hand over to upstream's entrypoint (chowns /app/data, drops to pwuser).
set -e
mkdir -p /app/data/core
python /opt/railway/seed_password.py
exec docker-entrypoint.sh "$@"
