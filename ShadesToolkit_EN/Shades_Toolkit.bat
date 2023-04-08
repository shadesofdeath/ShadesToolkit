:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: This project is developed by Shadesofdeath.
:: My github address: https://github.com/shadesofdeath
:: Coffee Order: https://www.buymeacoffee.com/berkayay
:: This project can be developed by others.However, the original content
:: sharing and sharing links and the original creator of the developer's source
:: It can be done on condition that it is.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
color 4F
setlocal enabledelayedexpansion
set ver=v1.5
title %ver% - by ShadesOfDeath
chcp 65001 >nul
mode con cols=100 lines=35
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

:: Location information
cd /d "%~dp0"
for /f %%a in ('"cd"') do set Location=%%a
set INSTALL=%Location%\Mount\Install
set InstallWim=%Location%\Extracted\sources\install.wim
:: It takes the installed Mount paths and performs the remote operation.This prevents possible errors.
FOR /F "tokens=4" %%a in ('dism /get-mountedwiminfo ^| FIND "Mount Dir"') do (
	FOR /F "delims=\\? tokens=*" %%b in ('echo %%a') do (
		Dism /Remount-Image /MountDir:"%%b" > NUL 2>&1
		cls
	)
)
cls
:: Delete
DEL /F /Q /A "%Location%\Temp\app_list.txt" > NUL 2>&1
DEL /F /Q /A "%Location%\Temp\app_list2.txt" > NUL 2>&1

:CleanUp
set CLEAR=N
dir /b /s %INSTALL%\Windows\Regedit.exe > NUL 2>&1
	if %errorlevel% EQU 0 (set CLEAR=Y&goto CONTINUE)

dir /b /s %INSTALL%\* > NUL 2>&1
	if %errorlevel% NEQ 0 (RD /S /Q "%Location%\Mount" > NUL 2>&1
						   MD %INSTALL% > NUL 2>&1)

:CONTINUE
if "!CLEAR!"=="Y" (
	echo.
    choice /C EH /M " There are remains of your previous work, should it be cleaned? "
    cls
    if errorlevel 2 (
        goto menu
    )
	Dism /Unmount-image /MountDir:%INSTALL% /Discard
)
:menu
cls
set choice=NT
echo.
echo  ====================================
echo.         ShadesToolkit %ver%
echo  ====================================
echo.
echo   [1] Source
echo.
echo   [2] Integrate
echo.
echo   [3] Debloat
echo.
echo   [4] Windows Features
echo.
echo   [5] Customize
echo.
echo   [6] Fine adjustments
echo.
echo   [7] Windows Services
echo.
echo   [8] Apply changes
echo.
echo   [9] Other
echo.
echo.
echo   [D] Give Support
echo.
echo   [X] Exit
echo.
echo  ====================================
echo.
set /p choice= Please Set an option: 
if "%choice%" == "1" goto source
if "%choice%" == "2" goto entegre
if "%choice%" == "3" goto debloat
if "%choice%" == "4" goto etkin_devredısı
if "%choice%" == "5" goto customize
if "%choice%" == "6" goto ince_ayarlar
if "%choice%" == "7" goto windows_services
if "%choice%" == "8" goto dismount_commit
if "%choice%" == "9" goto wim_menu
if "%choice%" == "d" goto SUPPORT
if "%choice%" == "D" goto SUPPORT
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto menu

:SUPPORT
start "" "Bin\Thanx.html"
cls
goto menu

:windows_services
cls
set choice=NT
mode con cols=140 lines=37
echo  ==============================================================================================================
echo.                                         ShadesToolkit %ver%
echo  ==============================================================================================================
echo.
echo   [1] Sysmain Disable                             [14] Disable Application Layer Gateway Service
echo.                                      
echo   [2] Disable Print Spooler                       [15] Application Management Service Disable
echo.
echo   [3] Error reporting service disable             [16] Disable Bluetooth Audio Gateway Service Disable
echo.
echo   [4] Disable Fax Service                         [17] Bluetooth support service disable
echo.
echo   [5] Disable Phone Service                       [18] Disable Capture Service
echo.
echo   [6] Disable Remote Desktop Service              [19] Disable Certificate Propagation
echo.
echo   [7] Disable Windows Backup Service              [20] Device Management Wireless Application Protocol Disable
echo.
echo   [8] Disable Windows Defender Service            [21] Downloaded Maps Manager Disable
echo.
echo   [9] Disable Windows Defender Firewall           [22] Disable Geolocation Service
echo.
echo   [10] Disable Windows Insider Service            [23] Disable Internet Connection Sharing (ICS)
echo. 
echo   [11] Disable Windows Search                     [24] Disable IP Helper (IPv6 translation)
echo.
echo   [12] Disable Windows Update Service             [25] Disable IP Translation Configuration Service (IPv6 translation)
echo.
echo   [13] Disable Windows Update Health Service      [26] Disable All Services
echo.            
echo  ==============================================================================================================
echo.                   [Z] Back                                             [X] Exit
echo  ==============================================================================================================
echo.
set /p choice= Please choose an option : 
if %choice% EQU 1 (Call :Settings_Regedit "Disable_Sysmain")
if %choice% EQU 2 (Call :Settings_Regedit "Diable_PrintSpooler")
if %choice% EQU 3 (Call :Settings_Regedit "Disabe_ErrorReportingService")
if %choice% EQU 4 (Call :Settings_Regedit "Disable_Faks")
if %choice% EQU 5 (Call :Settings_Regedit "Disable_TelefonHizmeti")
if %choice% EQU 6 (Call :Settings_Regedit "Disable_Uzak Masaüstü Hizmetleri")
if %choice% EQU 7 (Call :Settings_Regedit "Disable_WindowsBackup")
if %choice% EQU 8 (Call :Settings_Regedit "Disable_WindowsDefender")
if %choice% EQU 9 (Call :Settings_Regedit "Disable_WindowsDefenderGüvenlikDuvarı")
if %choice% EQU 10 (Call :Settings_Regedit "Disable_WindowsInsiderHizmeti")
if %choice% EQU 11 (Call :Settings_Regedit "Disable_WindowsSearch")
if %choice% EQU 12 (Call :Settings_Regedit "Disable_WindowsUpdate")
if %choice% EQU 13 (Call :Settings_Regedit "Diable_MicrosoftUpdateHealthService")
if %choice% EQU 14 (Call :Settings_Regedit "ALG")
if %choice% EQU 15 (Call :Settings_Regedit "AppMgmt")
if %choice% EQU 16 (Call :Settings_Regedit "BTAGService")
if %choice% EQU 17 (Call :Settings_Regedit "bthserv")
if %choice% EQU 18 (Call :Settings_Regedit "CaptureService")
if %choice% EQU 19 (Call :Settings_Regedit "CertPropSvc")
if %choice% EQU 20 (Call :Settings_Regedit "dmwappushsvc")
if %choice% EQU 21 (Call :Settings_Regedit "MapsBroker")
if %choice% EQU 22 (Call :Settings_Regedit "lfsvc")
if %choice% EQU 23 (Call :Settings_Regedit "SharedAccess")
if %choice% EQU 24 (Call :Settings_Regedit "iphlpsvc")
if %choice% EQU 25 (Call :Settings_Regedit "IpxlatCfgSvc")
if %choice% EQU 26 goto DisableAllSerevices
if "%choice%" == "z" goto :menu
if "%choice%" == "Z" goto :menu
if "%choice%" == "x" goto :end
if "%choice%" == "X" goto :end
goto :windows_services

