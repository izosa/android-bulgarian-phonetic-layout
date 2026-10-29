# Bulgarian Phonetic Traditional – физическа клавиатура за Android

[English below](#english)

Добавя подредбата **„Български фонетичен традиционен“** (както в Windows и Linux) за **физически клавиатури** на Android: Bluetooth, USB и клавиатури-калъфи като Samsung Book Cover Keyboard.

Android има вградена подредба „Bulgarian, Phonetic“, но тя е **новата** фонетична (Q=Ч, W=Ш, X=Ж). Ако сте свикнали с традиционната (Q=Я, W=В, X=Ь), това приложение е за вас.

Проверено на **Samsung Galaxy Tab S7+** с Android 13 (One UI 5.1), Samsung Keyboard и Book Cover Keyboard (EF-DT970).

## Подредба

```
┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
│ Ч │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │ 9 │ 0 │ - │ = │
└───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
  ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
  │ Я │ В │ Е │ Р │ Т │ Ъ │ У │ И │ О │ П │ Ш │ Щ │ Ю │
  └───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
    ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
    │ А │ С │ Д │ Ф │ Г │ Х │ Й │ К │ Л │ ; │ ' │
    └───┴───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
      ┌───┬───┬───┬───┬───┬───┬───┬───┬───┬───┐
      │ З │ Ь │ Ц │ Ж │ Б │ Н │ М │ , │ . │ / │
      └───┴───┴───┴───┴───┴───┴───┴───┴───┴───┘
```

- **Shift + цифри:** `! @ № $ % € § * ( ) – +`
- **Shift + `,` / `.`:** `„` и `“` (български кавички)
- **Клавиш `<>` до левия Shift** (на европейски клавиатури): **Ѝ**
- **Десен Alt (AltGr) + буква:** латинска буква, без да сменяте езика

## Инсталиране

1. Изтеглете [`built/ExternalKeyboardBulgarianPhoneticLayout.apk`](built/ExternalKeyboardBulgarianPhoneticLayout.apk) на устройството и го отворете. Ако бъдете попитани, разрешете инсталиране от неизвестни източници.
2. Приложението **няма икона**. Това е нормално, защото то само добавя подредба в системата.
3. Свържете клавиатурата.

## Избор на подредбата

**Samsung (One UI):**

1. **Настройки → Общо управление → Физическа клавиатура**
   > Внимание: това **не е** Samsung Keyboard → „Езици и типове“. Онова меню е за екранната клавиатура.
2. Изберете клавиатурата (напр. *Book Cover Keyboard*) и докоснете **Samsung Keyboard – Български**.
3. Изберете **Bulgarian Phonetic Traditional**.

**Други устройства (Pixel и др.):**
**Настройки → Система → Клавиатура → Физическа клавиатура** → изберете клавиатурата → **Bulgarian Phonetic Traditional**.

Сменяте езика с **Shift+Space** (или Ctrl+Space).

> На Samsung в списъка трябва първо да имате добавен български език в Samsung Keyboard. Ако подредбата не се появява, затворете Настройки напълно и ги отворете отново.

## Компилиране

Не е нужен Gradle, само Android SDK (build-tools 35.0.1, platform android-35) и JDK-то, което идва с Android Studio:

```powershell
./build.ps1
```

APK файлът се записва в `built/`. Подписан е с debug ключа от `~/.android/debug.keystore`. Ако нямате такъв ключ, скриптът го създава.

Самата подредба е във [`res/raw/keyboard_layout_bulgarian_phonetic.kcm`](res/raw/keyboard_layout_bulgarian_phonetic.kcm), във формата на Android за [Key Character Map](https://source.android.com/docs/core/interaction/input/key-character-map-files).

---

## English

Adds the **Traditional Bulgarian Phonetic** layout (as in Windows and Linux) for **hardware keyboards** on Android: Bluetooth, USB and keyboard covers such as the Samsung Book Cover Keyboard.

Android's built-in "Bulgarian, Phonetic" is the *new* phonetic layout (Q=Ч, W=Ш, X=Ж). This package provides the traditional one (Q=Я, W=В, X=Ь, `=Ч). Right Alt (AltGr) + letter types Latin letters.

Tested on a Samsung Galaxy Tab S7+ with Android 13 (One UI 5.1) and the Book Cover Keyboard.

**Install:** install [`built/ExternalKeyboardBulgarianPhoneticLayout.apk`](built/ExternalKeyboardBulgarianPhoneticLayout.apk). The app has no launcher icon.

**Select it:**
- Samsung: *Settings → General management → Physical keyboard → your keyboard → Samsung Keyboard – Български → Bulgarian Phonetic Traditional*.
- Other devices: *Settings → System → Keyboard → Physical keyboard*.

**Build:** run `./build.ps1`. It needs the Android SDK (build-tools 35.0.1, android-35) and a JDK, but no Gradle.

## Credits / License

Based on [marfl/android-bulgarian-phonetic-layout](https://github.com/marfl/android-bulgarian-phonetic-layout). The project structure came from juodumas' Lithuanian layouts package.

Changes in this version:
- targets Android 15, so it installs on Android 14+
- tagged as a Bulgarian (`bg`) layout, so it shows up in Samsung's physical keyboard settings
- fixed Shift+X (Ь)
- Gradle-free build script

### Лиценз / License

Проектът е с отворен код под [Unlicense](LICENSE), лиценз, одобрен от [OSI](https://opensource.org/license/unlicense). Всеки може свободно да го ползва, променя и разпространява, включително с търговска цел.

Open source under the [Unlicense](LICENSE) (OSI-approved, public domain dedication). Free to use, modify and redistribute for any purpose. The `.kcm` layout file is derived from AOSP and keeps its Apache License 2.0 header.
