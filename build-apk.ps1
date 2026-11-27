# Run in PowerShell inside the extracted folder (requires Node.js + Android Studio/SDK)
$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force -Path "www" | Out-Null
Copy-Item "index.html", "404.html", "manifest.json", "sw.js", "icon-192.png", "icon-512.png" -Destination "www" -Force

if (-not (Test-Path "package.json")) {
    npm init -y | Out-Null
    npm install @capacitor/core @capacitor/cli @capacitor/android
    npx cap init "Fantasy Insights" "com.fantasyinsights.app" --web-dir www
    npx cap add android
} else {
    npx cap copy android
}

Set-Location "android"
.\gradlew.bat assembleDebug
Write-Host "APK built at: android\app\build\outputs\apk\debug\app-debug.apk" -ForegroundColor Green
