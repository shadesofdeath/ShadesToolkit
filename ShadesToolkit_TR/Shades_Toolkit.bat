:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Bu proje ShadesOfDeath tarafından geliştirilmektedir.
:: Github Adresim : https://github.com/shadesofdeath
:: Kahve Ismarla : https://www.buymeacoffee.com/berkayay
:: Bu proje başkaları tarafından geliştirilebilir. Ancak, orijinal içerik
:: bağlantıları paylaşmak ve paylaşan geliştiricinin kaynağın orijinal yaratıcısı
:: olduğunu belirtmek şartıyla yapılabilir.
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off
color 1F
setlocal enabledelayedexpansion
set ver=v1.7
title ShadesToolkit %ver% - by ShadesOfDeath
chcp 65001 >nul
mode con cols=100 lines=35
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

:: Konum bilgisi
cd /d "%~dp0"
for /f %%a in ('"cd"') do set Location=%%a
set INSTALL=%Location%\Mount\Install
set InstallWim=%Location%\Extracted\sources\install.wim
:: Yüklü mount yollarını alır ve remount işlemi yapar. Bunun uygulanması olası hataları önlemektedir.
FOR /F "tokens=4" %%a in ('dism /get-mountedwiminfo ^| FIND "Mount Dir"') do (
	FOR /F "delims=\\? tokens=*" %%b in ('echo %%a') do (
		Dism /Remount-Image /MountDir:"%%b" > NUL 2>&1
		cls
	)
)
cls
:: silme
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
    choice /C EH /M "► Önceki çalışmanızdan kalıntılar var temizlensin mi? "
    cls
    if errorlevel 2 (
        goto menu
    )
	Dism /Unmount-image /MountDir:%INSTALL% /Discard
)
:menu
set choice=NT
cls
echo.
echo  ====================================
echo.         ShadesToolkit %ver%
echo  ====================================
echo.
echo   [1] Kaynak
echo.
echo   [2] Entegre et
echo.
echo   [3] Kaldır
echo.
echo   [4] Windows Özellikleri
echo.
echo   [5] Özelleştir
echo.
echo   [6] İnce Ayarlar
echo.
echo   [7] Windows Servisleri
echo.
echo   [8] Değişikleri Uygula
echo.
echo   [9] Diğer
echo.
echo.
echo   [D] Destek Ver
echo.
echo   [X] Çıkış
echo.
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
if "%choice%" == "1" goto source
if "%choice%" == "2" goto entegre
if "%choice%" == "3" goto debloat
if "%choice%" == "4" goto etkin_devredısı
if "%choice%" == "5" goto customize
if "%choice%" == "6" goto ince_ayarlar
if "%choice%" == "7" goto windows_services
if "%choice%" == "8" goto dismount_commit
if "%choice%" == "9" goto wim_menu
if "%choice%" == "d" goto DESTEK
if "%choice%" == "D" goto DESTEK
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto menu

:DESTEK
start "" "Bin\Thanx.html"
cls
goto menu

