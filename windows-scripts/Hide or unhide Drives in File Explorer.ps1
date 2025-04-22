<#
  Author      : Cristian Schmitt Nieto
  Description : Hide or unhide drives in File Explorer by managing the NoDrives policy.
  Execution   : Individual with restart
  Tags        : CSN, Microsoft, Golden Image, Explorer
#>

<# Variables:
{
  "Action": {
    "Description": "Choose whether to hide specific drives or remove the hide setting entirely.",
    "IsRequired": true,
    "OptionsSet": [
      { "Label": "Hide specified drives",     "Value": "Hide"   },
      { "Label": "Remove drive hiding entry", "Value": "Remove" }
    ]
  },
  "DrivesToHide": {
    "Description": "Comma‑separated list of drive letters to hide (e.g. C,E,F). Only used when Action is Hide.",
    "IsRequired": false,
    "DefaultValue": ""
  }
}
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory)]
  [ValidateSet("Hide","Remove")]
  [string]$Action,

  [Parameter()]
  [string]$DrivesToHide
)

$regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
if (-not (Test-Path $regPath)) {
  New-Item -Path $regPath -Force | Out-Null
}

if ($Action -eq 'Remove') {
  if (Get-ItemProperty -Path $regPath -Name 'NoDrives' -ErrorAction SilentlyContinue) {
    Remove-ItemProperty -Path $regPath -Name 'NoDrives' -ErrorAction Stop
    Write-Host "Removed NoDrives entry; all drives will be visible."
  }
  else {
    Write-Host "NoDrives entry not found; nothing to remove."
  }
  return
}

# Action is Hide
# Map drive letters to bitmask values
$driveMap = @{
  'A'=1;       'B'=2;        'C'=4;        'D'=8;
  'E'=16;      'F'=32;       'G'=64;       'H'=128;
  'I'=256;     'J'=512;      'K'=1024;     'L'=2048;
  'M'=4096;    'N'=8192;     'O'=16384;    'P'=32768;
  'Q'=65536;   'R'=131072;   'S'=262144;   'T'=524288;
  'U'=1048576; 'V'=2097152;  'W'=4194304;  'X'=8388608;
  'Y'=16777216;'Z'=33554432
}

if ([string]::IsNullOrWhiteSpace($DrivesToHide)) {
  throw "DrivesToHide must be specified when Action is 'Hide'."
}

# Parse and validate letters
$letters = $DrivesToHide.Split(',') | ForEach-Object { $_.Trim().ToUpper() }
$mask = 0
foreach ($letter in $letters) {
  if ($driveMap.ContainsKey($letter)) {
    $mask += $driveMap[$letter]
  }
  else {
    throw "Invalid drive letter: '$letter'"
  }
}

# Apply NoDrives mask
Set-ItemProperty -Path $regPath `
                 -Name 'NoDrives' `
                 -PropertyType DWord `
                 -Value $mask `
                 -Force

Write-Host "NoDrives set to $mask; hidden drives: $($letters -join ', ')."
Write-Host "Please restart Explorer or reboot for changes to take effect."
