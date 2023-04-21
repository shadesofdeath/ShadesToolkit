@echo off
color f4
setlocal enabledelayedexpansion
set ver="ShadesSystemCompress
title %ver% - by ShadesOfDeath
chcp 65001 >nul
mode con cols=115 lines=45
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
compact /c /i /q /f /exe:lzx /s:C:\
exit