# RimWorldRuslangAutoUpdater
![GitHub all releases](https://img.shields.io/github/downloads/asidsx/RimWorldRuslangAutoUpdater/total)

# Руководство пользователя: Обновление русской локализации игры

Этот репозиторий содержит скрипты для обновления русской локализации игры.

## Windows

Чтобы обновить русскую локализацию игры, выполните следующие действия:

1. Скачайте последний релиз с этого репозитория.
2. Положите файл `Обновить русскую локализацию.cmd` или `auto.bat` в папку с игрой.
3. Запустите файл `Обновить русскую локализацию.cmd` или `auto.bat`.
4. Последняя версия перевода будет скачана и установлена в игру.
5. Файл `Обновить русскую локализацию.cmd` или `auto.bat` закроется по нажатию любой клавиши.

## macOS

1. Скачайте файл `linux_osx_update.sh` из этого репозитория.
2. Откройте Finder, найдите `RimWorldMac.app` по пути `~/Library/Application Support/Steam/steamapps/common/RimWorld/`, нажмите правой кнопкой мыши и выберите «Показать содержимое пакета».
3. Положите `linux_osx_update.sh` в открывшуюся папку (рядом с папкой `Data`).
4. Откройте Terminal, перейдите в эту же папку и запустите:
   ```bash
   cd "/Users/$USER/Library/Application Support/Steam/steamapps/common/RimWorld/RimWorldMac.app"
   chmod +x "linux_osx_update.sh"
   ./"linux_osx_update.sh"
   ```
5. В игре выберите язык `Russian (Русский)`.

## Linux

1. Скачайте файл `linux_osx_update.sh` из этого репозитория.
2. Положите его в папку с игрой (для Steam по умолчанию это `~/.steam/steam/steamapps/common/RimWorld/`, рядом с папкой `Data`).
3. В терминале выполните:
   ```bash
   cd ~/.steam/steam/steamapps/common/RimWorld
   chmod +x "linux_osx_update.sh"
   ./"linux_osx_update.sh"
   ```
4. В игре выберите язык `Russian (Русский)`.

### Зависимости (macOS / Linux)

- `bash`, `tar` — предустановлены на macOS и в большинстве дистрибутивов Linux.
- `curl` или `wget` — на macOS `curl` есть из коробки; на Linux обычно тоже, иначе установите любой из них (например, `sudo apt install curl`).