:windows_services
cls
set choice=NT
mode con cols=140 lines=37
echo  =====================================================================================================================================
echo.                                                   ShadesToolkit %ver%
echo  =====================================================================================================================================
echo.
echo   [1] Sysmain Devre Dışı Bırak                                 [14] Uygulama Katmanı Ağ Geçidi Hizmeti Devre Dışı Bırak 
echo.                                      
echo   [2] Yazdırma Biriktiricisi Devre Dışı Bırak                  [15] Uygulama yönetimi Hizmeti Devre Dışı Bırak 
echo.
echo   [3] Hata raporlama servisi Devre Dışı Bırak                  [16] Bluetooth Ses Ağ Geçidi Hizmeti Devre Dışı Bırak
echo.
echo   [4] Faks Hizmeti Devre Dışı Bırak                            [17] Bluetooth Destek Hizmeti Devre Dışı Bırak
echo.
echo   [5] Telefon Hizmeti Devre Dışı Bırak                         [18] Yakalama Hizmeti Devre Dışı Bırak
echo.
echo   [6] Uzak Masaüstü Hizmeti Devre Dışı Bırak                   [19] Sertifika Yayılımı Devre Dışı Bırak
echo.
echo   [7] Windows Yedekleme Hizmeti Devre Dışı Bırak               [20] Aygıt Yönetimi Kablosuz Uygulama Protokolü Devre Dışı Bırak
echo.
echo   [8] Windows Defender Hizmeti Devre Dışı Bırak                [21] İndirilen Haritalar Yöneticisi Devre Dışı Bırak
echo.
echo   [9] Windows Defender Güvenlik Duvarı Devre Dışı Bırak        [22] Coğrafi Konum Hizmeti Devre Dışı Bırak
echo.
echo   [10] Windows Insider Hizmeti Devre Dışı Bırak                [23] İnternet Bağlantı Paylaşımı (ICS) Devre Dışı Bırak
echo. 
echo   [11] Windows Arama Devre Dışı Bırak                          [24] IP Yardımcısı (IPv6 çevirisi) Devre Dışı Bırak
echo.
echo   [12] Windows Update Hizmeti Devre Dışı Bırak                 [25] IP Çeviri Yapılandırma Hizmeti (IPv6 çevirisi) Devre Dışı Bırak
echo.
echo   [13] Windows Update Sağlığı Hizmeti Devre Dışı Bırak         [26] Tüm Servisleri Devre Dışı Bırak
echo.            
echo  =====================================================================================================================================
echo.                              [Z] Geri                                                    [X] Çıkış
echo  =====================================================================================================================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
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
echo Tüm servisler devre dışı bırakıldı..
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
echo   [1] Windows Özelliklerini Etkinleştir
echo.
echo   [2] Windows Özelliklerini Devre Dışı bırak
echo.
echo.
echo   [Z] Geri
echo.
echo   [X] Çıkış
echo.
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
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
echo  ==================================================
echo.          Windows Özellikleri Etkinleştir
echo  ==================================================
echo.
echo  [1] DirectPlay
echo.
echo  [2] Microsoft Windows Alt Sistemi için Linux
echo.
echo  [3] .NET Framework 3.5
echo.
echo  [4] PDF Yazdırma Hizmetleri Özellikleri
echo.
echo  [5] XPS Hizmetleri Özellikleri
echo.
echo  [6] Arama Motoru İstemci Paketi
echo.
echo  [7] Telnet İstemcisi
echo.
echo  [8] Eski Bileşenler (LegacyComponents)
echo.
echo  [9] WorkFolders İstemcisi
echo.
echo  [10] Yazdırma Temel Özellikleri
echo.
echo  [11] İnternet Yazdırma İstemcisi
echo.
echo  [12] Microsoft Uzak Masaüstü Altyapısı
echo.
echo  [13] Sanal Makine Platformu
echo.
echo  [14] Basit TCP
echo.
echo  [15] .NET Framework 4 Gelişmiş Hizmetler
echo.
echo  [16] Microsoft Hyper-V
echo.
echo  [17] Windows Media Player
echo.
echo  [18] SMB1Protokolü
echo.
echo.
echo  [Z] Geri
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
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
echo  ==================================================
echo.       Windows Özellikleri Devre Dışı Bırak
echo  ==================================================
echo.
echo  [1] DirectPlay
echo.
echo  [2] Microsoft Windows Alt Sistemi için Linux
echo.
echo  [3] .NET Framework 3.5
echo.
echo  [4] PDF Yazdırma Hizmetleri Özellikleri
echo.
echo  [5] XPS Hizmetleri Özellikleri
echo.
echo  [6] Arama Motoru İstemci Paketi
echo.
echo  [7] Telnet İstemcisi
echo.
echo  [8] Eski Bileşenler (LegacyComponents)
echo.
echo  [9] WorkFolders İstemcisi
echo.
echo  [10] Yazdırma Temel Özellikleri
echo.
echo  [11] İnternet Yazdırma İstemcisi
echo.
echo  [12] Microsoft Uzak Masaüstü Altyapısı
echo.
echo  [13] Sanal Makine Platformu
echo.
echo  [14] Basit TCP
echo.
echo  [15] .NET Framework 4 Gelişmiş Hizmetler
echo.
echo  [16] Microsoft Hyper-V
echo.
echo  [17] Windows Media Player
echo.
echo  [18] SMB1Protokolü
echo.
echo.
echo  [Z] Geri
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
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
echo   [1] DefaultLayout.xml temizleme
echo.
echo   [2] Sistem Ayarları
echo.
echo   [3] Sistem Açıldıktan sonra Sistem Dosyalarını Sıkıştır
echo.
echo   [4] Autounattend.xml oluştur
echo.
echo   [5] Bir sonraki Windows versiyonu belirle
echo.
echo   [6] Masaüstüne MASS_AIO Windows Etkinleştirme Scriptini Ekle
echo.
echo   [7] Bağlam Menüsü Özelleştir
echo.
echo   [Z] Geri
echo   [X] Çıkış
echo.
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
if "%choice%" == "1" goto default_layout
if "%choice%" == "2" goto Sistem_Ayarları
if "%choice%" == "3" goto compress
if "%choice%" == "4" goto auto_unattend
if "%choice%" == "5" goto target_windows_version
if "%choice%" == "6" goto MASS_AIO
if "%choice%" == "7" goto ContextMenu
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto customize

:ContextMenu
set choice=NT
cls
echo.
echo  ====================================
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo   [1] Bağlam menüsüne Windows Ayarları kısayolu ekle
echo.
echo   [2] Bağlam menüsüne yeni BATCH dosya kısayolu ekle
echo.
echo   [3] Bağlam menüsüne yeni VBScript dosya kısayolu ekle
echo.
echo   [4] Bağlam menüsüne Explorer yeniden başlat kısayolu ekle
echo.
echo   [5] Bağlam menüsüne Çöp kutusunu boşalt kısayolu ekle
echo.
echo   [6] Bağlam menüsüne Sahiplik AL kısayolu ekle
echo.
echo.
echo   [Z] Geri
echo   [X] Çıkış
echo.
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
if %choice% EQU 1 (Call :Settings_Regedit "Add Windows Tools Context Menu")
if %choice% EQU 2 (Call :Settings_Regedit "Add New Batch File Context Menu")
if %choice% EQU 3 (Call :Settings_Regedit "Add New VBScript Context Menu")
if %choice% EQU 4 (Call :Settings_Regedit "Add Restart Explorer Context Menu")
if %choice% EQU 5 (Call :Settings_Regedit "Empty Recycle Bin Context Menu")
if %choice% EQU 6 (Call :Settings_Regedit "Add_Take_Ownership_to_context_menu")
if "%choice%" == "z" goto customize
if "%choice%" == "Z" goto customize
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto ContextMenu

