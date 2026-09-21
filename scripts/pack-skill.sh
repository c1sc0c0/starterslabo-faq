#!/usr/bin/env bash
# Build starterslabo-faq.zip with the folder layout Claude.ai requires.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

DEST="$STAGE/starterslabo-faq"
mkdir -p "$DEST/scripts"
cp "$ROOT/SKILL.md" "$ROOT/README.md" "$ROOT/LICENSE" "$DEST/"
cp "$ROOT/scripts/crawl_faq.py" "$ROOT/scripts/requirements.txt" "$DEST/scripts/"

OUT_DIR="$ROOT/dist"
mkdir -p "$OUT_DIR"
OUT="$OUT_DIR/starterslabo-faq.zip"
rm -f "$OUT"
(cd "$STAGE" && zip -r "$OUT" starterslabo-faq >/dev/null)

echo "Wrote $OUT"
unzip -l "$OUT"
