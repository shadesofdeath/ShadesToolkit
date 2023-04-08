reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassTPMCheck" /t REG_DWORD /d 1
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassRAMCheck" /t REG_DWORD /d 1
reg add "HKLM\SYSTEM\Setup\LabConfig" /v "BypassSecureBootCheck" /t REG_DWORD /d 1
echo reg patch ran OK > X:\TPMFIX.TXT
exit