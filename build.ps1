# Builds the APK with the plain Android SDK tools (no Gradle needed).
# Requires: Android SDK (build-tools 35.0.1, platform android-35) and the JDK bundled with Android Studio.
$ErrorActionPreference = 'Stop'

$sdk   = if ($env:ANDROID_HOME) { $env:ANDROID_HOME } else { "$env:LOCALAPPDATA\Android\Sdk" }
$bt    = "$sdk\build-tools\35.0.1"
$jar   = "$sdk\platforms\android-35\android.jar"
$jdk   = if ($env:JAVA_HOME) { $env:JAVA_HOME } else { 'C:\Program Files\Android\Android Studio\jbr' }
$root  = $PSScriptRoot
$out   = "$root\build"
$name  = 'ExternalKeyboardBulgarianPhoneticLayout'

Remove-Item -Recurse -Force $out -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force "$out\res", "$out\classes", "$out\dex" | Out-Null

# Resources + manifest
& "$bt\aapt2.exe" compile --dir "$root\res" -o "$out\res\res.zip"
if ($LASTEXITCODE) { throw 'aapt2 compile failed' }
& "$bt\aapt2.exe" link -o "$out\unaligned.apk" -I $jar --manifest "$root\AndroidManifest.xml" "$out\res\res.zip"
if ($LASTEXITCODE) { throw 'aapt2 link failed' }

# Code
$sources = Get-ChildItem -Recurse "$root\src" -Filter *.java | ForEach-Object FullName
& "$jdk\bin\javac.exe" --release 8 -classpath $jar -d "$out\classes" $sources 2>&1 | Where-Object { $_ -notmatch 'warning: \[options\]|^1 warning|^3 warnings' }
if ($LASTEXITCODE) { throw 'javac failed' }
$classes = Get-ChildItem -Recurse "$out\classes" -Filter *.class | ForEach-Object FullName
$env:JAVA_HOME = $jdk
& "$bt\d8.bat" --lib $jar --min-api 21 --output "$out\dex" $classes
if ($LASTEXITCODE) { throw 'd8 failed' }

# Add classes.dex to the APK
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zip = [System.IO.Compression.ZipFile]::Open("$out\unaligned.apk", 'Update')
[System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, "$out\dex\classes.dex", 'classes.dex') | Out-Null
$zip.Dispose()

# Align and sign with the standard Android debug key
& "$bt\zipalign.exe" -f -p 4 "$out\unaligned.apk" "$out\aligned.apk"
if ($LASTEXITCODE) { throw 'zipalign failed' }
$ks = "$env:USERPROFILE\.android\debug.keystore"
if (-not (Test-Path $ks)) {
    New-Item -ItemType Directory -Force (Split-Path $ks) | Out-Null
    & "$jdk\bin\keytool.exe" -genkeypair -keystore $ks -storepass android -keypass android -alias androiddebugkey `
        -keyalg RSA -keysize 2048 -validity 10000 -dname 'CN=Android Debug,O=Android,C=US'
}
& "$bt\apksigner.bat" sign --ks $ks --ks-pass pass:android --key-pass pass:android --out "$root\built\$name.apk" "$out\aligned.apk"
if ($LASTEXITCODE) { throw 'apksigner failed' }

Write-Host "Built: $root\built\$name.apk"
