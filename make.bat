@echo off
title Make
setlocal enabledelayedexpansion

for /f "tokens=1,* delims==" %%a in (.env) do (
  set %%a=%%b
)

rem 引数指定なし
if "%1"=="" (
  echo ★ 引数を指定して下さい
  echo ----+----+----+----+----+----
  echo up             :コンテナ起動
  echo down           :コンテナ停止
  echo migrate-create :マイグレーションファイルの生成[名称用に第2引数が必要]
  echo migrate-up     :最新状態にマイグレーション実施
  echo migrate-down   :初期状態にマイグレーションロールバック
  echo migrate-goto   :指定したバージョンにマイグレーションを実行[バージョン指定用に第2引数が必要]
  exit /b
)

set DATABASE_URL="postgres://%POSTGRES_USER%:%POSTGRES_PASSWORD%@db:%POSTGRES_PORT%/%POSTGRES_DB%?sslmode=disable"
set DIR_PATH="./src/database/migrations"

rem コンテナ起動
if %1==up (
  docker compose up -d
)

rem コンテナ停止
if %1==down (
  docker compose down
)

rem マイグレーションファイルの作成
if %1==migrate-create (
  if "%2"=="" (
    echo マイグレーションファイル名として第2引数が必要です。
    exit /b
  )
  docker-compose exec app migrate create -ext sql -dir %DIR_PATH% -seq %2
)

rem マイグレーション実行
if %1==migrate-up (
  docker-compose exec app migrate -database %DATABASE_URL% -path %DIR_PATH% up
)

rem マイグレーションロールバック
if %1==migrate-down (
  docker-compose exec app migrate -database %DATABASE_URL% -path %DIR_PATH% down
)

rem マイグレーションを実行
if %1==migrate-goto (
  if "%2"=="" (
    echo バージョンの指定が必要です。
    exit /b
  )
  docker-compose exec app migrate -database %DATABASE_URL% -path %DIR_PATH% goto %2
)
