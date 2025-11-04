<#
.SYNOPSIS
    This PowerShell script is to Enable Turn off printing over HTTP

.NOTES
    Author          : Adoiza Musa
    LinkedIn        : https://www.linkedin.com/in/adoizamusa
    GitHub          : https://github.com/AdoizaMusa
    Date Created    : 2025-11-04
    Last Modified   : 2025-11-04
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000110

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN11-CC-000110).ps1 
#>
# Run this script as Administrator

$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers'
$valueName = 'DisableHTTPPrinting'
$desiredValue = 1

try {
    # Ensure key exists
    if (-not (Test-Path -Path $regPath)) {
        New-Item -Path $regPath -Force | Out-Null
        Write-Host "Created registry key: $regPath"
    } else {
        Write-Host "Registry key exists: $regPath"
    }

    # Set the DWORD value to 1 (Enabled -> turn off printing over HTTP)
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
    Write-Host "Set $valueName = $desiredValue at $regPath"

    # Trigger a group policy update (best-effort)
    Write-Host "Running gpupdate /force..."
    gpupdate /force | Out-Null

    # Optional: restart Print Spooler to ensure services pick up config (uncomment if desired)
    # Write-Host "Restarting Print Spooler service..."
    # Restart-Service -Name Spooler -Force -ErrorAction SilentlyContinue

    # Verification
    $regRead = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction Stop
    Write-Host "Verification: $valueName = $($regRead.$valueName)"

    if ($regRead.$valueName -eq $desiredValue) {
        Write-Host "SUCCESS: 'Turn off printing over HTTP' is configured (DisableHTTPPrinting = $desiredValue)."
        exit 0
    } else {
        Write-Warning "VALUE MISMATCH: Expected $desiredValue but found $($regRead.$valueName)."
        exit 2
    }
}
catch {
    Write-Error "ERROR: $($_.Exception.Message)"
    exit 1
}