:DisableAllSerevices
Call :Settings_Regedit "Disable_Sysmain")
Call :Settings_Regedit "Diable_PrintSpooler")
Call :Settings_Regedit "Disabe_ErrorReportingService")
Call :Settings_Regedit "Disable_Faks")
Call :Settings_Regedit "Disable_TelefonHizmeti")
Call :Settings_Regedit "Disable_Uzak Masaüstü Hizmetleri")
Call :Settings_Regedit "Disable_WindowsBackup")
Call :Settings_Regedit "Disable_WindowsDefender")
Call :Settings_Regedit "Disable_WindowsDefenderGüvenlikDuvarı")
Call :Settings_Regedit "Disable_WindowsInsiderHizmeti")
Call :Settings_Regedit "Disable_WindowsSearch")
Call :Settings_Regedit "Disable_WindowsUpdate")
Call :Settings_Regedit "Diable_MicrosoftUpdateHealthService")
Call :Settings_Regedit "ALG")
Call :Settings_Regedit "AppMgmt")
Call :Settings_Regedit "BTAGService")
Call :Settings_Regedit "bthserv")
Call :Settings_Regedit "CaptureService")
Call :Settings_Regedit "CertPropSvc")
Call :Settings_Regedit "dmwappushsvc")
Call :Settings_Regedit "MapsBroker")
Call :Settings_Regedit "lfsvc")
Call :Settings_Regedit "SharedAccess")
Call :Settings_Regedit "iphlpsvc")
Call :Settings_Regedit "IpxlatCfgSvc")
echo.
echo All services are disabled...
pause
goto windows_services


:etkin_devredısı
set choice=NT
cls
echo.
echo  ====================================
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo   [1] Enable Windows Features
echo.
echo   [2] Disable Windows Features
echo.
echo.
echo   [Z] Back
echo   [X] Exit
echo.
echo  ====================================
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto özellik_etkinlestir
if "%choice%" == "2" goto özellik_devredısı
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto etkin_devredısı

:özellik_etkinlestir
mode con cols=125 lines=50
cls
set choice=NT
echo.
echo  =============================================
echo.            Enable Windows Features
echo  =============================================
echo.
echo  [1] DirectPlay
echo.
echo  [2] Linux for Microsoft Windows Subsystem
echo.
echo  [3] .NET Framework 3.5
echo.
echo  [4] PDF Print Services Features
echo.
echo  [5] XPS Services Features
echo.
echo  [6] Search Engine Client Package
echo.
echo  [7] Telnet Client
echo.
echo  [8] Legacy Components
echo.
echo  [9] WorkFolders Client
echo.
echo  [10] Printing Basic Features
echo.
echo  [11] Internet printing client
echo.
echo  [12] Microsoft Remote Desktop Infrastructure
echo.
echo  [13] Virtual machine platform
echo.
echo  [14] Simple TCP
echo.
echo  [15] .NET Framework 4 Advanced services
echo.
echo  [16] Microsoft Hyper-V
echo.
echo  [17] Windows Media Player
echo.
echo  [18] SMB1Protocol
echo.
echo.
echo  [Z] Back
echo  ====================================
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto DirectPlay
if "%choice%" == "2" (Call :EnableFeature Microsoft-Windows-Subsystem-Linux)
if "%choice%" == "3" (Call :EnableFeature NetFx3)
if "%choice%" == "4" (Call :EnableFeature Printing-PrintToPDFServices-Features)
if "%choice%" == "5" (Call :EnableFeature Printing-XPSServices-Features)
if "%choice%" == "6" (Call :EnableFeature SearchEngine-Client-Package)
if "%choice%" == "7" (Call :EnableFeature TelnetClient)
if "%choice%" == "8" (Call :EnableFeature LegacyComponents)
if "%choice%" == "9" (Call :EnableFeature WorkFolders-Client)
if "%choice%" == "10" (Call :EnableFeature Printing-Foundation-Features)
if "%choice%" == "11" (Call :EnableFeature Printing-Foundation-InternetPrinting-Client)
if "%choice%" == "12" (Call :EnableFeature MSRDC-Infrastructure)
if "%choice%" == "13" (Call :EnableFeature VirtualMachinePlatform)
if "%choice%" == "14" (Call :EnableFeature SimpleTCP)
if "%choice%" == "15" (Call :EnableFeature NetFx4-AdvSrvs)
if "%choice%" == "16" (Call :EnableFeature Microsoft-Hyper-V-All)
if "%choice%" == "17" (Call :EnableFeature WindowsMediaPlayer)
if "%choice%" == "18" (Call :EnableFeature SMB1Protocol)
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto özellik_etkinlestir

:EnableFeature
cls
Dism /Image:Mount\Install /Enable-Feature /FeatureName:%~1
pause
goto özellik_etkinlestir

:DirectPlay
cls
Dism /Image:Mount\Install /Enable-Feature /FeatureName:LegacyComponents
Dism /Image:Mount\Install /Enable-Feature /FeatureName:DirectPlay
pause
goto özellik_etkinlestir

