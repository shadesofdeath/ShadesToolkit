# test if first argument is defined / given at command line
if ($args[0] -eq $null) {
	# can be replaced with Exit 1 to denote failure if used in batch cmd
	throw [System.IO.DirectoryNotFoundException]::new("Source directory not defined !")
}

# test if first argument is a directory and exists
if ((Test-Path -Path $args[0].ToString() -PathType Container) -eq $false) {
	throw [System.IO.DirectoryNotFoundException]::new("First argument is not a directory !")
}

# test if second argument is defined / given at command line
if ($args[1] -eq $null) {
	throw [System.IO.DirectoryNotFoundException]::new("Target directory not defined !")
}

# test if second argument is a directory and exists
if ((Test-Path -Path $args[1].ToString() -PathType Container) -eq $false) {
	throw [System.IO.DirectoryNotFoundException]::new("Second argument is not a directory !")
}

# using ToString() for arguments ensures that if supplied directory name is all numbers it won't fail (it won't think its a number but a string)
# Combine() ensures that if directory path does not have backslash \ at end it will work anyway
$sourcedir = [System.IO.Path]::Combine($args[0].ToString(),".\") + "\*"
$targetdir = [System.IO.Path]::Combine($args[1].ToString(),".\")

$input_values = Get-ChildItem -Path $sourcedir -Include *.reg

[hashtable]$equivalents = @{
	"HKLM\SOFTWARE"                                   = "HKEY_LOCAL_MACHINE\SHADES_SOFTWARE";
	"HKEY_LOCAL_MACHINE\SOFTWARE"                     = "HKEY_LOCAL_MACHINE\SHADES_SOFTWARE";
	"HKCR"                                            = "HKEY_LOCAL_MACHINE\SHADES_SOFTWARE\Classes";
	"HKEY_CLASSES_ROOT"                               = "HKEY_LOCAL_MACHINE\SHADES_SOFTWARE\Classes";
	"HKLM\SYSTEM"                                     = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM";
	"HKEY_LOCAL_MACHINE\SYSTEM"                       = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM";
	"HKLM\SYSTEM\CurrentControlSet"                   = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM\ControlSet001";
	"HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet"     = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM\ControlSet001";
	"HKLM\SYSTEM\ControlSet001"                       = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM\ControlSet001";
	"HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001"         = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM\ControlSet001";
	"HKCU"                                            = "HKEY_LOCAL_MACHINE\SHADES_HKCU";
	"HKEY_CURRENT_USER"                               = "HKEY_LOCAL_MACHINE\SHADES_HKCU";
	"HKU\.Default"                                    = "HKEY_LOCAL_MACHINE\SHADES_HKU";
	"HKEY_USERS\.Default"                             = "HKEY_LOCAL_MACHINE\SHADES_HKU";
	
	"HKLM\SHADES_SOFTWARE"                               = "HKEY_LOCAL_MACHINE\SHADES_SOFTWARE";
	"HKEY_LOCAL_MACHINE\SHADES_SOFTWARE"                 = "HKEY_LOCAL_MACHINE\SHADES_SOFTWARE";
	"HKLM\SHADES_SOFTWARE\Classes"                       = "HKEY_LOCAL_MACHINE\SHADES_SOFTWARE\Classes";
	"HKEY_LOCAL_MACHINE\SHADES_SOFTWARE\Classes"         = "HKEY_LOCAL_MACHINE\SHADES_SOFTWARE\Classes";
	"HKLM\SHADES_SYSTEM"                                 = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM";
	"HKEY_LOCAL_MACHINE\SHADES_SYSTEM"                   = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM";
	"HKLM\SHADES_SYSTEM\CurrentControlSet"               = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM\ControlSet001";
	"HKEY_LOCAL_MACHINE\SHADES_SYSTEM\CurrentControlSet" = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM\ControlSet001";
	"HKLM\SHADES_SYSTEM\ControlSet001"                   = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM\ControlSet001";
	"HKEY_LOCAL_MACHINE\SHADES_SYSTEM\ControlSet001"     = "HKEY_LOCAL_MACHINE\SHADES_SYSTEM\ControlSet001";
	"HKLM\SHADES_HKCU"                                   = "HKEY_LOCAL_MACHINE\SHADES_HKCU";
	"HKEY_LOCAL_MACHINE\SHADES_HKCU"                     = "HKEY_LOCAL_MACHINE\SHADES_HKCU";
	"HKLM\SHADES_HKU"                                    = "HKEY_LOCAL_MACHINE\SHADES_HKU";
	"HKEY_LOCAL_MACHINE\SHADES_HKU"                      = "HKEY_LOCAL_MACHINE\SHADES_HKU";
}

foreach ($file in $input_values) {
	#regex ensures that all commented lines are ignored
	[System.Collections.ArrayList]$content = Get-content -Path $file | Where { $_ -notmatch "^(\s+)?;|^\s*$" }
	[string]$output = ""
	[string]$newline = ""

	foreach($line in $content) {
		# regex ensures to catch all lines with angle brackets (they contain registry keys)
		if ($line -match "^\[.*\]$") {
			#search and replace keys to toolkit-compatible format
			foreach($key in $equivalents.Keys) {
				if ($line.Contains($key)) {
					$newline = $line.Replace($key, $equivalents[$key])
					break
				}
			}
		} else {
			$newline = $line
		}

		$output += $newline + "`r`n"
	}
	# $file is of type System.IO.FileSystemInfo so it is simple as referencing its 'Name' property to get actual file name
	Set-Content -Path ($targetdir + $file.Name) -Value $output
}
