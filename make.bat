@echo off
title Make
setlocal enabledelayedexpansion

for /f "tokens=1,* delims==" %%a in (.env) do (
  set %%a=%%b
)

rem �����w��Ȃ�
if "%1"=="" (
  echo �� �������w�肵�ĉ�����
  echo ----+----+----+----+----+----
  echo up   :�R���e�i�N��
  echo down :�R���e�i��~
  exit /b
)

rem �R���e�i�N��
if %1==up (
  docker compose up -d
)

rem �R���e�i��~
if %1==down (
  docker compose down
)



echo %0
echo %POSTGRES_DB%

