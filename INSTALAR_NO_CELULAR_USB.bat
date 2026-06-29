@echo off
chcp 65001 >nul
title Guardião Digital Android - Instalar no Celular

echo ============================================================
echo   GUARDIÃO DIGITAL - INSTALAR NO CELULAR VIA USB
echo ============================================================
echo.
echo Antes:
echo 1. Ative a Depuração USB no celular.
echo 2. Conecte o celular no cabo USB.
echo 3. No celular, toque em Permitir quando aparecer.
echo.

set "SDK=%LOCALAPPDATA%\Android\Sdk"
set "ADB=%SDK%\platform-tools\adb.exe"
set "APK=%CD%\app\build\outputs\apk\debug\app-debug.apk"

if not exist "%ADB%" (
  echo ERRO: Não encontrei o ADB em:
  echo %ADB%
  echo Abra o Android Studio e instale Platform Tools.
  pause
  exit /b 1
)

if not exist "%APK%" (
  echo ERRO: APK não encontrado.
  echo Primeiro rode: GERAR_APK_FACIL_PORTUGUES.bat
  pause
  exit /b 1
)

echo Procurando celular conectado...
"%ADB%" devices

echo.
echo Instalando APK...
"%ADB%" install -r "%APK%"

if errorlevel 1 (
  echo.
  echo ERRO ao instalar.
  echo Veja se o celular pediu permissão de Depuração USB.
  echo Se pediu, toque em Permitir e rode este arquivo de novo.
  pause
  exit /b 1
)

echo.
echo Instalado com sucesso.
pause