:MASS_AIO
cls
echo.
xcopy /Y /E Bin\MAS_AIO.cmd Mount\Install\Users\Default\Desktop\
RD /S /Q Mount\Install\Users\Default\Desktop\Driver
RD /S /Q Mount\Install\Users\Default\Desktop\$OEM$
RD /S /Q Mount\Install\Users\Default\Desktop\Files
RD /S /Q Mount\Install\Users\Default\Desktop\Lisans
RD /S /Q Mount\Install\Users\Default\Desktop\TurnReg
RD /S /Q Mount\Install\Users\Default\Desktop\MicrosoftStore
RD /S /Q Mount\Install\Users\Default\Desktop\Regedit
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
echo   [1] Bir sonraki sürümü 22H2 olarak ayarla
echo.
echo   [2] Bir sonraki sürümü 21H2 olarak ayarla
echo.
echo   [3] Bir sonraki sürümü 21H1 olarak ayarla
echo.
echo   [4] Bir sonraki sürümü 20H2 olarak ayarla
echo.
echo   [5] Bir sonraki sürümü 2004 olarak ayarla
echo.
echo   [6] Bir sonraki sürümü 1909 olarak ayarla
echo.
echo   [7] Bir sonraki sürümü 1903 olarak ayarla
echo.
echo   [8] Bir sonraki sürümü 1809 olarak ayarla
echo.
echo   [9] Bir sonraki sürümü 1803 olarak ayarla
echo.
echo   [10] Bir sonraki sürümü 1709 olarak ayarla
echo.
echo   [11] Bir sonraki sürümü 1703 olarak ayarla
echo.
echo   [12] Bir sonraki sürümü 1607 olarak ayarla
echo.
echo   [13] Bir sonraki sürümü 1511 olarak ayarla
echo.
echo   [14] Bir sonraki sürümü 1507 olarak ayarla
echo.
echo   [Z] Geri
echo   [X] Çıkış
echo.
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
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
rem Extracted klasöründeki autounattend.xml dosyasının kopyalanması
del Extracted\autounattend.xml
xcopy /Y /E Bin\autounattend.xml Extracted\
RD /S /Q Extracted\Driver
RD /S /Q Extracted\$OEM$
RD /S /Q Extracted\Files
RD /S /Q Extracted\Lisans
RD /S /Q Extracted\Regs
RD /S /Q Extracted\TurnReg
RD /S /Q Extracted\MicrosoftStore
RD /S /Q Extracted\Regedit
cls
chcp 437 > NUL 2>&1
rem Administrator adının sorulması ve xml dosyasındaki ShadesAdmin yazısıyla değiştirilmesi
echo.
set /p adminname=Lutfen bir yonetici adi girin: 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'ShadesAdmin','%adminname%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
chcp 437 > NUL 2>&1
rem Parolanın sorulması ve xml dosyasındaki password_change yazısıyla değiştirilmesi
echo.
set /p new_password=Lutfen bir parola girin: 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'password_change','%new_password%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
cls
echo.
echo ==============================================================
echo Belirttiğiniz ayarlarda autounattend.xml dosyası oluşturuldu..
echo ==============================================================
timeout /t 2 >nul
pause
cls
goto menu

