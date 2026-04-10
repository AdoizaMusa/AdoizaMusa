<#
.SYNOPSIS
    This PowerShell script ensures the use of a hardware security device with Windows Hello for Business to be enabled

.NOTES
    Author          : Adoiza Musa
    LinkedIn        : https://www.linkedin.com/in/adoizamusa
    GitHub          : https://github.com/AdoizaMusa/AdoizaMusa
    Date Created    : 2026-04-09
    Last Modified   : 2026-04-09
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000255
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-CC-000255/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000255).ps1 
#>

# New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork" -Force

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork" `
-Name "Enabled" -Value 1 -Type DWord

Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\PassportForWork" `
-Name "RequireSecurityDevice" -Value 1 -Type DWord
