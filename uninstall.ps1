$serviceName = "CmdBot"
if (Get-Service -Name $serviceName -ErrorAction SilentlyContinue) {
    Write-Host "Stopping service $serviceName..."
    Stop-Service -Name $serviceName -Force
    Write-Host "Removing service $serviceName..."
    Remove-Service -Name $serviceName
}

$homeDir = [System.Environment]::GetFolderPath('UserProfile')
$exePath = Join-Path -Path $homeDir -ChildPath "dart_cmd_bot_windows.exe"
$configPath = Join-Path -Path $homeDir -ChildPath "config.json"

if (Test-Path -Path $exePath) {
    Write-Host "Removing binary file..."
    Remove-Item -Path $exePath -Force
} else {
    Write-Host "Binary $exePath not found."
}

if (Test-Path -Path $configPath) {
    Write-Host "Removing configuration file..."
    Remove-Item -Path $configPath -Force
} else {
    Write-Host "Configuration file $configPath not found."
}

if ([System.Environment]::GetEnvironmentVariable("BOT_TOKEN", [System.EnvironmentVariableTarget]::Machine)) {
    Write-Host "Removing environment variable BOT_TOKEN..."
    [System.Environment]::SetEnvironmentVariable("BOT_TOKEN", $null, [System.EnvironmentVariableTarget]::Machine)
}

Write-Host "Uninstalling complete."
