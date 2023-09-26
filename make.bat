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
  echo up   :コンテナ起動
  echo down :コンテナ停止
  exit /b
)

rem コンテナ起動
if %1==up (
  docker compose up -d
)

rem コンテナ停止
if %1==down (
  docker compose down
)



echo %0
echo %POSTGRES_DB%

