<#
.SYNOPSIS
    This PowerShell script Applied Remediation to Enable PowerShell Script Block Logging

.NOTES
    Author          : Adoiza Musa
    LinkedIn        : https://www.linkedin.com/in/adoizamusa
    GitHub          : https://github.com/AdoizaMusa
    Date Created    : 2025-12-01
    Last Modified   : 2025-12-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000326
.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000326).ps1 
#>

Write-Host "Applying remediation: Enable PowerShell Script Block Logging..."

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"

if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

Set-ItemProperty -Path $regPath -Name "EnableScriptBlockLogging" -Value 1 -Type DWord

Write-Host "Remediation complete: PowerShell Script Block Logging is now ENABLED."