:özellik_devredısı
mode con cols=125 lines=50
cls
set choice=NT
echo.
echo  ============================================
echo.          Disable Windows Features
echo  ============================================
echo.
echo  [1] DirectPlay
echo.
echo  [2] Linux for Microsoft Windows Subsystem
echo.
echo  [3] .NET Framework 3.5
echo.
echo  [4] PDF Print Services Features
echo.
echo  [5] XPS Services Features
echo.
echo  [6] Search Engine Client Package
echo.
echo  [7] Telnet Client
echo.
echo  [8] Legacy Components
echo.
echo  [9] WorkFolders Client
echo.
echo  [10] Printing Basic Features
echo.
echo  [11] Internet printing client
echo.
echo  [12] Microsoft Remote Desktop Infrastructure
echo.
echo  [13] Virtual machine platform
echo.
echo  [14] Simple TCP
echo.
echo  [15] .NET Framework 4 Advanced services
echo.
echo  [16] Microsoft Hyper-V
echo.
echo  [17] Windows Media Player
echo.
echo  [18] SMB1Protocol
echo.
echo.
echo  [Z] Back
echo  ====================================
echo.
set /p choice= Please choose an option : 
echo.
echo
if "%choice%" == "1" (Call :DisableFeature DirectPlay)
if "%choice%" == "2" (Call :DisableFeature Microsoft-Windows-Subsystem-Linux)
if "%choice%" == "3" (Call :DisableFeature NetFx3)
if "%choice%" == "4" (Call :DisableFeature Printing-PrintToPDFServices-Features)
if "%choice%" == "5" (Call :DisableFeature Printing-XPSServices-Features)
if "%choice%" == "6" (Call :DisableFeature SearchEngine-Client-Package)
if "%choice%" == "7" (Call :DisableFeature TelnetClient)
if "%choice%" == "8" (Call :DisableFeature LegacyComponents)
if "%choice%" == "9" (Call :DisableFeature WorkFolders-Client)
if "%choice%" == "10" (Call :DisableFeature Printing-Foundation-Features)
if "%choice%" == "11" (Call :DisableFeature Printing-Foundation-InternetPrinting-Client)
if "%choice%" == "12" (Call :DisableFeature MSRDC-Infrastructure)
if "%choice%" == "13" (Call :DisableFeature VirtualMachinePlatform)
if "%choice%" == "14" (Call :DisableFeature SimpleTCP)
if "%choice%" == "15" (Call :DisableFeature NetFx4-AdvSrvs)
if "%choice%" == "16" (Call :DisableFeature Microsoft-Hyper-V)
if "%choice%" == "17" (Call :DisableFeature WindowsMediaPlayer)
if "%choice%" == "18" (Call :DisableFeature SMB1Protocol)
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
goto özellik_devredısı

:DisableFeature
cls
Dism /Image:Mount\Install /Disable-Feature /FeatureName:%~1
pause
goto özellik_devredısı

:customize
set choice=NT
cls
echo.
echo  ====================================
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo   [1] Cleanup DefaultLayout.xml
echo.
echo   [2] System settings
echo.
echo   [3] Compress System Files After System Boot
echo.
echo   [4] Create Autounattend.xml
echo.
echo   [5] Determine next Windows version (Windows Update)
echo.
echo   [6] Add Mass_AIO Windows Activation Script to Desktop
echo.
echo   [Z] Back
echo   [X] Exit
echo.
echo  ====================================
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto default_layout
if "%choice%" == "2" goto Sistem_Ayarları
if "%choice%" == "3" goto compress
if "%choice%" == "4" goto auto_unattend
if "%choice%" == "5" goto target_windows_version
if "%choice%" == "6" goto MASS_AIO
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto customize

:MASS_AIO
cls
echo.
xcopy /Y /E Bin\MAS_AIO.cmd Mount\Install\Users\Default\Desktop\
RD /S /Q Mount\Install\Users\Default\Desktop\Regs
echo.
pause
goto customize


:target_windows_version
set choice=NT
cls
echo.
echo  ====================================
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo [1] Set the next Windows version to (22H2)
echo.
echo [2] Set the next Windows version to (21H2)
echo.
echo [3] Set the next Windows version to (21H1)
echo.
echo [4] Set the next Windows version to (20h2)
echo.
echo [5] Set the next Windows version to (2004)
echo.
echo [6] Set the next Windows version to (1909)
echo.
echo [7] Set the next Windows version to (1903)
echo.
echo [8] Set the next Windows version to (1809)
echo.
echo [9] Set the next Windows version to (1803)
echo.
echo [10] Set the next Windows version to (1709)
echo.
echo [11] Set the next Windows version to (1703)
echo.
echo [12] Set the next Windows version to (1607)
echo.
echo [13] Set the next Windows version to (1511)
echo.
echo [14] Set the next Windows version to (1507)
echo.
echo   [Z] Back
echo   [X] Exit
echo.
echo  ====================================
echo.
set /p choice= Please choose an option : 
if %choice% EQU 1 (Call :Settings_Regedit "22H2")
if %choice% EQU 2 (Call :Settings_Regedit "21H2")
if %choice% EQU 3 (Call :Settings_Regedit "21H1")
if %choice% EQU 4 (Call :Settings_Regedit "20H2")
if %choice% EQU 5 (Call :Settings_Regedit "2004")
if %choice% EQU 6 (Call :Settings_Regedit "1909")
if %choice% EQU 7 (Call :Settings_Regedit "1903")
if %choice% EQU 8 (Call :Settings_Regedit "1809")
if %choice% EQU 9 (Call :Settings_Regedit "1803")
if %choice% EQU 10 (Call :Settings_Regedit "1709")
if %choice% EQU 11 (Call :Settings_Regedit "1703")
if %choice% EQU 12 (Call :Settings_Regedit "1607")
if %choice% EQU 13 (Call :Settings_Regedit "1511")
if %choice% EQU 14 (Call :Settings_Regedit "1507")
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto customize

:auto_unattend
chcp 65001 >nul
rem Copying the Autounattend.xml file in the Extracted folder
del Extracted\autounattend.xml
xcopy /Y /E Bin\autounattend.xml Extracted\
RD /S /Q Extracted\Regs
cls
chcp 437 > NUL 2>&1
rem Asking the name of the administrator and replacing the shadesadmin article in the XML file
echo.
set /p adminname=Please enter a username: 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'ShadesAdmin','%adminname%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
chcp 437 > NUL 2>&1
rem Question of the password and replacement with password_changer in the XML file
echo.
set /p new_password=Please enter a password: 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'password_change','%new_password%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
cls
echo.
echo ==============================================================
echo Autounattend.xml file was created in the settings you specified..
echo ==============================================================
timeout /t 2 >nul
pause
cls
goto menu
:compress
cls
echo.
xcopy /Y /E Bin\compress.bat Mount\Install\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp
RD /S /Q Mount\Install\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Regs
echo.
pause
goto customize

