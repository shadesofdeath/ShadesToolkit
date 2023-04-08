Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$components = @("AdobeFlashForWindows","EdgeChromium","InternetExplorer","FirstLogonAnimation","GameExplorer","LockScreenBackground","ScreenSavers","SnippingTool","SoundThemes","SpeechRecognition","Wallpapers","WindowsMediaPlayer","WindowsPhotoViewer","WindowsThemes","WindowsTIFFIFilter","WinSAT","OfflineFiles","OpenSSH","RemoteDesktopClient","RemoteDifferentialCompression","SimpleTCPIPServices","TelnetClient","TFTPClient","WalletService","WindowsMail","AssignedAccess","CEIP","FaceRecognition","KernelDebugging","LocationService","PicturePassword","PinEnrollment","UnifiedTelemetryClient","WiFiNetworkManager","WindowsErrorReporting","WindowsInsiderHub","HomeGroup","MultiPointConnector","OneDrive","RemoteAssistance","RemoteDesktopServer","RemoteRegistry","WorkFoldersClient","AccessibilityTools","DeviceLockdown","EaseOfAccessCursors","EaseOfAccessThemes","EasyTransfer","FileHistory","Magnifier","ManualSetup","Narrator","Notepad","OnScreenKeyboard","Paint","ProjFS","SecurityCenter","StepsRecorder","StorageSpaces","SystemRestore","WindowsBackup","WindowsFirewall","WindowsSubsystemForLinux","WindowsToGo","WindowsUpdate","Wordpad","AADBrokerPlugin","AccountsControl","AddSuggestedFoldersToLibraryDialog","AppResolverUX","AssignedAccessLockApp","AsyncTextService","BioEnrollment","CallingShellApp","CapturePicker","CBSPreview","ContentDeliveryManager","CredDialogHost","ECApp","Edge","EdgeDevToolsClient","FileExplorer","FilePicker","LockApp","MapControl","NarratorQuickStart","NcsiUwpApp","OOBENetworkCaptivePortal","OOBENetworkConnectionFlow","ParentalControls","PeopleExperienceHost","PinningConfirmationDialog","PrintDialog","QuickAssist","RetailDemoContent","SearchApp","SecureAssessmentBrowser","SettingSync","SkypeORTC","SmartScreen","WebcamExperience","WebView2SDK","Win32WebViewHost","WindowsDefender","WindowsMixedReality","WindowsReaderPDF","WindowsStoreClient","XboxClient","XboxGameCallableUI","XGpuEjectDialog","3DViewer","AdvertisingXaml""Alarms","BingWeather","CalculatorApp","Camera","CommunicationsApps","Cortana","DesktopAppInstaller","FeedbackHub","GetHelp","Getstarted","HEIFImageExtension","Maps","MixedRealityPortal","OfficeHub","OfficeOneNote","Paint3D","People","Photos","ServicesStoreEngagement","ScreenSketch","SkypeApp","SolitaireCollection","SoundRecorder","StickyNotes","StorePurchaseApp","VP9VideoExtensions","Wallet","WebMediaExtensions","WebpImageExtension","WindowsStoreApp","XboxApp","XboxGameOverlay","XboxGamingOverlay","XboxIdentityProvider","XboxSpeechToTextOverlay","XboxTCUI","YourPhone","ZuneMusic","ZuneVideo","PPIProjection","Messaging","OneConnect","Print3D","Calculator","EdgeWebView","BingNews","ClientWebExperience","Clipchamp","Family","GamingApp","HEVCVideoExtension","NotepadApp","PowerAutomateDesktop","RawImageExtension","Terminal","Todos")

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
$button.Text = "Remove"

$button.Add_Click({
    $checkedItems = $checkedListBox.CheckedItems
    $count = $checkedItems.Count
    $progress = 0
    foreach ($component in $checkedItems) {
        $progress++
        Write-Host "Removing: $component ($progress / $count)"
        & Bin\ToolkitHelper.exe Mount\Install $component
    }
    [System.Windows.Forms.MessageBox]::Show("$count Component has been removed.", "Uninstallation Completed", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)
})

$form.Controls.Add($button)

$form.ShowDialog()
