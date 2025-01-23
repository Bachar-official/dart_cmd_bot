$BOT_TOKEN = Read-Host "Please enter your Telegram bot token:"

$LATEST_RELEASE_URL = (Invoke-RestMethod -Uri "https://api.github.com/repos/Bachar-official/dart_cmd_bot/releases/latest").assets | Where-Object { $_.name -eq "dart_cmd_bot_windows.exe" } | Select-Object -ExpandProperty browser_download_url
Invoke-WebRequest -Uri $LATEST_RELEASE_URL -OutFile "dart_cmd_bot_windows.exe"

[System.Environment]::SetEnvironmentVariable("BOT_TOKEN", $BOT_TOKEN, [System.EnvironmentVariableTarget]::Machine)

$serviceName = "CmdBot"
$serviceDisplayName = "Cmd Bot Service"
$serviceDescription = "Cmd Telegram Bot Service"
$executablePath = "$PWD\dart_cmd_bot_windows.exe"

New-Service -Name $serviceName `
            -DisplayName $serviceDisplayName `
            -Description $serviceDescription `
            -BinaryPathName $executablePath `
            -StartupType Automatic

Start-Service -Name $serviceName

Write-Host "Installation complete. Please launch /start command in your Telegram bot."