# 🚀 VS Code Performance Optimization Script
# Run this script as Administrator to optimize VS Code performance

Write-Host "🚀 Optimizing VS Code for Android Development..." -ForegroundColor Green

# 1. Disable Windows Defender real-time scanning for project folder
try {
    $projectPath = "D:\radius-app"
    Add-MpPreference -ExclusionPath $projectPath
    Write-Host "✅ Added Windows Defender exclusion for: $projectPath" -ForegroundColor Green
} catch {
    Write-Host "⚠️ Could not add Windows Defender exclusion (run as Administrator)" -ForegroundColor Yellow
}

# 2. Set high performance power plan
try {
    powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    Write-Host "✅ Set High Performance power plan" -ForegroundColor Green
} catch {
    Write-Host "⚠️ Could not set power plan" -ForegroundColor Yellow
}

# 3. Increase VS Code memory limit
$vsCodeUserData = "$env:APPDATA\Code\User"
if (Test-Path $vsCodeUserData) {
    $settingsPath = "$vsCodeUserData\settings.json"
    Write-Host "✅ VS Code user settings location: $settingsPath" -ForegroundColor Green
} else {
    Write-Host "⚠️ VS Code user data not found" -ForegroundColor Yellow
}

# 4. Clean temporary files
$tempPaths = @(
    "$env:TEMP\*",
    "$env:LOCALAPPDATA\Temp\*",
    "D:\radius-app\.gradle\*",
    "D:\radius-app\app\build\*"
)

foreach ($path in $tempPaths) {
    try {
        if (Test-Path (Split-Path $path)) {
            Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "✅ Cleaned: $path" -ForegroundColor Green
        }
    } catch {
        Write-Host "⚠️ Could not clean: $path" -ForegroundColor Yellow
    }
}

# 5. Disable Windows visual effects for performance
try {
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2
    Write-Host "✅ Disabled Windows visual effects" -ForegroundColor Green
} catch {
    Write-Host "⚠️ Could not modify visual effects settings" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎯 Performance Optimization Complete!" -ForegroundColor Cyan
Write-Host ""
Write-Host "📋 Manual steps to complete:" -ForegroundColor Yellow
Write-Host "1. Restart VS Code"
Write-Host "2. Install only essential extensions (see .vscode/extensions.json)"
Write-Host "3. Close unnecessary applications"
Write-Host "4. Consider using VS Code Insiders for better performance"
Write-Host ""
Write-Host "⚡ Expected improvements:" -ForegroundColor Green
Write-Host "- Faster file indexing"
Write-Host "- Reduced memory usage"
Write-Host "- Faster build times"
Write-Host "- Smoother UI experience"
