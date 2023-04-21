Add-Type -AssemblyName PresentationFramework

$components = @("EdgeChromium", "EdgeWebView", "InternetExplorer", "FirstLogonAnimation", "GameExplorer", "LockScreenBackground", "ScreenSavers", "SoundThemes", "SpeechRecognition", "Wallpapers", "WindowsMediaPlayer", "WindowsPhotoViewer", "WindowsThemes", "WindowsTIFFIFilter", "WinSAT", "OfflineFiles", "OpenSSH", "RemoteDesktopClient", "RemoteDifferentialCompression", "SimpleTCPIPServices", "TelnetClient", "TFTPClient", "WalletService", "WindowsMail", "AssignedAccess", "CEIP", "FaceRecognition", "KernelDebugging", "LocationService", "PicturePassword", "PinEnrollment", "UnifiedTelemetryClient", "WiFiNetworkManager", "WindowsErrorReporting", "WindowsInsiderHub", "MultiPointConnector", "OneDrive", "RemoteAssistance", "RemoteDesktopServer", "RemoteRegistry", "WorkFoldersClient", "AccessibilityTools", "DeviceLockdown", "EaseOfAccessCursors", "EaseOfAccessThemes", "EasyTransfer", "FileHistory", "Magnifier", "ManualSetup", "Narrator", "Notepad", "OnScreenKeyboard", "ProjFS", "SecurityCenter", "StepsRecorder", "StorageSpaces", "SystemRestore", "WindowsBackup", "WindowsFirewall", "WindowsSubsystemForLinux", "WindowsToGo", "WindowsUpdate", "Wordpad", "AADBrokerPlugin", "AccountsControl", "AddSuggestedFoldersToLibraryDialog", "AppResolverUX", "AssignedAccessLockApp", "AsyncTextService", "BioEnrollment", "CallingShellApp", "CapturePicker", "CBSPreview", "ContentDeliveryManager", "CredDialogHost", "ECApp", "Edge", "EdgeDevToolsClient", "FileExplorer", "FilePicker", "LockApp", "MapControl", "NarratorQuickStart", "NcsiUwpApp", "OOBENetworkCaptivePortal", "OOBENetworkConnectionFlow", "ParentalControls", "PeopleExperienceHost", "PinningConfirmationDialog", "PrintDialog", "QuickAssist", "RetailDemoContent", "SearchApp", "SecureAssessmentBrowser", "SettingSync", "SkypeORTC", "SmartScreen", "WebcamExperience", "WebView2SDK", "Win32WebViewHost", "WindowsDefender", "WindowsMixedReality", "WindowsReaderPDF", "WindowsStoreClient", "XboxClient", "XboxGameCallableUI", "XGpuEjectDialog", "Alarms", "BingNews", "BingWeather", "CalculatorApp", "Camera", "ClientWebExperience", "CommunicationsApps", "Cortana", "DesktopAppInstaller", "FeedbackHub", "GamingApp", "GetHelp", "Getstarted", "HEIFImageExtension", "Maps", "NotepadApp", "OfficeHub", "Paint", "People", "Photos", "PowerAutomateDesktop", "ScreenSketch", "SolitaireCollection", "SoundRecorder", "StickyNotes", "StorePurchaseApp", "Terminal", "Todos", "VP9VideoExtensions", "WebMediaExtensions", "WebpImageExtension", "WindowsStoreApp", "XboxGameOverlay", "XboxGamingOverlay", "XboxIdentityProvider", "XboxSpeechToTextOverlay", "XboxTCUI", "YourPhone", "ZuneMusic", "ZuneVideo")

$window = New-Object System.Windows.Window
$window.Title = "ShadesToolkit - Component Remover"
$window.Width = 380
$window.Height = 550
$window.ResizeMode = "NoResize"
$window.WindowStartupLocation = "CenterScreen"
$window.WindowStyle = "SingleBorderWindow"

$grid = New-Object System.Windows.Controls.Grid
$window.Content = $grid

$scrollViewer = New-Object System.Windows.Controls.ScrollViewer
$scrollViewer.VerticalScrollBarVisibility = "Auto"
$grid.Children.Add($scrollViewer)

$stackPanel = New-Object System.Windows.Controls.StackPanel
$scrollViewer.Content = $stackPanel

$label = New-Object System.Windows.Controls.Label
$label.Content = "Kaldirilacak Bilesenleri Secin:"
$label.Margin = "5,10,0,10"
$stackPanel.Children.Add($label)

$checkBoxList = New-Object System.Windows.Controls.ListBox
$checkBoxList.SelectionMode = "Multiple"
$checkBoxList.Margin = "5,0,5,10"
$checkBoxList.ItemsSource = $components
$checkBoxList.Height = 410
$stackPanel.Children.Add($checkBoxList)

$button = New-Object System.Windows.Controls.Button
$button.Content = "Kaldir"
$button.Margin = "10,0,10,10"
$button.Width = 80
$button.Height = 30
$button.Add_Click({
    $checkedItems = $checkBoxList.SelectedItems
    $count = $checkedItems.Count
    $progress = 0
    foreach ($component in $checkedItems) {
        $progress++
        Write-Host "Kaldiriliyor: $component ($progress / $count)"
        & Bin\ToolkitHelper.exe Mount\Install $component
    }
    [System.Windows.MessageBox]::Show("$count bileşen kaldırıldı.", "Kaldırma Tamamlandı", [System.Windows.MessageBoxButton]::OK, [System.Windows.MessageBoxImage]::Information)
})
$stackPanel.Children.Add($button)

$window.ShowDialog() | Out-Null