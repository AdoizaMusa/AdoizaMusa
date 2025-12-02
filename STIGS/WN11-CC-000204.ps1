<#
.SYNOPSIS
    This PowerShell Script is Applying Remediation for Limit optional diagnostic data for Windows Analytics to be Enabled
  
  .NOTES
    Author          : Adoiza Musa
    LinkedIn        : https://www.linkedin.com/in/adoizamusa 
    GitHub          : https://github.com/AdoizaMusa
    Date Created    : 2025-12-01
    Last Modified   : 2025-12-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000204

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

.SYNOPSIS
Remediates the policy:
//"Limit optional diagnostic data for Windows Analytics" = Enabled
and sets the option "Enable Desktop Analytics collection".
#>

Write-Host "Applying remediation for Windows Analytics optional diagnostic data..." -ForegroundColor Cyan

# Registry path for the policy
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"

# Create the registry key if missing
If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Enable the policy (1 = Enabled, 0 = Disabled)
Set-ItemProperty -Path $regPath -Name "LimitEnhancedDiagnosticDataWindowsAnalytics" -Value 1 -Type DWord

# Enable Desktop Analytics collection (1 = Enabled)
Set-ItemProperty -Path $regPath -Name "AllowDesktopAnalyticsProcessing" -Value 1 -Type DWord

Write-Host "✔ Policy successfully configured:" -ForegroundColor Green
Write-Host "  - Limit optional diagnostic data for Windows Analytics = Enabled"
Write-Host "  - Desktop Analytics collection = Enabled"