:compress
cls
echo.
set "targetFolder=Extracted\sources\$OEM$\$$\Setup\Scripts"
mkdir "%targetFolder%"
Bin\MinSudo --TrustedInstaller --Verbose cmd /c "xcopy /Y /E Bin\$OEM$\$$\Setup\Scripts\compress.bat Extracted\sources\$OEM$\$$\Setup\Scripts"
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Driver
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\$OEM$
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Files
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Lisans
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Regs
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\TurnReg
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\MicrosoftStore
RD /S /Q Extracted\sources\$OEM$\$$\Setup\Scripts\Regedit
::RD /S /Q Mount\Install\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\Regs
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
echo  [1] Windows Fotoğraf Görüntüleyicisini Etkinleştir
echo.
echo  [2] Sağ-tık menüsüne Sahiplik Al ekle
echo.
echo  [3] 260 Karakter Sınırlamasını Kaldır
echo.
echo  [4] Görsel Geribildirim kapat (Visual Feedback)
echo.
echo  [5] Sağ-tık menüsüne Yanıt Vermeyen işlemlerini sonlandır ekle
echo.
echo  [6] Sağ-tık menüsüne Geri dönüşüm kutusunu boşalt ekle
echo.
echo  [7] Adım Kaydedicisini devre dışı bırak
echo.
echo  [8] Otomatik Oynat devre dışı bırak
echo.
echo  [9] Gelişmiş dizin oluşturma devre dışı bırak
echo.
echo  [10] Uygulama Başlatma Takibini Devre Dışı Bırak
echo.
echo  [11] XBox Game Bar kapat
echo.
echo  [12] Donanım Hızlandırmalı GPU Zamanlamasını Devre Dışı Bırak
echo.
echo  [13] Hazırda Bekletme Devre Dışı Bırak
echo.
echo  [14] Eski Ses Çubuğunu ekle
echo.
echo  [15] Sağ-tık Yol Olarak Kopyala seçeneği ekle
echo.
echo  [16] JPEG Masaüstü Duvar Kağıdı Kalitesini Düşürme devre dışı bırak
echo.
echo  [17] Windows Uygulama Temasını Karanlık Mod yap
echo.
echo  [18] Windows Temasını Karanlık Mod yap
echo.
echo  [19] Masaüstünde Bilgisayarım Kısayolunu Ekle
echo.
echo  [20] Masaüstünde Denetim Masası Kısayolunu Ekle
echo.
echo.
echo  [Z] Geri
echo  ====================================
set /p choice=Lütfen bir seçenek belirle :
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
:: Offline regedit eklemek için Regedit klasörüne eklenen .reg dosyaları uygun şekilde düzenlenir.
:: Regedit kayıtlarında boşluk ve Türkçe harf olma ihtimaline karşılık isimlerine random sayılar veriyorum.
FOR /f "tokens=*" %%g in ('dir /b /s %Location%\Bin\TurnReg\*.reg 2^>NUL') do (Call :Regedit_Convert_Rename "%%g")
timeout /t 1 /nobreak > NUL
Call :Powershell_2 "Bin\ConvertReg.ps1" "%Location%\Bin\TurnReg" "%Location%\Bin\TurnReg"
Call :RegeditInstall
:: Regedit kayıtlarını yükler
FOR /F "tokens=*" %%g in ('dir /b /s %Location%\Bin\TurnReg\*.reg 2^>NUL') do (
	Call :Reg_Import %%g
)
Call :RegeditCollect
RD /S /Q "%Location%\Bin\TurnReg" > NUL 2>&1
goto :eof

:default_layout
cls
echo.
Bin\MinSudo --TrustedInstaller --Verbose cmd /c "xcopy /Y /E Bin\DefaultLayouts.xml Mount\Install\Users\Default\AppData\Local\Microsoft\Windows\Shell\"
Bin\MinSudo --TrustedInstaller --Verbose cmd /c "xcopy /Y /E Bin\LayoutModification.xml Mount\Install\Users\Default\AppData\Local\Microsoft\Windows\Shell\"
Bin\MinSudo --TrustedInstaller --Verbose cmd /c "xcopy /Y /E Bin\LayoutModification.json Mount\Install\Users\Default\AppData\Local\Microsoft\Windows\Shell\"
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
echo  [1] Özel Regedit Kayıtları ekle
echo.
echo  [2] Özel Dosyalar
echo.
echo  [3] Driver entegre et
echo.
echo  [4] MicrosoftStore entegre et
echo.
echo.
echo  [Z] Geri
echo.
echo  [X] Çıkış
echo.
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle :  
if "%choice%" == "1" goto custom_regedit
if "%choice%" == "2" goto özel_dosyalar
if "%choice%" == "3" goto driver_entegre
if "%choice%" == "4" goto MicrosoftStore
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto entegre

:MicrosoftStore
set choice=NT
cls
REM Microsoft Store ve gerekli componentler indirme işlemi
set "URL1=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.DesktopAppInstaller.msixbundle"
set "URL2=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.NET.Native.Framework.1.3.x64.appx"
set "URL3=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.NET.Native.Framework.2.2.x64.Appx"
set "URL4=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.NET.Native.Runtime.1.3.x64.appx"
set "URL5=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.NET.Native.Runtime.2.2.x64.Appx"
set "URL6=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.UI.Xaml.2.4.x64.Appx"
set "URL7=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.UI.Xaml.2.7.x64.Appx"
set "URL8=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.VCLibs.140.00.UWPDesktop.x64.appx"
set "URL9=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.VCLibs.140.00.x64.Appx"
set "URL10=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.WindowsStore.msixbundle"
set "URL11=https://github.com/DarkOS-CustomWindows/Microsoft-Store-Install/raw/main/Microsoft.XboxIdentityProvider.AppxBundle"

REM dosyaların kaydedileceği yolu seçin
set download_path=Custom\MicrosoftStore

