<#
  Author      : Cristian Schmitt Nieto
  Source      : https://learn.microsoft.com/en-us/microsoft-365/troubleshoot/updates/office-feature-updates-task-faq
#>

#description : Enable or disable the built-in "Office Feature Updates" scheduled task to prevent performance issues on multi-session hosts.
#execution mode: IndividualWithRestart
#tags: CSN, Windows Script, Golden Image, Scheduled Task, OfficeUpdates

<#variables:
{
  "Action": {
    "optionsSet": [
      { "label": "Enable Office Update Task",  "value": "Enable"  },
      { "label": "Disable Office Update Task", "value": "Disable" }
    ]
  }
}
#>

param(
  [Parameter(Mandatory)]
  [ValidateSet("Enable","Disable")]
  [string]$Action
)

$TaskName = 'Office Feature Updates'
$TaskPath = '\Microsoft\Office\'

try {
    $task = Get-ScheduledTask -TaskName $TaskName -TaskPath $TaskPath -ErrorAction Stop
}
catch {
    Write-Error "Scheduled task '$TaskPath$TaskName' not found."
    exit 1
}

if ($Action -eq 'Enable') {
    Write-Host "Enabling Office Feature Updates task..."
    Enable-ScheduledTask -InputObject $task
    Write-Host "Task enabled."
}
else {
    Write-Host "Disabling Office Feature Updates task..."
    Disable-ScheduledTask -InputObject $task
    Write-Host "Task disabled."
}
