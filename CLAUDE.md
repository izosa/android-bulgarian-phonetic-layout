# CLAUDE.md

Android package that adds the **Traditional Bulgarian Phonetic** layout for hardware keyboards
(Q=Я, W=В, X=Ь, `=Ч). Android's built-in "Bulgarian, Phonetic" is the *new* phonetic layout
(Q=Ч, W=Ш, X=Ж), which is why this package exists. There is no UI and no launcher icon: the system
reads the layout through the `QUERY_KEYBOARD_LAYOUTS` receiver's meta-data.

## Files

- `res/raw/keyboard_layout_bulgarian_phonetic.kcm`: the layout itself (Android Key Character Map). RAlt (AltGr) + letter types Latin.
- `res/xml/keyboard_layouts.xml`: declares the layout. Keep `app:subtypeLocale="bg"` (attr defined in `res/values/attrs.xml`): Samsung One UI only lists layouts tagged with the IME language, and without it the layout is missing from the "Български" picker.
- `AndroidManifest.xml`: keep `targetSdkVersion` recent (Android 14+ refuses to install apps targeting < 23) and the receiver `exported="true"`. Bump `versionCode`/`versionName` on every release.
- `src/.../InputDeviceReceiver.java`: empty receiver, only there so the manifest's class exists.
- `built/ExternalKeyboardBulgarianPhoneticLayout.apk`: committed APK that users download.
- `build.xml`: old ant build from upstream, unused.

## Build (Windows, no Gradle)

```powershell
./build.ps1
```

Uses `%LOCALAPPDATA%\Android\Sdk` (build-tools 35.0.1, platforms/android-35) and Android Studio's JDK at
`C:\Program Files\Android\Android Studio\jbr`. Override with `ANDROID_HOME` / `JAVA_HOME`. Signs with
`~/.android/debug.keystore` and writes to `built/`.

## Test on a device

```powershell
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" install -r built\ExternalKeyboardBulgarianPhoneticLayout.apk
& "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" shell "dumpsys input | grep -iE 'Bulgarian|CurrentKeyboardLayout'"
```

The layout is selected under **Settings → General management → Physical keyboard → (keyboard) → Samsung Keyboard – Български**,
not under Samsung Keyboard → Languages and types (that menu is for the on-screen keyboard).
`adb shell am start -a android.settings.HARD_KEYBOARD_SETTINGS` opens the right page.
Reinstalling with `-r` keeps the user's layout selection.

## Repo

- `origin`: https://github.com/izosa/android-bulgarian-phonetic-layout (fork, publish from `master`)
- `upstream`: https://github.com/marfl/android-bulgarian-phonetic-layout (original)
- Package name `name.marfl.ext_kbd_bulgarian_phonetic` is kept from upstream so it upgrades the original app.
- `git push` needs the user's GitHub login: run it in the user's terminal, not in a non-interactive shell.
- README is bilingual (Bulgarian first, then English). Visible labels must not mention marfl; credit stays in the README.