:Sistem_Ayarları
set choice=NT
cls
echo.
echo  ====================================
echo          ShadesToolkit %ver%
echo  ====================================
echo.
echo  [1] Enable Old Windows Photo Viewer
echo.
echo  [2] Add Take Ownership to right-click menu
echo.
echo  [3] Remove 260 Character Limitation
echo.
echo  [4] Disable Visual Feedback
echo.
echo  [5] Add Kill unresponsive processes to right-click menu
echo.
echo  [6] Add Empty recycle bin to right-click menu
echo.
echo  [7] Disable Steps Recorder
echo.
echo  [8] Disable Autoplay
echo.
echo  [9] Disable advanced indexing
echo.
echo  [10] Disable Application Launch Tracking
echo.
echo  [11] XBox Game Bar Disable
echo.
echo  [12] Disable Hardware Accelerated GPU Timing
echo.
echo  [13] Disable Hibernation
echo.
echo  [14] Add Legacy Soundbar (Windows 10)
echo.
echo  [15] Add Right-click Copy as Path option
echo.
echo  [16] Disable Reducing JPEG Desktop Wallpaper Quality
echo.
echo  [17] Set Windows App Color Theme to Dark Mode
echo.
echo  [18] Set Windows Theme to Dark Mode
echo.
echo  [19] Add My Computer Shortcut on Desktop
echo.
echo  [20] Add Control Panel Shortcut on Desktop
echo.
echo.
echo  [Z] Back
echo  ====================================
set /p choice=Please choose an option :
if %choice% EQU 1 (Call :Settings_Regedit "Restore the Windows Photo Viewer")
if %choice% EQU 2 (Call :Settings_Regedit "Take_Ownership")
if %choice% EQU 3 (Call :Settings_Regedit "Win32 long paths - Disable")
if %choice% EQU 4 (Call :Settings_Regedit "Visual Feedback OFF")
if %choice% EQU 5 (Call :Settings_Regedit "Add_Kill_all_not_responding_tasks_to_context_menu")
if %choice% EQU 6 (Call :Settings_Regedit "Empty Recycle Bin Context Menu - Add")
if %choice% EQU 7 (Call :Settings_Regedit "Steps Recorder - Disable")
if %choice% EQU 8 (Call :Settings_Regedit "Turn Off AutoPlay")
if %choice% EQU 9 (Call :Settings_Regedit "Advanced Indexing - Disable")
if %choice% EQU 10 (Call :Settings_Regedit "Disable App Launch Tracking")
if %choice% EQU 11 (Call :Settings_Regedit "Turn Off Xbox Game Bar")
if %choice% EQU 12 (Call :Settings_Regedit "Hardware Accelerated GPU Scheduling - Disable")
if %choice% EQU 13 (Call :Settings_Regedit "Disable Hibernate")
if %choice% EQU 14 (Call :Settings_Regedit "Old volume applet")
if %choice% EQU 15 (Call :Settings_Regedit "CopyAsPath-Windows 10")
if %choice% EQU 16 (Call :Settings_Regedit "Disable_JPEG_Desktop_wallpaper_import_quality")
if %choice% EQU 17 (Call :Settings_Regedit "Use_Dark_theme_color_for_default_app_mode_for_current_user")
if %choice% EQU 18 (Call :Settings_Regedit "Use_Dark_theme_color_for_default_Windows_mode_for_current_user")
if %choice% EQU 19 (Call :Settings_Regedit "Add_This-PC_Desktop_Icon")
if %choice% EQU 20 (Call :Settings_Regedit "Add_Control_Panel_Desktop_Icon")
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
goto Sistem_Ayarları

:Settings_Regedit
set Error=0
RD /S /Q %Location%\Bin\TurnReg > NUL 2>&1
MD %Location%\Bin\TurnReg > NUL 2>&1
copy /y "%Location%\Bin\Regs\%~1.reg" "%Location%\Bin\TurnReg" > NUL 2>&1
FOR /f "tokens=*" %%g in ('dir /b /s %Location%\Bin\TurnReg\*.reg 2^>NUL') do (Call :Regedit_Convert_Rename "%%g")
timeout /t 1 /nobreak > NUL
Call :Powershell_2 "Bin\ConvertReg.ps1" "%Location%\Bin\TurnReg" "%Location%\Bin\TurnReg"
Call :RegeditInstall
:: Installs Regedit Records
FOR /F "tokens=*" %%g in ('dir /b /s %Location%\Bin\TurnReg\*.reg 2^>NUL') do (
	Call :Reg_Import %%g
)
Call :RegeditCollect
RD /S /Q "%Location%\Bin\TurnReg" > NUL 2>&1
goto :eof

:default_layout
cls
echo.
xcopy /Y /E Bin\DefaultLayouts.xml Mount\Install\Users\Default\AppData\Local\Microsoft\Windows\Shell\
xcopy /Y /E Bin\LayoutModification.xml Mount\Install\Users\Default\AppData\Local\Microsoft\Windows\Shell\
xcopy /Y /E Bin\LayoutModification.json Mount\Install\Users\Default\AppData\Local\Microsoft\Windows\Shell\
Bin\MinSudo --TrustedInstaller --NoLogo --Verbose cmd /c "xcopy /Y /E Bin\DefaultLayouts.xml Mount\Install\Windows\WinSxS\amd64_microsoft-windows-ui-pcshell_31bf3856ad364e35_10.0.22621.1_none_76348001aa8d6a7f"
Bin\MinSudo --TrustedInstaller --NoLogo --Verbose cmd /c "xcopy /Y /E Bin\LayoutModification.xml Mount\Install\Windows\WinSxS\amd64_microsoft-windows-ui-pcshell_31bf3856ad364e35_10.0.22621.1_none_76348001aa8d6a7f"
Bin\MinSudo --TrustedInstaller --NoLogo --Verbose cmd /c "xcopy /Y /E Bin\LayoutModification.json Mount\Install\Windows\WinSxS\amd64_microsoft-windows-ui-pcshell_31bf3856ad364e35_10.0.22621.1_none_76348001aa8d6a7f"
echo.
pause
goto customize

