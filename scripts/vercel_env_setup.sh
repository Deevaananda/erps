#!/usr/bin/env bash
# Simple script to add environment variables to a Vercel project using the Vercel CLI.
# Requirements: `vercel` CLI installed and `VERCEL_TOKEN` available in the environment.
# Usage:
#  export VERCEL_TOKEN=...
#  export VERCEL_PROJECT=your-vercel-project-name
#  export SUPABASE_DATABASE_URL="postgres://..."
#  ./scripts/vercel_env_setup.sh

set -euo pipefail

if [ -z "${VERCEL_TOKEN:-}" ]; then
  echo "VERCEL_TOKEN is required in the environment. Export it and try again." >&2
  exit 2
fi

if [ -z "${VERCEL_PROJECT:-}" ]; then
  echo "VERCEL_PROJECT is required (your Vercel project name). Export it and try again." >&2
  exit 2
fi

if [ -z "${SUPABASE_DATABASE_URL:-}" ]; then
  echo "SUPABASE_DATABASE_URL must be set in the environment before running this script." >&2
  exit 2
fi

echo "Adding SUPABASE_DATABASE_URL to Vercel (production)..."
vercel env add SUPABASE_DATABASE_URL "$SUPABASE_DATABASE_URL" production --token "$VERCEL_TOKEN" || echo "failed to add (it may already exist)"

echo "Adding DJANGO_DEBUG=false to Vercel (production)..."
vercel env add DJANGO_DEBUG "false" production --token "$VERCEL_TOKEN" || echo "failed to add (it may already exist)"

echo "Finished. You may need to redeploy on Vercel or run: vercel --prod --token $VERCEL_TOKEN"
