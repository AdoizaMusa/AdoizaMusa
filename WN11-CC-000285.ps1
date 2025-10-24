<#
.SYNOPSIS
    This PowerShell script Ensures that Remote Desktop Session Host requires secure RPC communications.

.NOTES
    Author          : Adoiza Musa
    LinkedIn        : https://www.linkedin.com/in/adoizamusa
    GitHub          : https://github.com/AdoizaMusa
    Date Created    : 2025-10-24
    Last Modified   : 2025-10-24
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000285

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
  Ensures that Remote Desktop Session Host requires secure RPC communication (STIG WN11-CC-000285).

.DESCRIPTION
  This script sets the registry value under:
    HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\fEncryptRPCTraffic
  to 1 (enabled). If necessary, it will create the key path.

  Optionally, you may want to trigger a GPO refresh or restart services (if required).

.NOTES
  - Must be run with elevated (Administrator / SYSTEM) privileges.
  - It writes to the Policies branch, so it aligns with policy-managed settings.
#>

# Define registry path and name
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$regName = "fEncryptRPCTraffic"
$desiredValue = 1

try {
    # Create the key path if it doesn't exist
    if (-not (Test-Path -Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
    }

    # Retrieve current value (if exists)
    $current = Get-ItemProperty -Path $regPath -Name $regName -ErrorAction SilentlyContinue

    if ($null -eq $current) {
        # Value does not exist — create it
        New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $desiredValue -Force | Out-Null
        Write-Verbose "Created registry value: $regPath\$regName = $desiredValue"
    }
    elseif ($current.$regName -ne $desiredValue) {
        # Exists but not correct — update it
        Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Force
        Write-Verbose "Updated registry value: $regPath\$regName from $($current.$regName) to $desiredValue"
    }
    else {
        Write-Verbose "Registry value already configured correctly: $regPath\$regName = $desiredValue"
    }

    # Optionally, you can force a GPO refresh so that the policy engine acknowledges the change:
    # gpupdate /force (uncomment if appropriate)

    # Or, if you want to restart Remote Desktop services (be cautious) — e.g.:
    # Restart-Service -Name TermService -Force

    Write-Output "Remediation of WN11-CC-000285 applied successfully."
}
catch {
    Write-Error "Error applying remediation: $_"
    exit 1
}