:entegre
set choice=NT
cls
echo.
echo  ====================================
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo  [1] Add Custom Regedit Files
echo.
echo  [2] Special Files
echo.
echo  [3] Integrate Drivers
echo.
echo.
echo  [Z] Back
echo.
echo  [X] Exit
echo.
echo  ====================================
echo.
set /p choice= Please choose an option :  
if "%choice%" == "1" goto custom_regedit
if "%choice%" == "2" goto özel_dosyalar
if "%choice%" == "3" goto driver_entegre
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto entegre

:driver_entegre
set choice=NT
cls
set mountdir=Mount\Install
set driverdir=Custom\Driver

if not exist "%driverdir%\*.inf" (
  echo Hata: %driverdir% dizininde INF dosyasi bulunamadi.
  pause
  goto entegre
)
dism /Image:%mountdir% /Add-Driver /Driver:%driverdir% /Recurse /ForceUnsigned
pause
goto entegre

:özel_dosyalar
set choice=NT
cls
echo.
echo  ====================================
echo.         ShadesToolkit %ver%
echo  ====================================
echo.
echo  [1] Add own cursor files (Custom \ Files \ Windows \ Cursors)
echo.
echo  [2] Add own media files (Custom \ Files \ Windows \ Media)
echo.
Echo  [3] Add own Theme Files (Custom \ Files \ Windows \ Resources)
echo.
Echo  [4] Add own System32 files (Custom \ Files \ Windows \ System32)
echo.
Echo  [5] Add own Syswow64 files (Custom \ Files \ Windows \ Syswow64)
echo.
Echo  [6] Add custom desktop background files (Custom \ Files \ Windows \ Web)
echo.
Echo  [7] Add own Desktop File-Folder (Desktop)
echo.
echo  [Z] Back
echo  [X] Exit
echo.
echo  ====================================
echo.
set /p choice= Please choose an option :  
if "%choice%" == "1" goto custom_Cursors
if "%choice%" == "2" goto custom_Media
if "%choice%" == "3" goto custom_Resources
if "%choice%" == "4" goto custom_System32
if "%choice%" == "5" goto custom_SysWOW64
if "%choice%" == "6" goto custom_Web
if "%choice%" == "7" goto custom_Desktop
if "%choice%" == "8" goto entegre
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto :özel_dosyalar


:custom_Desktop
cls
echo.
set source=Custom\Files\Desktop
set destination=Mount\Install\Users\Default\Desktop
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Users\Default\Desktop\Regs
echo.
pause
goto özel_dosyalar


:custom_Web
cls
echo.
set source=Custom\Files\Web
set destination=Mount\Install\Windows\Web\
set MinSudo=Bin\MinSudo.exe
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Web"
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\Web\Regs
echo.
pause
goto özel_dosyalar

:custom_SysWOW64
cls
echo.
set source=Custom\Files\SysWOW64
set destination=Mount\Install\Windows\SysWOW64\
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\SysWOW64\Regs
echo.
pause
goto özel_dosyalar

:custom_System32
cls
echo.
set source=Custom\Files\System32
set destination=Mount\Install\Windows\System32\
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\System32\Regs
echo.
pause
goto özel_dosyalar

:custom_Resources
cls
echo.
set source=Custom\Files\Resources
set destination=Mount\Install\Windows\Resources\
set MinSudo=Bin\MinSudo.exe
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Resources"
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\Resources\Regs
echo.
pause
goto özel_dosyalar

:custom_Media
cls
echo.
set source=Custom\Files\Media
set destination=Mount\Install\Windows\Media\
set MinSudo=Bin\MinSudo.exe
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Media"
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\Media\Regs
echo.
pause
goto özel_dosyalar


:custom_Cursors
cls
echo.
set source=Custom\Files\Cursors
set destination=Mount\Install\Windows\Cursors\
set MinSudo=Bin\MinSudo.exe
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Cursors"
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\Cursors\Regs
echo.
pause
goto özel_dosyalar

:custom_regedit
setlocal
set MOUNT_DIR=Mount\Install
set REG_DIR=Custom\Regedit

set Error=0
RD /S /Q Custom\Turn_Regedit > NUL 2>&1
MD Custom\Turn_Regedit > NUL 2>&1
FOR /f "tokens=*" %%g in ('dir /b /s Custom\Regedit\*.reg 2^>NUL') do (Call :Regedit_Convert_Rename "%%g")
timeout /t 1 /nobreak > NUL
Call :Powershell_2 "Bin\ConvertReg.ps1" "Custom\Regedit" "Custom\Turn_Regedit"
Call :RegeditInstall
:: Regedit kayıtlarını yükler
FOR /F "tokens=*" %%g in ('dir /b /s Custom\Turn_Regedit\*.reg 2^>NUL') do (
	Call :Reg_Import %%g
)
Call :RegeditCollect
RD /S /Q "Custom\Turn_Regedit" > NUL 2>&1
timeout /t 1 /nobreak > NUL
::RD /S /Q Custom\Turn_Regedit > NUL 2>&1
if %Error% EQU 0 (echo Regedit insertion successful!)
if %Error% EQU 1 (echo Regedit add failed!)
pause
goto menu

:Regedit_Convert_Rename
Rename "%~1" "%Random%%~x1" > NUL 2>&1
goto :eof

:Reg_Import
echo ► "%~1" Adding regedit record...
Reg import %~1
	if %errorlevel% NEQ 0 (set Error=1)
goto :eof

:debloat
set choice=NT
cls
echo.
echo  ====================================
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo  [1] Debloat
echo. 
echo  [2] Remove OneDrive
echo.
echo  [3] Remove Microsoft Edge
echo.
echo  [4] Remove Windows Defender
echo.
echo  [5] Remove Windows Recovery (WinRE)
echo.
echo  [6] Remove Internet Explorer
echo.
echo  [7] Remove Windos Media Player
echo.
echo  [8] Remove Microsoft Teams
echo.
echo.
echo  [Z] Back
echo  [X] Exit
echo. 
echo  ====================================
echo.
set /p choice= Please choose an option :  
if "%choice%" == "1" goto debloat_bilgi
if "%choice%" == "2" goto onedrive
if "%choice%" == "3" goto edge
if "%choice%" == "4" goto defender
if "%choice%" == "5" goto WinRE
if "%choice%" == "6" goto Internet_Explorer
if "%choice%" == "7" goto Windows_Media_Player
if "%choice%" == "8" goto Microsoft_Teams
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto debloat

:Microsoft_Teams
cls
echo.
set source=Bin\hosts
set destination=Mount\Install\Windows\System32\drivers\etc
xcopy /Y /E "%source%" "%destination%"
RD /S /Q Mount\Install\Windows\System32\drivers\etc\Regs
echo.
pause
goto debloat


