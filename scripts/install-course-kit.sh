#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-$PWD}"
KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$TARGET_DIR/.claude/skills" "$TARGET_DIR/.claude/commands" "$TARGET_DIR/.claude/materialy"

for skill in bezpieczenstwo design karty kontekst obrazy sanity sprawdz-kod zbuduj-strone; do
  rm -rf "$TARGET_DIR/.claude/skills/$skill"
  cp -R "$KIT_DIR/40-skills/$skill" "$TARGET_DIR/.claude/skills/$skill"
done

cp "$KIT_DIR/40-skills/strona/COMMAND.md" "$TARGET_DIR/.claude/commands/strona.md"

rm -rf "$TARGET_DIR/.claude/materialy/30-szablony-md" "$TARGET_DIR/.claude/materialy/kurs" "$TARGET_DIR/.claude/materialy/prompty"
cp -R "$KIT_DIR/30-szablony-md" "$TARGET_DIR/.claude/materialy/30-szablony-md"
cp -R "$KIT_DIR/kurs" "$TARGET_DIR/.claude/materialy/kurs"
cp -R "$KIT_DIR/prompty" "$TARGET_DIR/.claude/materialy/prompty"

echo "OK: paczka kursowa zostala zainstalowana w $TARGET_DIR/.claude"
