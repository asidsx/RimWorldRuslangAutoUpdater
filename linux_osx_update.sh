#!/usr/bin/env bash
# Обновляет русскую локализацию RimWorld из репозитория Ludeon/RimWorld-ru.
# Работает на macOS и Linux. Положите рядом с папкой `Data`:
#   macOS: внутрь RimWorldMac.app (Показать содержимое пакета)
#   Linux: ~/.steam/steam/steamapps/common/RimWorld/
set -euo pipefail

ARCHIVE_URL="https://github.com/Ludeon/RimWorld-ru/archive/master.tar.gz"
DLCS=(Core Royalty Ideology Biotech Anomaly Odyssey)
LANG_NAME="Russian (Русский)"

SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)"
DATA_DIR="$SCRIPT_DIR/Data"

die() {
    echo "Ошибка: $*" >&2
    exit 1
}

if [ ! -d "$DATA_DIR" ]; then
    cat >&2 <<EOF
Ошибка: папка Data не найдена в $SCRIPT_DIR
Поместите скрипт в корневую папку игры:
  macOS — внутрь RimWorldMac.app (правый клик → Показать содержимое пакета)
  Linux — в ~/.steam/steam/steamapps/common/RimWorld/
EOF
    exit 1
fi

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/rimworld-ru.XXXXXX")"
trap 'rm -rf "$TMP_DIR"' EXIT INT TERM HUP

ARCHIVE_FILE="$TMP_DIR/master.tar.gz"

download() {
    if command -v curl >/dev/null 2>&1; then
        curl -fSL --progress-bar "$ARCHIVE_URL" -o "$ARCHIVE_FILE"
    elif command -v wget >/dev/null 2>&1; then
        wget --show-progress -q "$ARCHIVE_URL" -O "$ARCHIVE_FILE"
    else
        die "для скачивания требуется curl или wget"
    fi
}

echo "Скачивание последней версии локализации..."
download || die "не удалось скачать $ARCHIVE_URL"

echo "Распаковка архива..."
tar -xzf "$ARCHIVE_FILE" -C "$TMP_DIR" || die "не удалось распаковать архив"

# Имя корневой папки в архиве (например, RimWorld-ru-master) берём из самого
# архива, чтобы не сломаться при возможном переименовании ветки апстрима.
ARCHIVE_ROOT="$(tar -tzf "$ARCHIVE_FILE" | head -1 | cut -d/ -f1)"
SRC_DIR="$TMP_DIR/$ARCHIVE_ROOT"
[ -d "$SRC_DIR" ] || die "ожидаемая папка $SRC_DIR не найдена после распаковки"

echo "Установка локализации..."
installed=0
for dlc in "${DLCS[@]}"; do
    langs_dir="$DATA_DIR/$dlc/Languages"
    src="$SRC_DIR/$dlc"

    if [ ! -d "$langs_dir" ]; then
        echo "  Пропуск $dlc (дополнение не установлено)"
        continue
    fi
    if [ ! -d "$src" ]; then
        echo "  Пропуск $dlc (нет в архиве локализации)"
        continue
    fi

    rm -f  "$langs_dir/${LANG_NAME}.tar"
    rm -rf "$langs_dir/${LANG_NAME}"

    mkdir -p "$langs_dir/$LANG_NAME"
    cp -R "$src/." "$langs_dir/$LANG_NAME/"

    echo "  Установлено: $dlc"
    installed=$((installed + 1))
done

if [ "$installed" -eq 0 ]; then
    die "ни одно дополнение не было обновлено — проверьте, что Data/<DLC>/Languages существуют"
fi

echo "Готово. В игре выберите язык 'Russian (Русский)'."
