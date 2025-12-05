# Szybka instalacja - buduje i instaluje aplikację na telefonie
./gradlew assembleDebug
if ($LASTEXITCODE -eq 0) {
    adb install -r app/build/outputs/apk/debug/app-debug.apk
}
