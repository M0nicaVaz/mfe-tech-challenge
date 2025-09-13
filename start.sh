#!/bin/sh
set -e

# Start HOME on 4444
cd /app/home
npm run dev -- --hostname 0.0.0.0 &

# Start LOGIN on 7777
cd /app/login
npm run dev -- --hostname 0.0.0.0 &

# Wait for both to finish (keeps container running)
wait