:Windows_Media_Player
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Windows Media Player*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*Windows Media Player*""
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*WindowsMediaPlayer*""
echo.
echo Uninstall is complete...
pause
goto debloat


:Internet_Explorer
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Internet Explorer*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*Internet Explorer*""
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*InternetExplorer*""
echo.
echo Uninstall is complete...
pause
goto debloat

:defender
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*windows-defender*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*guard.wim*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Windows Defender*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*SecurityHealt*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*smartscreen*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*defender*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Smart Screen*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*SecHealthUI*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*guard.wim*""
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*SecurityHealt*""
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*smartscreen*""
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*SecHealthUI*""
echo.
echo Uninstall is complete...
pause
goto debloat

:edge
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Microsoft Edge*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*EdgeCore*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*EdgeUpdate*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Edge*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*edge.wim*""
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*EdgeProvider*""
cls
echo. 
echo Uninstall is complete...
pause
goto debloat

:WinRE
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Winre.wim*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*Winre.wim*""
echo.
echo Uninstall is complete...
pause
goto debloat

:onedrive
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*onedrive*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --NoLogo --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*onedrive*""
%MinSudo% --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*onedrive.wim*""
echo Uninstall is complete...
pause
goto debloat

:debloat_bilgi
cls
echo.
echo  ==============================================================================================
echo  Note: The ToolkitHelper method has more functionality and performs a more thorough cleaning
echo  compared to the Dism method. However, it runs much slower than the Dism method.
echo  ==============================================================================================
pause
goto debloat_menu

:debloat_menu
set choice=NT
cls
echo.
echo  ====================================
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo   [1] Dism Method
echo.
echo   [2] ToolkitHelper Method
echo.
echo   [Z] Back
echo   [X] Exit
echo.
echo  ====================================
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto remove_app
if "%choice%" == "2" goto remove_components
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto debloat_menu

:remove_components
set choice=NT
cls
chcp 437 > NUL 2>&1
Bin\MinSudo.exe --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "PowerShell.exe -ExecutionPolicy Bypass -File "Bin\remove_components.ps1""
Bin\MinSudo.exe --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "powershell.exe -File Bin\remove_components.ps1""
chcp 65001 >nul
cls
goto debloat_menu

:remove_app
DEL /F /Q /A "%Location%\Temp\app_list2.txt" > NUL 2>&1
set selected_packages=NT
set i=1
Dism /Image:%INSTALL% /Get-ProvisionedAppxPackages | findstr /i "PackageName" > %Location%\Temp\app_list.txt
echo %errorlevel% > C:\error.txt
cls
mode con cols=130 lines=70
echo.
echo [X] - Removes all packages
for /f "tokens=2 delims=: " %%a in ('findstr /i "PackageName" %Location%\Temp\app_list.txt') do (
  echo [!i!] - %%a
  echo Appx_!i!_= %%a >> %Location%\Temp\app_list2.txt
  set /a i+=1
)
set /a i-=1
echo.
echo [99] Geri
echo.
set /p "selected_packages=Write the numbers of the packages to be removed, separated by commas (1-%i%): "
echo %selected_packages% | Findstr /i "99" > NUL 2>&1
	if %errorlevel% EQU 0 goto menu
echo %selected_packages% | Findstr /i "x" > NUL 2>&1
	if %errorlevel% EQU 0 (FOR /L %%a in (1,1,%i%) do (Call :Find_Appx_List %%a))
for %%a in (%selected_packages%) do (
	FOR /L %%b in (1,1,%i%) do (
		if %%b EQU %%a (Call :Find_Appx_List "%%a")
	)
)
cls
echo.
goto remove_app

:Find_Appx_List
for /f "tokens=2" %%g in ('findstr /i "Appx_%~1_" %Location%\Temp\app_list2.txt') do (
	cls
    echo.
    echo "%%g" Removing...
    echo.
    Call :Remove_Dism "%%g"
    cls
)
goto :eof

:Remove_Dism
Dism /Image:Mount\Install /Remove-ProvisionedAppxPackage /PackageName:%~1 > NUL 2>&1
	if %errorlevel% NEQ 0 (set Error=1
						   echo Uninstallation process has failed..)
	if %errorlevel% EQU 0 (echo Uninstallation process has been successful.)
goto :eof

set remove_command=
set selected_packages=%selected_packages%
for /f "tokens=1 delims= " %%a in ("%selected_packages%") do (
  for /f "tokens=2" %%b in (!packages:~%%a*!) do (
    set remove_command=!remove_command! /remove-package="%%~b"
    echo Removing package: "%%~b"
    dism /Image:Mount\Install /remove-package="%%~b"
  )
)

rem Tamamlandı
if %Error% EQU 1 (echo There are applications that could not be uninstalled.)
if %Error% EQU 0 (echo All uninstallation processes have been completed successfully.)
echo.
pause
goto menu

:source
set choice=NT
cls
echo.
echo  ====================================
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo  [1] Extract the ISO file to a folder
echo.
echo  [2] Mount install.wim
echo.
echo  [Z] Back
echo  [X] Exit
echo.
echo  ====================================
echo.
set /p choice= Please choose an option : 
if "%choice%" == "1" goto iso_extract
if "%choice%" == "2" goto mount_wim
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto source

:mount_wim
cls
echo.
set InstallWim=Extracted\sources\install.wim
:: install.wim içeriğini okuması için gönderiyoruz.
cls
mode con cols=130 lines=36
Call :Toolkit_Reader "%InstallWim%"
set /p Index=Please enter the index number : 
:: Çıkarma işlemi uygulanıyor..
FOR /F "tokens=3" %%a IN ('Dism /Get-WimInfo /WimFile:%InstallWim% /Index:%Index% ^| FIND "Architecture"') do (
	FOR /F "tokens=2 delims=:" %%b IN ('Dism /Get-WimInfo /WimFile:%InstallWim% /Index:%Index% ^| FIND "Name"') do (
		FOR /F "tokens=*" %%c in ('echo %%b') do (
			echo.
			echo ► Index: %Index% │ "%%c / %%a" Mounting...
			echo.
			Dism /Mount-Image /ImageFile:%InstallWim% /MountDir:"%Location%\Mount\Install" /Index:%Index%
		)
	)
)
pause
goto menu

:iso_extract
cls
echo.
set /p iso_path=Please enter the path of the ISO file: 

