# Pełne budowanie z czyszczeniem cache
./gradlew clean assembleDebug
if ($LASTEXITCODE -eq 0) {
    adb install -r app/build/outputs/apk/debug/app-debug.apk
}
