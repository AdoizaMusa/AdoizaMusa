<#
.SYNOPSIS
    This PowerShell script ensures Disabling The Windows Remote Management (WinRM) service must not use Basic authentication.

.NOTES
    Author          : Adoiza Musa
    LinkedIn        : https://www.linkedin.com/in/adoizamusa
    GitHub          : https://github.com/AdoizaMusa
    Date Created    : 2025-11-01
    Last Modified   : 2025-1-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000345

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

STIG ID: WN11-CC-000345
Title: Disable Basic authentication for WinRM
Description: The Windows Remote Management (WinRM) service must not use Basic authentication.
#>

Write-Host "Applying STIG: WN11-CC-000345 - Disabling WinRM Basic Authentication..." -ForegroundColor Cyan

# Ensure WinRM service exists
if (Get-Service -Name "WinRM" -ErrorAction SilentlyContinue) {

    # Disable Basic authentication for both WinRM client and service
    Write-Host "Disabling Basic authentication for WinRM Client..." -ForegroundColor Yellow
    winrm set winrm/config/client/auth '@{Basic="false"}' | Out-Null

    Write-Host "Disabling Basic authentication for WinRM Service..." -ForegroundColor Yellow
    winrm set winrm/config/service/auth '@{Basic="false"}' | Out-Null

    # Verify configuration
    Write-Host "`nVerifying current WinRM authentication settings..." -ForegroundColor Cyan
    $clientAuth = winrm get winrm/config/client/auth
    $serviceAuth = winrm get winrm/config/service/auth

    Write-Host "`nClient Authentication Settings:`n$clientAuth" -ForegroundColor Green
    Write-Host "`nService Authentication Settings:`n$serviceAuth" -ForegroundColor Green

    Write-Host "`n✅ WinRM Basic Authentication has been disabled successfully." -ForegroundColor Green
}
else {
    Write-Host "❌ WinRM service not found on this system." -ForegroundColor Red
}
