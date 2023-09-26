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
  echo migrate-github  - do migratiin from github tag
  exit /b
)

set DATABASE_URL="postgres://%POSTGRES_USER%:%POSTGRES_PASSWORD%@db:%POSTGRES_PORT%/%POSTGRES_DB%?sslmode=disable"
set DIR_PATH="./src/database/migrations"
@REM set GITHUB_URL="github://user:personal-access-token@owner/repo/path#ref"
set GITHUB_URL="github://teru-0529/postgres-golang-migrate/src/database/migrations"

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
  docker-compose exec app migrate -path %DIR_PATH% -database %DATABASE_URL% up
)

if %1==migrate-down (
  docker-compose exec app migrate -path %DIR_PATH% -database %DATABASE_URL% down
)

if %1==migrate-goto (
  if "%2"=="" (
    echo input version for 2nd parameter
    exit /b
  )
  docker-compose exec app migrate -path %DIR_PATH% -database %DATABASE_URL% goto %2
)

if %1==migrate-github (
  if "%2"=="" (
    echo input tag for 2nd parameter
    exit /b
  )
  docker-compose exec app migrate -path %DIR_PATH% -database %DATABASE_URL% down
  docker-compose exec app migrate -source %GITHUB_URL%#%2 -database %DATABASE_URL% up
)
