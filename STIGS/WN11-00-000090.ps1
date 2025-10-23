<#
.SYNOPSIS
    This PowerShell script ensures that Accounts must be configured to require password expiration

.NOTES
    Author          : Adoiza Musa
    LinkedIn        : https://www.linkedin.com/in/adoizamusa
    GitHub          : https://github.com/AdoizaMusa/AdoizaMusa
    Date Created    : 2025-10-23
    Last Modified   : 2025-10-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-00-000090

.TESTED ON
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# YOUR CODE GOES HERE# Run as Administrator

# Get all local users (enabled accounts) and set PasswordNeverExpires = $false
Get-LocalUser |
    Where-Object { $_.Enabled -eq $true } |
    ForEach-Object {
        try {
            Write-Verbose "Processing user: $($_.Name)"
            Set-LocalUser -Name $_.Name -PasswordNeverExpires $false -WhatIf:$false
            Write-Host "Set PasswordNeverExpires = false for user $($_.Name)"
        }
        catch {
            Write-Warn "Failed for user $($_.Name): $_"
        }
    }
