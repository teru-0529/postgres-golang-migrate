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
  echo up             :�R���e�i�N��
  echo down           :�R���e�i��~
  echo migrate-create :�}�C�O���[�V�����t�@�C���̐���[���̗p�ɑ�2�������K�v]
  echo migrate-up     :�ŐV��ԂɃ}�C�O���[�V�������{
  echo migrate-down   :������ԂɃ}�C�O���[�V�������[���o�b�N
  echo migrate-goto   :�w�肵���o�[�W�����Ƀ}�C�O���[�V���������s[�o�[�W�����w��p�ɑ�2�������K�v]
  exit /b
)

set DATABASE_URL="postgres://%POSTGRES_USER%:%POSTGRES_PASSWORD%@db:%POSTGRES_PORT%/%POSTGRES_DB%?sslmode=disable"
set DIR_PATH="./src/database/migrations"

rem �R���e�i�N��
if %1==up (
  docker compose up -d
)

rem �R���e�i��~
if %1==down (
  docker compose down
)

rem �}�C�O���[�V�����t�@�C���̍쐬
if %1==migrate-create (
  if "%2"=="" (
    echo �}�C�O���[�V�����t�@�C�����Ƃ��đ�2�������K�v�ł��B
    exit /b
  )
  docker-compose exec app migrate create -ext sql -dir %DIR_PATH% -seq %2
)

rem �}�C�O���[�V�������s
if %1==migrate-up (
  docker-compose exec app migrate -database %DATABASE_URL% -path %DIR_PATH% up
)

rem �}�C�O���[�V�������[���o�b�N
if %1==migrate-down (
  docker-compose exec app migrate -database %DATABASE_URL% -path %DIR_PATH% down
)

rem �}�C�O���[�V���������s
if %1==migrate-goto (
  if "%2"=="" (
    echo �o�[�W�����̎w�肪�K�v�ł��B
    exit /b
  )
  docker-compose exec app migrate -database %DATABASE_URL% -path %DIR_PATH% goto %2
)