if not exist %iso_path% (
  echo No ISO file was found at the specified file path
  pause
  goto iso_extract
)
if not exist Extracted (
  mkdir Extracted
)
Bin\7z.exe x %iso_path% -oExtracted
cls
echo.
echo The ISO file has been successfully extracted to the 'Extracted' folder..
pause
goto menu

:Index_Sil
set "wimlib=Bin\wimlib-imagex.exe"
set "install_wim=Extracted\sources\install.wim"
set "mount_path=Mount\Install"

set count=0

for /f "tokens=* USEBACKQ" %%F in (`dism /Get-WimInfo /WimFile:"Extracted\sources\install.wim" ^| findstr /i /c:"Index" /c:"Name" ^| findstr /v /c:"Path" /c:"\---" /c:"\(" /c:"\)" /c:"\[" /c:"\]"`) do (
  set /a count+=1
  set line=%%F
  if !count! equ 1 (
  cls
	echo -------------------------------------------------
  )
  echo !line!
  if !count! neq 1 (
    echo -------------------------------------------------
  )
)

echo.
set /p "delete_indexes=Please enter the number of the index to be deleted: "
%wimlib% delete "%install_wim%" %delete_indexes%
pause
goto menu


pause
goto menu

:wim_menu
set choice=NT
cls
set "wimlib=Bin\wimlib-imagex.exe"
set "install_wim=Extracted\sources\install.wim"
echo.
echo  ====================================
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo  [1] Convert WIM to ESD
echo.
echo  [2] Convert ESD to WIM
echo.
echo  [3] Compress the WIM file as LZMS (solid)
echo.
echo  [4] Delete version from install.wim (Delete Index)
echo.
echo  [5] Create ISO file
echo.
echo.
echo  [Z] Back
echo  [X] Exit
echo.
echo  =====================================
set /p choice= Please choose an option : 
if "%choice%" == "1" goto wim_esd
if "%choice%" == "2" goto esd_wim
if "%choice%" == "3" goto compress_wim
if "%choice%" == "4" goto Index_Sil
if "%choice%" == "5" goto make_iso
if "%choice%" == "6" goto dism_resetbase 
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto wim_menu

:dism_resetbase
cls
set choice=NT
set mountdir=Mount\Install
if exist %mountdir%\Windows (
    echo Windows imajı zaten %mountdir% konumunda mount edilmiş. ResetBase işlemine devam ediliyor...
    Dism /Image:%mountdir% /Cleanup-Image /StartComponentCleanup /ResetBase
    pause
    goto wim_menu
) else (
    echo Hata: Windows imajı %mountdir% konumunda mount edilmemiş. Lütfen imajı mount edin ve yeniden deneyin.
    pause
    goto wim_menu
)

:ince_ayarlar
cls
set choice=NT
echo  ====================================
echo          ShadesToolkit %ver%
echo  ====================================
echo.
echo  [1] Bypass Windows 11 TPM/SecureBoot
echo.
echo  [2] Disable Separated Storage
echo.
echo  [3] Remove "Your device is not meeting the system requirements" watermark on Windows 11 desktop
echo.
echo  [4] Disable Modern Standby
echo.
echo  [5] Disable Windows Defender
echo.
echo  [6] Disable "Let's finish setting up your device" prompt on Windows 11
echo.
echo  [7] Disable Privacy Settings Experience on Windows 11 Sign-in
echo.
echo  [8] Disable OneDrive
echo.
echo  [9] Disable Core Isolation Memory Integrity on Windows 11
echo.
echo  [10] Disable Including Drivers with Windows Updates
echo.
echo  [11] Disable Automatic Windows Upgrade
echo.
echo  [12] Disable Cortana
echo.
echo  [13] Remove Chat button from Taskbar on Windows 11
echo.
echo  [14] Restore the Old Right-click Context Menu on Windows 11
echo.
echo.
echo  [Z] Back
echo  [X] Exit
echo  ====================================
set /p choice=Please choose an option :

if %choice% EQU 1 goto tpmfix
if %choice% EQU 2 (Call :Settings_Regedit "Disable_Reserved_Storage")
if %choice% EQU 3 (Call :Settings_Regedit "Remove_System_requirements_not_met_watermark")
if %choice% EQU 4 (Call :Settings_Regedit "Disable_Modern_Standby") 
if %choice% EQU 5 (Call :Settings_Regedit "Disable_Microsoft_Defender_Antivirus")
if %choice% EQU 6 (Call :Settings_Regedit "Disable_Lets_finish_setting_up_your_device")
if %choice% EQU 7 (Call :Settings_Regedit "Disable_Choose_privacy_settings_experience_at_sign_in") 
if %choice% EQU 8 (Call :Settings_Regedit "Disable_OneDrive_for_all_users")
if %choice% EQU 9 (Call :Settings_Regedit "Turn_OFF_Core_isolation_Memory_integrity") 
if %choice% EQU 10 (Call :Settings_Regedit "Disable_include_drivers_with_Windows_Updates")
if %choice% EQU 11 (Call :Settings_Regedit "Never_Notify_or_Check_for_Updates")
if %choice% EQU 12 (Call :Settings_Regedit "Disable_Cortana")
if %choice% EQU 13 (Call :Settings_Regedit "Remove_Chat_button_on_taskbar_in_Windows_11") 
if %choice% EQU 14 (Call :Settings_Regedit "win11_classic_context_menu")
if "%choice%" == "15" goto WinSxs_Sıkıştır
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto ince_ayarlar

:tpmfix
chcp 65001 >nul
rem Extracted klasöründeki autounattend.xml dosyasının kopyalanması
del Extracted\autounattend.xml
xcopy /Y /E Bin\autounattend.xml Extracted\
xcopy /Y /E Bin\TPM_Fix.cmd Extracted\
RD /S /Q Extracted\Regs
cls
chcp 437 > NUL 2>&1
rem Administrator adının sorulması ve xml dosyasındaki ShadesAdmin yazısıyla değiştirilmesi
echo.
echo Please create your profile information;
echo.
set /p adminname=Please enter an administrator name: 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'ShadesAdmin','%adminname%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
chcp 437 > NUL 2>&1
rem Parolanın sorulması ve xml dosyasındaki password_change yazısıyla değiştirilmesi
echo.
set /p new_password=Please enter a password: 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'password_change','%new_password%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
cls
echo.
echo  ==================================================================
echo Autounattend.xml file has been created with the settings you specified..
echo TPM/SecureBoot Fix has been added, please do not delete or modify
echo the autounattend.xml and TPM_Fix.cmd files!
echo  ==================================================================
echo.
pause
goto ince_ayarlar

