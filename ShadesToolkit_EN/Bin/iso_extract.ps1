Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

$Window = New-Object System.Windows.Window
$Window.Title = "ShadesToolkit - ISO Extractor"
$Window.Width = 500
$Window.Height = 200

$StackPanel = New-Object System.Windows.Controls.StackPanel

$Label = New-Object System.Windows.Controls.Label
$Label.Content = "No ISO selected"
$Label.Margin = "10"
$StackPanel.Children.Add($Label)

$Button = New-Object System.Windows.Controls.Button
$Button.Content = "Select ISO"
$Button.Margin = "10"
$Button.add_Click({
    $OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.Filter = "ISO files (*.iso)|*.iso"
    If ($OpenFileDialog.ShowDialog() -eq "OK") {
        $Label.Content = $OpenFileDialog.FileName
    }
})
$StackPanel.Children.Add($Button)

$ExtractButton = New-Object System.Windows.Controls.Button
$ExtractButton.Content = "Extract ISO"
$ExtractButton.Margin = "10"
$ExtractButton.add_Click({
    If ($Label.Content -ne "No ISO selected") {
        $7ZipPath = "Bin/7z.exe"
        $OutputPath = Join-Path $scriptPath "../Extracted"
        If (!(Test-Path $OutputPath)) {
            New-Item -ItemType Directory -Path $OutputPath | Out-Null
        }
        Start-Process $7ZipPath -ArgumentList "x `"$($Label.Content)`" -o`"$OutputPath`"" -Wait
        [System.Windows.MessageBox]::Show("ISO Extraction completed")
    }
})
$StackPanel.Children.Add($ExtractButton)

$Window.Content = $StackPanel
$Window.ShowDialog() 
