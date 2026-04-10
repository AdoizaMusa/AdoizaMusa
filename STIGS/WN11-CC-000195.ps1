<#
.SYNOPSIS
    This PowerShell script Enhanced anti-spoofing for facial recognition and was configured to be enabled on Windows 11

.NOTES
    Author          : Adoiza Musa
    LinkedIn        : https://www.linkedin.com/in/adoizamusa
    GitHub          : https://github.com/AdoizaMusa/AdoizaMusa
    Date Created    : 2026-04-09
    Last Modified   : 2026-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000195
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000195/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000195).ps1 
#>

"PowerShell for 000195"
# Define the registry path for Biometric Facial Features
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics\FacialFeatures"

# Create the path if it doesn't exist
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the EnhancedAntiSpoofing value to 1 (Enabled)
Set-ItemProperty -Path $registryPath -Name "EnhancedAntiSpoofing" -Value 1 -Type DWord

Write-Host "WN11-CC-000195: Enhanced anti-spoofing for facial recognition has been enabled." -ForegroundColor Green
