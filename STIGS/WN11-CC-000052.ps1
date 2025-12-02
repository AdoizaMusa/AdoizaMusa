<#
.SYNOPSIS
    This PowerShell script Remediate's to ensures prioritized ECC Curves with longer key lengths first

.NOTES
    Author          : Adoiza Musa
    LinkedIn        : https://www.linkedin.com/in/adoizamusa
    GitHub          : https://github.com/AdoizaMusa
    Date Created    : 2025-12-01
    Last Modified   : 2025-12-01
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000052

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000052).ps1 
#>
Write-Host "Applying remediation: Configure ECC Curve Order..." -ForegroundColor Cyan

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"

# Create the registry path if missing
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set ECC Curve Order (REG_MULTI_SZ)
$curves = @(
    "NistP384",
    "NistP256"
)

New-ItemProperty -Path $regPath -Name "EccCurves" -Value $curves -PropertyType MultiString -Force | Out-Null

Write-Host "Remediation complete:" -ForegroundColor Green
Write-Host "ECC Curve Order is ENABLED with the following order:"
Write-Host "1. NistP384"
Write-Host "2. NistP256"
