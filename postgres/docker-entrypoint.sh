#!/bin/bash

set -eu

until pg_isready -U postgres; do
  echo "Waiting for PostgreSQL to become ready..."
  sleep 1
done

echo "PostgreSQL is ready. Running initialization scripts..."

# Execute your SQL dump (or other initialization commands)
psql -U postgres -d gisdb -f /docker-entrypoint-initdb.d/gisdb_dump_v3.sql

# Start PostgreSQL in the foreground (important!)
exec postgres "$@"