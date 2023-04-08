Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$components = @("EdgeChromium", "EdgeWebView", "InternetExplorer", "FirstLogonAnimation", "GameExplorer", "LockScreenBackground", "ScreenSavers", "SoundThemes", "SpeechRecognition", "Wallpapers", "WindowsMediaPlayer", "WindowsPhotoViewer", "WindowsThemes", "WindowsTIFFIFilter", "WinSAT", "OfflineFiles", "OpenSSH", "RemoteDesktopClient", "RemoteDifferentialCompression", "SimpleTCPIPServices", "TelnetClient", "TFTPClient", "WalletService", "WindowsMail", "AssignedAccess", "CEIP", "FaceRecognition", "KernelDebugging", "LocationService", "PicturePassword", "PinEnrollment", "UnifiedTelemetryClient", "WiFiNetworkManager", "WindowsErrorReporting", "WindowsInsiderHub", "MultiPointConnector", "OneDrive", "RemoteAssistance", "RemoteDesktopServer", "RemoteRegistry", "WorkFoldersClient", "AccessibilityTools", "DeviceLockdown", "EaseOfAccessCursors", "EaseOfAccessThemes", "EasyTransfer", "FileHistory", "Magnifier", "ManualSetup", "Narrator", "Notepad", "OnScreenKeyboard", "ProjFS", "SecurityCenter", "StepsRecorder", "StorageSpaces", "SystemRestore", "WindowsBackup", "WindowsFirewall", "WindowsSubsystemForLinux", "WindowsToGo", "WindowsUpdate", "Wordpad", "AADBrokerPlugin", "AccountsControl", "AddSuggestedFoldersToLibraryDialog", "AppResolverUX", "AssignedAccessLockApp", "AsyncTextService", "BioEnrollment", "CallingShellApp", "CapturePicker", "CBSPreview", "ContentDeliveryManager", "CredDialogHost", "ECApp", "Edge", "EdgeDevToolsClient", "FileExplorer", "FilePicker", "LockApp", "MapControl", "NarratorQuickStart", "NcsiUwpApp", "OOBENetworkCaptivePortal", "OOBENetworkConnectionFlow", "ParentalControls", "PeopleExperienceHost", "PinningConfirmationDialog", "PrintDialog", "QuickAssist", "RetailDemoContent", "SearchApp", "SecureAssessmentBrowser", "SettingSync", "SkypeORTC", "SmartScreen", "WebcamExperience", "WebView2SDK", "Win32WebViewHost", "WindowsDefender", "WindowsMixedReality", "WindowsReaderPDF", "WindowsStoreClient", "XboxClient", "XboxGameCallableUI", "XGpuEjectDialog", "Alarms", "BingNews", "BingWeather", "CalculatorApp", "Camera", "ClientWebExperience", "CommunicationsApps", "Cortana", "DesktopAppInstaller", "FeedbackHub", "GamingApp", "GetHelp", "Getstarted", "HEIFImageExtension", "Maps", "NotepadApp", "OfficeHub", "Paint", "People", "Photos", "PowerAutomateDesktop", "ScreenSketch", "SolitaireCollection", "SoundRecorder", "StickyNotes", "StorePurchaseApp", "Terminal", "Todos", "VP9VideoExtensions", "WebMediaExtensions", "WebpImageExtension", "WindowsStoreApp", "XboxGameOverlay", "XboxGamingOverlay", "XboxIdentityProvider", "XboxSpeechToTextOverlay", "XboxTCUI", "YourPhone", "ZuneMusic", "ZuneVideo")


$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(260,500)
$form.StartPosition = "CenterScreen"

$checkedListBox = New-Object System.Windows.Forms.CheckedListBox
$checkedListBox.Location = New-Object System.Drawing.Point(10,10)
$checkedListBox.Size = New-Object System.Drawing.Size(220,400)
$checkedListBox.CheckOnClick = $true

foreach ($component in $components) {
    $checkedListBox.Items.Add($component)
}

$form.Controls.Add($checkedListBox)

$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(10,420)
$button.Size = New-Object System.Drawing.Size(220,30)
$button.Text = "Kaldir"

$button.Add_Click({
    $checkedItems = $checkedListBox.CheckedItems
    $count = $checkedItems.Count
    $progress = 0
    foreach ($component in $checkedItems) {
        $progress++
        Write-Host "Kaldiriliyor: $component ($progress / $count)"
        & Bin\ToolkitHelper.exe Mount\Install $component
    }
    [System.Windows.Forms.MessageBox]::Show("$count bileşen kaldırıldı.", "Kaldırma Tamamlandı", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$form.Controls.Add($button)

$form.ShowDialog()
