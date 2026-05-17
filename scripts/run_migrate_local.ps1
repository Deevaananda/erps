<#
Run local migrations against Supabase for quick testing.
Usage (PowerShell):
  $env:SUPABASE_DATABASE_URL = "postgres://user:pass@host:5432/dbname?sslmode=require"
  $env:DJANGO_DEBUG = "false"
  .\scripts\run_migrate_local.ps1

This script installs requirements into the active Python environment and runs `manage.py migrate`.
#>
param()

Write-Output "Running migrations using SUPABASE_DATABASE_URL=$($env:SUPABASE_DATABASE_URL -ne $null)"
if (-not $env:SUPABASE_DATABASE_URL) {
    Write-Error "SUPABASE_DATABASE_URL is not set. Aborting."
    exit 1
}

python -m pip install --upgrade pip
python -m pip install -r requirements.txt
python manage.py migrate --noinput
Write-Output "Migrations finished. If you need a superuser, run: python manage.py createsuperuser"
