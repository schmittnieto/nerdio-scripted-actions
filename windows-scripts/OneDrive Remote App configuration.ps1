<#
  Author: Markus Steigner & Cristian Schmitt Nieto
  Source: https://learn.microsoft.com/azure/virtual-desktop/onedrive-remoteapp
#>

#description: Toggle background launch of Microsoft OneDrive for Azure Virtual Desktop RemoteApp sessions
#execution mode: Individual
#tags: Nerdio, Microsoft, Apps install
<#variables:
{
  "OneDriveBackgroundLaunch": {
    "Description": "Enable or disable launching OneDrive silently in the background for RemoteApp sessions.",
    "DisplayName": "OneDrive background launch",
    "IsRequired": true,
    "OptionsSet": [
      { "Label": "Enable",  "Value": "Enable" },
      { "Label": "Disable", "Value": "Disable" }
    ]
  }
}
#>

[CmdletBinding()]
Param(
  [Parameter(Mandatory)]
  [ValidateSet("Enable","Disable")]
  [string]$OneDriveBackgroundLaunch
)

$registryPathTS  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$registryPathRun = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"

# Ensure parent path exists for Terminal Services
if (-not (Test-Path $registryPathTS)) {
  New-Item -Path $registryPathTS -Force | Out-Null
}

switch ($OneDriveBackgroundLaunch) {

  'Enable' {
    Write‑Host "Enabling OneDrive background launch for RemoteApp sessions …"

    # 1. Enhanced shell experience for RemoteApp
    New-ItemProperty -Path $registryPathTS `
                     -Name "UseShellAppRuntimeRemoteApp" `
                     -PropertyType DWORD `
                     -Value 1 `
                     -Force

    # 2. Launch OneDrive.exe in the background at logon
    New-ItemProperty -Path $registryPathRun `
                     -Name "OneDrive" `
                     -PropertyType String `
                     -Value '"C:\Program Files\Microsoft OneDrive\OneDrive.exe" /background' `
                     -Force
  }

  'Disable' {
    Write‑Host "Disabling OneDrive background launch for RemoteApp sessions …"

    # Remove the RemoteApp shell‑experience key (if present)
    if (Test-Path "$registryPathTS\UseShellAppRuntimeRemoteApp") {
      Remove-ItemProperty -Path $registryPathTS -Name "UseShellAppRuntimeRemoteApp" -ErrorAction SilentlyContinue
    }

    # Remove the Run‑key entry for OneDrive (if present)
    if (Test-Path "$registryPathRun\OneDrive") {
      Remove-ItemProperty -Path $registryPathRun -Name "OneDrive" -ErrorAction SilentlyContinue
    }
  }
}

Write‑Host "Completed OneDrive background‑launch configuration: $OneDriveBackgroundLaunch"