:make_iso
cls
echo.
set "ISODir=ISO"
echo.
set /p ISOName=Enter the name of the ISO file (without .iso): 
set /p ISOLabel=Enter the ISO Label value:

if not exist "%ISODir%" mkdir "%ISODir%"

set "IMAGE=Extracted"
set "ISOPath=%ISODir%\"

if exist "%IMAGE%\efi\microsoft\boot\efisys.bin" (
    "Bin\oscdimg.exe" -l"%ISOLabel%" -m -oc -u2 -udfver102 -bootdata:2#p0,e,b"%IMAGE%\boot\etfsboot.com"#pEF,e,b"%IMAGE%\efi\microsoft\boot\efisys.bin" "%IMAGE%" "%ISOPath%%ISOName%.iso"
) else (
    "Bin\oscdimg.exe" -l"%ISOLabel%" -m -oc -u2 -udfver102 -b"%IMAGE%\boot\etfsboot.com" "%IMAGE%" "%ISODir%\%ISOName%.iso"
)
cls
echo.
echo Your ISO file has been saved to the 'ISO' folder.
pause>nul
goto menu


:wim_esd
dism /Export-Image /SourceImageFile:Extracted\sources\install.wim /SourceIndex:1 /DestinationImageFile:Extracted\sources\install.esd /Compress:LZX /CheckIntegrity
echo.
echo Wim-Esd conversion process has been completed! It has been saved to the 'Extracted\sources' folder.
pause
goto wim_menu

:esd_wim
dism /Export-Image /SourceImageFile:Extracted\sources\install.esd /SourceIndex:1 /DestinationImageFile:Extracted\sources\install.wim /Compress:LZX /CheckIntegrity
echo.
echo Esd-Wim conversion process has been completed! It has been saved to the 'Extracted\sources' folder.
pause
goto wim_menu

:compress_wim
set "source_file=.\Extracted\sources\install.wim"
set "dest_file=Extracted\sources\install_LZMS.wim"
set "export_param=all"
set "compress_param=lzms"
set wimlib=Bin\wimlib-imagex.exe
set "solid_param=--solid"
REM Wimlib imagex komutunu kullanarak install.wim dosyasını işleyin
%wimlib% export "%source_file%" "%export_param%" "%dest_file%" --compress="%compress_param%" %solid_param%
echo.
echo -----------------------------------------------------------------
echo.
echo Wim file compression has been completed as LZMS!
pause
goto wim_menu

:dismount_commit
cls
echo.
dism /unmount-Wim /MountDir:Mount\Install /commit
cls
Bin\wimlib-imagex export Extracted\sources\install.wim all Extracted\sources\install_new.wim --compress=Max
cls
del /S /Q Extracted\sources\install.wim > NUL 2>&1
cls
ren Extracted\sources\install_new.wim install.wim
cls
Bin\wimlib-imagex optimize Extracted\sources\install.wim --recompress --nocheck
cls
echo.
echo Changes have been saved.
pause
goto menu

:end
cls
echo Exited..
timeout /t 3
exit

:Powershell
chcp 437 > NUL 2>&1
Powershell -command %*
chcp 65001 > NUL 2>&1
goto :eof

:Powershell_2
chcp 437 > NUL 2>&1
Powershell -NoLogo -NoProfile -NonInteractive -ExecutionPolicy Bypass -Command %*
chcp 65001 > NUL 2>&1
goto :eof

:RegeditInstall
reg load HKLM\SHADES_COMPONENTS "Mount\Install\Windows\System32\config\COMPONENTS" > NUL 2>&1
reg load HKLM\SHADES_HKU "Mount\Install\Windows\System32\config\default" > NUL 2>&1
reg load HKLM\SHADES_HKCU "Mount\Install\Users\Default\ntuser.dat" > NUL 2>&1
reg load HKLM\SHADES_SOFTWARE "Mount\Install\Windows\System32\config\SOFTWARE" > NUL 2>&1
reg load HKLM\SHADES_SYSTEM "Mount\Install\Windows\System32\config\SYSTEM" > NUL 2>&1
goto :eof

:RegeditCollect
reg delete "HKLM\OFF_SYSTEM\CurrentControlSet" /f > NUL 2>&1
FOR /F "tokens=*" %%a in ('reg query "HKLM" ^| findstr "{"') do (
	reg unload "%%a" > NUL 2>&1
)
FOR /F "tokens=*" %%a in ('reg query "HKLM" ^| findstr "TK_"') do (
	reg unload "%%a" > NUL 2>&1
)
FOR /F "tokens=*" %%a in ('reg query "HKLM" ^| findstr "NLTmp~"') do (
	reg unload "%%a" > NUL 2>&1
)
FOR /F "tokens=*" %%a in ('reg query "HKLM" ^| findstr "SHADES_"') do (
	reg unload "%%a" > NUL 2>&1
)
goto :eof

:Toolkit_Reader
echo  ┌───────┬──────────────┬───────────────┬─────────────┬─────────────┬──────────────────────────────────────┐
echo  │ INDEX │ Architecture │    VERSION    │  lANGUAGE   │    EDIT     │            NAME                      │
FOR /F "tokens=3" %%a IN ('Dism /Get-WimInfo /WimFile:%~1 ^| FIND "Index"') DO (
	FOR /F "tokens=3" %%b IN ('Dism /Get-WimInfo /WimFile:%~1 /Index:%%a ^| FIND "Architecture"') DO (
		FOR /F "tokens=3" %%c in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| Find "Version"') do (
			FOR /F "tokens=3 delims=." %%d in ('"echo %%c"') do (
				FOR /F "tokens=4" %%e in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| Find "Build"') do (
					FOR /F "tokens=1" %%f in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Default') do (
						FOR /F "tokens=2 delims=':'" %%g in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Name') do (
							FOR /F "tokens=2 delims='-',':' " %%h in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Modified') do (
								echo  ├───────┼──────────────┼───────────────┼─────────────┼─────────────┼──────────────────────────────────────┤
								echo      %%a   ►   %%b     %%d.%%e     %%f    %%h    %%g
								)
							)
						)
					)
				)
			)
		)
	)
)     │       │        │             │        │             │                                         │
echo  └───────┴────────┴─────────────┴────────┴─────────────┴─────────────────────────────────────────┘
goto :eof
