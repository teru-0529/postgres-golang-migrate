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
  echo migrate-down   :�}�C�O���[�V�����t�@�C���̐���
  echo migrate-force  :�w�肵���o�[�W�����Ƀ}�C�O���[�V���������s[�o�[�W�����w��p�ɑ�2�������K�v]
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

rem �}�C�O���[�V�����t�@�C���̍쐬
if %1==migrate-create (
  if "%2"=="" (
    echo �}�C�O���[�V�����t�@�C�����Ƃ��đ�2�������K�v�ł��B
    exit /b
  )
  echo docker-compose exec app migrate create -ext sql -dir ./src/database/migrations -seq %2
)



set DATABASE_URL="postgres://%POSTGRES_USER%:%POSTGRES_PASSWORD%@db:%POSTGRES_PORT%/%POSTGRES_DB%?sslmode=disable"
@REM echo %DATABASE_URL%

@REM docker-compose exec app migrate -database "postgres://${���[�U�[��}:${�p�X���[�h}@${�z�X�g}:${�|�[�g}/${�f�[�^�x�[�X�̖��O}?sslmode=disable"


