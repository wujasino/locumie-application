# VS Code Performance Optimization Script
Write-Host "Optimizing VS Code for Android Development..." -ForegroundColor Green

# Clean temporary files
$tempPaths = @(
    "$env:TEMP\*",
    "D:\radius-app\.gradle\*",
    "D:\radius-app\app\build\*"
)

foreach ($path in $tempPaths) {
    try {
        if (Test-Path (Split-Path $path)) {
            Remove-Item $path -Recurse -Force -ErrorAction SilentlyContinue
            Write-Host "Cleaned: $path" -ForegroundColor Green
        }
    } catch {
        Write-Host "Could not clean: $path" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Performance Optimization Complete!" -ForegroundColor Cyan
Write-Host "Please restart VS Code for changes to take effect." -ForegroundColor Yellow
