@echo off
chcp 65001 >nul
title Guardião Digital Android - Gerar APK Fácil

echo ============================================================
echo   GUARDIÃO DIGITAL ANDROID - GERAR APK FÁCIL
echo ============================================================
echo.
echo Este script vai gerar o APK sem você mexer no Android Studio.
echo Ele usa o Android SDK que o Android Studio já instalou.
echo.

set "SDK=%LOCALAPPDATA%\Android\Sdk"
if not exist "%SDK%" (
  echo ERRO: Não encontrei o Android SDK em:
  echo %SDK%
  echo.
  echo Abra o Android Studio uma vez e deixe ele terminar de baixar os componentes.
  pause
  exit /b 1
)

set "ANDROID_HOME=%SDK%"
set "ANDROID_SDK_ROOT=%SDK%"

set "TOOLS=%CD%\_ferramentas"
set "GRADLE_DIR=%TOOLS%\gradle-8.10.2"
set "GRADLE_ZIP=%TOOLS%\gradle-8.10.2-bin.zip"
set "GRADLE_EXE=%GRADLE_DIR%\bin\gradle.bat"

if not exist "%TOOLS%" mkdir "%TOOLS%"

if not exist "%GRADLE_EXE%" (
  echo Baixando Gradle portátil. Pode demorar alguns minutos...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -Uri 'https://services.gradle.org/distributions/gradle-8.10.2-bin.zip' -OutFile '%GRADLE_ZIP%' } catch { exit 1 }"
  if errorlevel 1 (
    echo.
    echo ERRO: Não consegui baixar o Gradle.
    echo Verifique sua internet e tente novamente.
    pause
    exit /b 1
  )
  echo Extraindo Gradle...
  powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -Force '%GRADLE_ZIP%' '%TOOLS%'"
)

echo.
echo Gerando APK do Guardião...
"%GRADLE_EXE%" assembleDebug --no-daemon

if errorlevel 1 (
  echo.
  echo ============================================================
  echo   ERRO AO GERAR APK
  echo ============================================================
  echo.
  echo Possíveis causas:
  echo 1. Internet falhou ao baixar dependências.
  echo 2. Android SDK ainda não terminou de instalar.
  echo 3. Algum componente do Android está faltando.
  echo.
  echo Se aparecer erro, tire print e mande aqui.
  pause
  exit /b 1
)

echo.
echo ============================================================
echo   APK GERADO COM SUCESSO
echo ============================================================
echo.
echo O arquivo está em:
echo app\build\outputs\apk\debug\app-debug.apk
echo.
start "" "%CD%\app\build\outputs\apk\debug"
pause
