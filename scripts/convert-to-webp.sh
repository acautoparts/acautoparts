#!/bin/bash
# Convert all JPG/JPEG/PNG images to WebP format
# Usage: ./scripts/convert-to-webp.sh
# Requirements: cwebp (libwebp) OR ImageMagick

set -e

IMAGES_DIR="$(dirname "$0")/../images"
converted=0
skipped=0
failed=0

if command -v cwebp &>/dev/null; then
  CONVERTER="cwebp"
elif command -v convert &>/dev/null; then
  CONVERTER="imagemagick"
else
  echo "ERROR: Neither cwebp nor ImageMagick found. Install with:"
  echo "  macOS: brew install webp"
  echo "  Ubuntu: sudo apt-get install webp"
  exit 1
fi

echo "Using converter: $CONVERTER"
echo "Scanning: $IMAGES_DIR"

while IFS= read -r -d '' img; do
  webp_path="${img%.*}.webp"
  if [ -f "$webp_path" ]; then
    ((skipped++)) || true
    continue
  fi
  echo "Converting: $img"
  if [ "$CONVERTER" = "cwebp" ]; then
    cwebp -q 85 "$img" -o "$webp_path" 2>/dev/null && ((converted++)) || { echo "  FAILED: $img"; ((failed++)) || true; }
  else
    convert "$img" -quality 85 "$webp_path" 2>/dev/null && ((converted++)) || { echo "  FAILED: $img"; ((failed++)) || true; }
  fi
done < <(find "$IMAGES_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -print0)

echo ""
echo "Done! Converted: $converted, Skipped (already exist): $skipped, Failed: $failed"