REM aria2c'yi kullanarak dosyaları indirin
IF NOT EXIST Custom\MicrosoftStore\Microsoft.DesktopAppInstaller.msixbundle (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL1%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.NET.Native.Framework.1.3.x64.appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL2%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.NET.Native.Framework.2.2.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL3%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.NET.Native.Runtime.1.3.x64.appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL4%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.NET.Native.Runtime.2.2.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL5%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.UI.Xaml.2.4.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL6%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.UI.Xaml.2.7.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL7%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.VCLibs.140.00.UWPDesktop.x64.appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL8%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.VCLibs.140.00.x64.Appx (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL9%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.WindowsStore.msixbundle (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL10%"
)
IF NOT EXIST Custom\MicrosoftStore\Microsoft.XboxIdentityProvider.AppxBundle (
  Bin\aria2c.exe -x 16 -s 16 -d "%download_path%" "%URL11%"
)
cls
echo.
echo Microsoft Store ve gerekli paketler indirildi..
set mountdir=Mount\Install
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.DesktopAppInstaller.msixbundle /LicensePath=Bin\Lisans\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.xml /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.NET.Native.Framework.1.3.x64.appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.NET.Native.Framework.2.2.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.NET.Native.Runtime.1.3.x64.appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.NET.Native.Runtime.2.2.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.UI.Xaml.2.4.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.UI.Xaml.2.7.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.VCLibs.140.00.UWPDesktop.x64.appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.VCLibs.140.00.x64.Appx /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.WindowsStore.msixbundle /SkipLicense /region=all
Dism /image:%mountdir% /Add-ProvisionedAppxPackage /PackagePath:Custom\MicrosoftStore\Microsoft.XboxIdentityProvider.AppxBundle /LicensePath=Bin\Lisans\Microsoft.XboxIdentityProvider_8wekyb3d8bbwe.xml /region=all
DISM.exe /Image:Mount\Install /Optimize-ProvisionedAppxPackages
pause
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
echo.        ShadesToolkit %ver%
echo  ====================================
echo.
echo  [1] Özel İmleç dosyalarını ekle (Custom\Files\Windows\Cursors)
echo.
echo  [2] Özel Medya dosyalarını ekle (Custom\Files\Windows\Media)
echo.
echo  [3] Özel Tema dosyalarını ekle (Custom\Files\Windows\Resources)
echo.
echo  [4] Özel System32 dosyalarını ekle (Custom\Files\Windows\System32)
echo.
echo  [5] Özel SysWOW64 dosyalarını ekle (Custom\Files\Windows\SysWOW64)
echo.
echo  [6] Özel Masaüstü arka planı dosyalarını ekle (Custom\Files\Windows\Web)
echo.
echo  [7] Özel Masaüstü Dosya-Klasör ekle (Desktop)
echo.
echo  [Z] Geri
echo  [X] Çıkış
echo.
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle :  
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
RD /S /Q Mount\Install\Users\Default\Desktop\Driver
RD /S /Q Mount\Install\Users\Default\Desktop\$OEM$
RD /S /Q Mount\Install\Users\Default\Desktop\Files
RD /S /Q Mount\Install\Users\Default\Desktop\Lisans
RD /S /Q Mount\Install\Users\Default\Desktop\Regs
RD /S /Q Mount\Install\Users\Default\Desktop\TurnReg
RD /S /Q Mount\Install\Users\Default\Desktop\MicrosoftStore
RD /S /Q Mount\Install\Users\Default\Desktop\Regedit
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
%MinSudo% --TrustedInstaller --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Web"
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
%MinSudo% --TrustedInstaller --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Resources"
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
%MinSudo% --TrustedInstaller --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Media"
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
%MinSudo% --TrustedInstaller --Verbose --WorkDir="Mount\Install\Windows" cmd /c "rmdir /S /Q Cursors"
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
:: Offline regedit eklemek için Regedit klasörüne eklenen .reg dosyaları uygun şekilde düzenlenir.
:: Regedit kayıtlarında boşluk ve Türkçe harf olma ihtimaline karşılık isimlerine random sayılar veriyorum.
FOR /f "tokens=*" %%g in ('dir /b /s Custom\Regedit\*.reg 2^>NUL') do (Call :Regedit_Convert_Rename "%%g")
timeout /t 2 /nobreak > NUL
Call :Powershell_2 "Bin\ConvertReg.ps1" "Custom\Regedit" "Custom\Turn_Regedit"
Call :RegeditInstall
:: Regedit kayıtlarını yükler
FOR /F "tokens=*" %%g in ('dir /b /s Custom\Turn_Regedit\*.reg 2^>NUL') do (
	Call :Reg_Import %%g
)
Call :RegeditCollect
RD /S /Q "Custom\Turn_Regedit" > NUL 2>&1
timeout /t 2 /nobreak > NUL
::RD /S /Q Custom\Turn_Regedit > NUL 2>&1
if %Error% EQU 0 (echo Regedit ekleme işlemi başarılı)
if %Error% EQU 1 (echo Regedit ekleme işlemi başarısız)
pause
goto menu

:Regedit_Convert_Rename
Rename "%~1" "%Random%%~x1" > NUL 1>&1
goto :eof

:Reg_Import
echo ► "%~1" regedit kaydı ekleniyor...
timeout /t 3 /nobreak > NUL
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
echo  [2] OneDrive kaldır
echo.
echo  [3] Microsoft Edge Kaldır
echo.
echo  [4] Windows Defender Kaldır
echo.
echo  [5] Windows Recovery kaldır (WinRE)
echo.
echo  [6] Internet Explorer kaldır
echo.
echo  [7] Windos Media Player kaldır
echo.
echo  [8] Microsoft Teams kaldır
echo.
echo.
echo  [Z] Geri
echo.
echo  [X] Çıkış
echo. 
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle :  
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
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*Windows Media Player*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*WindowsMediaPlayer*""
echo.
echo Kaldırma işlemi tamamlandı..
pause
goto debloat


:Internet_Explorer
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Internet Explorer*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*Internet Explorer*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*InternetExplorer*""
echo.
echo Kaldırma işlemi tamamlandı..
pause
goto debloat

:defender
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*windows-defender*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*guard.wim*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Windows Defender*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*SecurityHealt*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*smartscreen*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*defender*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Smart Screen*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*SecHealthUI*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*guard.wim*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*SecurityHealt*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*smartscreen*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*SecHealthUI*""
echo.
echo Kaldırma işlemi tamamlandı..
pause
goto debloat

:edge
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Microsoft Edge*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*EdgeCore*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*EdgeUpdate*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Edge*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*edge.wim*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*EdgeProvider*""
cls
echo. 
echo Kaldırma işlemi tamamlandı..
pause
goto debloat

:WinRE
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*Winre.wim*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*Winre.wim*""
echo.
echo Kaldırma işlemi tamamlandı..
pause
goto debloat

:onedrive
cls
echo.
set MinSudo=Bin\MinSudo.exe
set InstallDir=Mount\Install
for /f "delims=" %%i in ('dir /s /b /ad "%InstallDir%\*onedrive*"') do (
    if exist "%%i" (
        %MinSudo% --TrustedInstaller --Verbose --Privileged --NoLogo --WorkDir="" cmd /c "rmdir /s /q "%%i""
    )
)
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*onedrive*""
%MinSudo% --TrustedInstaller --Verbose --WorkDir="" cmd /c "del /S /Q "%InstallDir%\*onedrive.wim*""
echo Kaldırma işlemi tamamlandı..
pause
goto debloat

:debloat_bilgi
cls
echo.
echo ==============================================================================================
echo  Not : ToolkitHelper metodu dism metoduna göre işlevselliği daha fazladır ve daha derinlemesine
echo  temizlik yapar. Fakat Dism metoduna göre çok daha yavaş çalışır.
echo ==============================================================================================
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
echo   [1] Dism Metodu
echo.
echo   [2] ToolkitHelper Metodu
echo.
echo.
echo   [Z] Geri
echo   [X] Çıkış
echo.
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
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
chcp 65001 >nul
cls
goto debloat_menu

:remove_app
if exist "Mount\Install\Windows\regedit.exe" (
  cls
  goto remove_app_start
) else (
  cls
  echo --------------------------------------------
  echo Lütfen önce mount işlemini gerçekleştirin!
  echo --------------------------------------------
  pause
  cls
  goto debloat_menu
)
:remove_app_start
DEL /F /Q /A "%Location%\Temp\app_list2.txt" > NUL 2>&1
set selected_packages=NT
set i=1
Dism /Image:%INSTALL% /Get-ProvisionedAppxPackages | findstr /i "PackageName" > %Location%\Temp\app_list.txt
echo %errorlevel% > C:\error.txt

rem Temp\app_list.txt dosyasından paket adlarını oku
cls
mode con cols=130 lines=70
echo.
echo [X] - Tüm paketleri kaldırır
for /f "tokens=2 delims=: " %%a in ('findstr /i "PackageName" %Location%\Temp\app_list.txt') do (
  echo [!i!] - %%a
  echo Appx_!i!_= %%a >> %Location%\Temp\app_list2.txt
  set /a i+=1
)
set /a i-=1
rem Paket adlarını listele ve seçim yap
echo.
echo [99] Geri
echo.
set /p "selected_packages=Kaldırılacak paketlerin numaralarını virgül koyarak yazın (1-%i%): "
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
goto remove_app_start

:Find_Appx_List
for /f "tokens=2" %%g in ('findstr /i "Appx_%~1_" %Location%\Temp\app_list2.txt') do (
	cls
    echo.
    echo "%%g" kaldırılıyor...
    echo.
    Call :Remove_Dism "%%g"
    cls
)
goto :eof

:Remove_Dism
Dism /Image:Mount\Install /Remove-ProvisionedAppxPackage /PackageName:%~1 > NUL 2>&1
	if %errorlevel% NEQ 0 (set Error=1
						   echo Kaldırma işlemi başarısız.)
	if %errorlevel% EQU 0 (echo Kaldırma işlemi başarılı.)
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
if %Error% EQU 1 (echo Kaldırılamayan uygulamalar mevcut)
if %Error% EQU 0 (echo Tüm kaldırma işlemleri başarılı şekilde gerçekleşti)
echo .
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
echo  [1] ISO Dosyasını klaöre çıkar
echo.
echo  [2] Install.wim mount et
echo.
echo  [Z] Geri
echo  [X] Çıkış
echo.
echo  ====================================
echo.
set /p choice= Lütfen bir seçenek belirle : 
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
set /p Index=Index numarasını seçiniz : 
:: Çıkarma işlemi uygulanıyor..
FOR /F "tokens=3" %%a IN ('Dism /Get-WimInfo /WimFile:%InstallWim% /Index:%Index% ^| FIND "Architecture"') do (
	FOR /F "tokens=2 delims=:" %%b IN ('Dism /Get-WimInfo /WimFile:%InstallWim% /Index:%Index% ^| FIND "Name"') do (
		FOR /F "tokens=*" %%c in ('echo %%b') do (
			echo.
			echo ► Index: %Index% │ "%%c / %%a" mount ediliyor...
			echo.
			Dism /Mount-Image /ImageFile:%InstallWim% /MountDir:"%Location%\Mount\Install" /Index:%Index%
		)
	)
)
pause
goto menu

:iso_extract
set choice=NT
cls
chcp 437 > NUL 2>&1
Bin\MinSudo.exe --TrustedInstaller --NoLogo --Verbose --WorkDir="" cmd /c "PowerShell.exe -ExecutionPolicy Bypass -File "Bin\iso_extract.ps1""
chcp 65001 >nul
cls
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
set /p "delete_indexes=Silinecek indexin numarasını girin: "
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
echo  [1] Wim ESD çevir
echo.
echo  [2] ESD Wim çevir
echo.
echo  [3] Wim dosyasını LZMS (solid) olarak sıkıştır
echo.
echo  [4] Install.wim dosyasından sürüm sil (Index Sil)
echo.
echo  [5] ISO Dosyası oluştur
echo.
echo  [6] Dism ResetBase İşlemini başlat
echo.
echo  [M] Müzik Dinle
echo.
echo  [Z] Geri
echo.
echo  [X] Çıkış
echo.
echo  =====================================
set /p choice= Lütfen bir seçenek belirle : 
if "%choice%" == "1" goto wim_esd
if "%choice%" == "2" goto esd_wim
if "%choice%" == "3" goto compress_wim
if "%choice%" == "4" goto Index_Sil
if "%choice%" == "5" goto make_iso
if "%choice%" == "6" goto dism_resetbase 
if "%choice%" == "m" goto muzik
if "%choice%" == "M" goto muzik
if "%choice%" == "z" goto menu
if "%choice%" == "Z" goto menu
if "%choice%" == "x" goto end
if "%choice%" == "X" goto end
goto wim_menu

:muzik
set "music_file=Bin\music.mp3"
cls
echo.
echo  =====================================
echo  [1] Müziği Baslat
echo  =====================================
echo  [2] Müziği Durdur
echo  =====================================
echo.
set /p choice="Seciminizi girin (1 veya 2): "

if "%choice%"=="1" (
    start "" "%music_file%"
    goto wim_menu
) else if "%choice%"=="2" (
    taskkill /f /im wmplayer.exe >nul 2>&1
	taskkill /f /im vlc.exe >nul 2>&1
	taskkill /f /im music.UI.exe >nul 2>&1
	taskkill /f /im mpc-hc.exe >nul 2>&1
	taskkill /f /im PotPlayerMini.exe >nul 2>&1
	taskkill /f /im foobar2000.exe >nul 2>&1
	taskkill /f /im realplay.exe >nul 2>&1
	taskkill /f /im gom.exe >nul 2>&1
	taskkill /f /im KMPlayer.exe >nul 2>&1
	taskkill /f /im AIMP.exe >nul 2>&1
	taskkill /f /im QuickTimePlayer.exe >nul 2>&1
	taskkill /f /im 5kplayer.exe >nul 2>&1
	taskkill /f /im DivX.exe >nul 2>&1
	taskkill /f /im PowerDVD*.exe >nul 2>&1
	taskkill /f /im MediaMonkey.exe >nul 2>&1
	taskkill /f /im PowerMediaPlayer.exe >nul 2>&1
	taskkill /f /im PlexMediaPlayer.exe >nul 2>&1
	taskkill /f /im MediaGo.exe >nul 2>&1
	taskkill /f /im audacious.exe >nul 2>&1
    goto wim_menu
) else (
	echo.
    echo  Gecersiz secim! Lutfen 1 veya 2 girin.
    pause
    goto wim_menu
)


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
echo  [2] Ayrılmış Depolamayı Devre Dışı Bırak  
echo.
echo  [3] Windows 11 Masaüstünde "Sistem gereksinimleri karşılanmadı" Filigranını kaldırın
echo.
echo  [4] Modern Beklemeyi Devre Dışı Bırak 
echo.
echo  [5] Windows Defender Deve Dışı Bırak
echo.
echo  [6] Windows 11'de cihazınızın kurulumunu tamamlayalım uyarısını Devre Dışı Bırak
echo.
echo  [7] Windows 11'de Oturum Açma Sırasında Gizlilik Ayarları Deneyimini Seçmeyi Devre Dışı Bırak
echo.
echo  [8] OneDrive Devre Dışı Bırak
echo.
echo  [9] Windows 11'de Çekirdek İzolasyon Bellek Bütünlüğünü Devre Dışı Bırak
echo.
echo  [10] Windows Güncellemelerine Sürücüleri Dahil Etmeyi Devre Dışı Bırak
echo.
echo  [11] Otomatik Windows Yükseltmesini Devre Dışı Bırak 
echo.
echo  [12] Cortana Devre Dışı Bırak
echo.
echo  [13] Windows 11'de Görev Çubuğuna Sohbet Düğmesini Kaldır
echo.
echo  [14] Windows 11'de Eski Sağ Tıklama Bağlam menüsünü geri yükle
echo.
echo.
echo  [Z] Geri
echo.
echo  [X] Çıkış
echo  ====================================
set /p choice=Lütfen bir seçenek belirle :

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
RD /S /Q Extracted\Driver
RD /S /Q Extracted\$OEM$
RD /S /Q Extracted\Files
RD /S /Q Extracted\Lisans
RD /S /Q Extracted\TurnReg
RD /S /Q Extracted\MicrosoftStore
RD /S /Q Extracted\Regedit
RD /S /Q Extracted\Regs
cls
chcp 437 > NUL 2>&1
rem Administrator adının sorulması ve xml dosyasındaki ShadesAdmin yazısıyla değiştirilmesi
echo.
echo Lutfen bilgilerinizi olusturun ;
echo.
set /p adminname=Lutfen bir yonetici adi girin: 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'ShadesAdmin','%adminname%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
chcp 437 > NUL 2>&1
rem Parolanın sorulması ve xml dosyasındaki password_change yazısıyla değiştirilmesi
echo.
set /p new_password=Lutfen bir parola girin: 
(powershell -Command "(gc Extracted\autounattend.xml) -replace 'password_change','%new_password%' | Out-File -Encoding UTF8 Extracted\autounattend.xml") >nul 2>&1
chcp 65001 >nul
cls
echo.
echo  ==================================================================
echo  Belirttiğiniz ayarlarda autounattend.xml dosyası oluşturuldu..
echo  TPM/SecureBoot Fixi eklendi lütfen autounattend.xml ve TPM_Fix.cmd
echo  dosyalarını silmeyin-değiştirmeyin!
echo  ==================================================================
echo.
pause
goto ince_ayarlar

:make_iso
cls
echo.
set "ISODir=ISO"
echo.
set /p ISOName=ISO Dosyasının adını girin (.iso yazmadan): 
set /p ISOLabel=ISO Label değerini girin: 

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
echo ► ISO Dosyasnız ISO klasörüne kaydedildi..
pause>nul
goto menu

:wim_esd
dism /Export-Image /SourceImageFile:Extracted\sources\install.wim /SourceIndex:1 /DestinationImageFile:Extracted\sources\install.esd /Compress:LZX /CheckIntegrity
echo.
echo Wim-Esd çevirme işlemi tamamlandı! "Extracted\sources" klasörüne kaydedildi.
pause
goto wim_menu

:esd_wim
dism /Export-Image /SourceImageFile:Extracted\sources\install.esd /SourceIndex:1 /DestinationImageFile:Extracted\sources\install.wim /Compress:LZX /CheckIntegrity
echo.
echo ESD Wim çevirme işlemi tamamlandı! "Extracted\sources" klasörüne kaydedildi.
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
echo Wim dosyası LZMS olarak sıkıştırma işlemi tamamlandı!
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
echo ► Değişiklikler kaydedildi..
pause
cls
echo.
set /p choice=► ISO Olarak kayıt edilsin mi ? (y/n)
if /i "%choice%"=="y" (
   goto make_iso
) else if /i "%choice%"=="n" (
   goto menu
) else (
   echo ► Geçersiz seçim. Lütfen y veya n tuşlarından birini seçin.
)
goto menu

:end
cls
echo ► Çıkış yapıldı.
timeout /t 3
exit

:Powershell
:: Powershell komutları kullanıldığında komut istemi compact moda girmektedir. Bunu önlemek için karakter takımları arasında geçiş yapıyoruz.
chcp 437 > NUL 2>&1
Powershell -command %*
chcp 65001 > NUL 2>&1
goto :eof

:Powershell_2
:: Powershell komutları kullanıldığında komut istemi compact moda girmektedir. Bunu önlemek için karakter takımları arasında geçiş yapıyoruz.
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
echo  ┌───────┬────────┬─────────────┬────────┬─────────────┬─────────────────────────────────────────┐
echo  │ INDEX │ MİMARİ │    SÜRÜM    │  DİL   │    EDİT     │            İSİM                         │
FOR /F "tokens=3" %%a IN ('Dism /Get-WimInfo /WimFile:%~1 ^| FIND "Index"') DO (
	FOR /F "tokens=3" %%b IN ('Dism /Get-WimInfo /WimFile:%~1 /Index:%%a ^| FIND "Architecture"') DO (
		FOR /F "tokens=3" %%c in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| Find "Version"') do (
			FOR /F "tokens=3 delims=." %%d in ('"echo %%c"') do (
				FOR /F "tokens=4" %%e in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| Find "Build"') do (
					FOR /F "tokens=1" %%f in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Default') do (
						FOR /F "tokens=2 delims=':'" %%g in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Name') do (
							FOR /F "tokens=2 delims='-',':' " %%h in ('Dism /Get-WimInfo /WimFile:%~1  /Index:%%a ^| findstr /i Modified') do (
								echo  ├───────┼────────┼─────────────┼────────┼─────────────┼─────────────────────────────────────────┤
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
