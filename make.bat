@echo off
title Make
setlocal enabledelayedexpansion

for /f "tokens=1,* delims==" %%a in (.env) do (
  set %%a=%%b
)

if "%1"=="" (
  echo input parameter
  echo ----+----+----+----+----+----
  echo up              - start container
  echo down            - stop container
  echo migrate-create  - create migration file
  echo migrate-up      - do migration full
  echo migrate-down    - rollback migration
  echo migrate-goto    - do migratiin to version
  exit /b
)

set DATABASE_URL="postgres://%POSTGRES_USER%:%POSTGRES_PASSWORD%@db:%POSTGRES_PORT%/%POSTGRES_DB%?sslmode=disable"
set DIR_PATH="./src/database/migrations"

if %1==up (
  docker compose up -d
)

if %1==down (
  docker compose down
)

if %1==migrate-create (
  if "%2"=="" (
    echo input migration filename for 2nd parameter
    exit /b
  )
  docker-compose exec app migrate create -ext sql -dir %DIR_PATH% -seq %2
)

if %1==migrate-up (
  docker-compose exec app migrate -database %DATABASE_URL% -path %DIR_PATH% up
)

if %1==migrate-down (
  docker-compose exec app migrate -database %DATABASE_URL% -path %DIR_PATH% down
)

if %1==migrate-goto (
  if "%2"=="" (
    echo input version for 2nd parameter
    exit /b
  )
  docker-compose exec app migrate -database %DATABASE_URL% -path %DIR_PATH% goto %2
)
