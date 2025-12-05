# Auto Build and Install Script
# Ten skrypt automatycznie buduje i instaluje aplikację na telefonie

param(
    [switch]$Clean,
    [switch]$Watch
)

function Build-And-Install {
    Write-Host "🔨 Budowanie aplikacji..." -ForegroundColor Yellow

    if ($Clean) {
        Write-Host "🧹 Czyszczenie cache..." -ForegroundColor Blue
        & ./gradlew clean assembleDebug
    } else {
        & ./gradlew assembleDebug
    }

    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Budowanie zakończone pomyślnie!" -ForegroundColor Green

        Write-Host "📱 Instalowanie na telefonie..." -ForegroundColor Yellow
        & adb install -r app/build/outputs/apk/debug/app-debug.apk

        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Aplikacja została zainstalowana na telefonie!" -ForegroundColor Green
            Write-Host "⏰ Czas: $(Get-Date -Format 'HH:mm:ss')" -ForegroundColor Cyan
        } else {
            Write-Host "❌ Błąd podczas instalacji na telefonie!" -ForegroundColor Red
        }
    } else {
        Write-Host "❌ Błąd podczas budowania aplikacji!" -ForegroundColor Red
    }
}

function Watch-Files {
    Write-Host "👀 Uruchamianie obserwatora plików..." -ForegroundColor Green
    Write-Host "📂 Obserwuję zmiany w: app/src/main/" -ForegroundColor Blue
    Write-Host "💡 Naciśnij Ctrl+C aby zatrzymać" -ForegroundColor Yellow

    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "app/src/main/"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true

    # Filtruj tylko istotne pliki
    $watcher.Filter = "*.*"

    $action = {
        $path = $Event.SourceEventArgs.FullPath
        $name = $Event.SourceEventArgs.Name
        $changeType = $Event.SourceEventArgs.ChangeType

        # Ignoruj pliki tymczasowe i cache
        if ($name -notmatch '\.(tmp|swp|lock|class)$' -and $name -notmatch '~$') {
            Write-Host "📝 Zmiana wykryta: $name ($changeType)" -ForegroundColor Cyan
            Start-Sleep -Seconds 1  # Poczekaj na zakończenie zapisu
            Build-And-Install
            Write-Host "`n" -NoNewline
        }
    }

    Register-ObjectEvent -InputObject $watcher -EventName "Changed" -Action $action
    Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action $action
    Register-ObjectEvent -InputObject $watcher -EventName "Deleted" -Action $action

    try {
        while ($true) {
            Start-Sleep -Seconds 1
        }
    }
    finally {
        $watcher.Dispose()
        Write-Host "`n👋 Obserwator zatrzymany" -ForegroundColor Yellow
    }
}

# Sprawdź czy ADB jest dostępne
if (-not (Get-Command adb -ErrorAction SilentlyContinue)) {
    Write-Host "❌ ADB nie zostało znalezione! Upewnij się, że Android SDK jest zainstalowane i dodane do PATH." -ForegroundColor Red
    exit 1
}

# Sprawdź czy urządzenie jest podłączone
$devices = & adb devices | Select-String "device$"
if ($devices.Count -eq 0) {
    Write-Host "❌ Nie znaleziono podłączonego urządzenia Android!" -ForegroundColor Red
    Write-Host "💡 Upewnij się, że:" -ForegroundColor Yellow
    Write-Host "   1. Urządzenie jest podłączone przez USB" -ForegroundColor Yellow
    Write-Host "   2. Debugowanie USB jest włączone" -ForegroundColor Yellow
    Write-Host "   3. Sterowniki są zainstalowane" -ForegroundColor Yellow
    exit 1
}

Write-Host "📱 Znaleziono urządzenie: $($devices[0])" -ForegroundColor Green

if ($Watch) {
    # Najpierw zbuduj i zainstaluj
    Build-And-Install
    Write-Host "`n"
    # Potem uruchom obserwator
    Watch-Files
} else {
    # Jednorazowe budowanie i instalacja
    Build-And-Install
}
