# Scripts

## convert-to-webp.sh

Converts all JPG/JPEG/PNG images under the `images/` directory to WebP format alongside the originals (originals are kept as fallbacks for browsers that do not support WebP).

### What it does

- Finds all `.jpg`, `.jpeg`, and `.png` files recursively under `images/`
- Converts each to a `.webp` file in the same directory
- Skips files that already have a `.webp` counterpart (safe to run multiple times)
- Reports how many files were converted, skipped, or failed

### Prerequisites

Install one of the following:

- **cwebp** (preferred): `brew install webp` (macOS) or `sudo apt-get install webp` (Ubuntu)
- **ImageMagick** (fallback): `brew install imagemagick` (macOS) or `sudo apt-get install imagemagick` (Ubuntu)

### Usage

```bash
cd /path/to/acautoparts
bash scripts/convert-to-webp.sh
```
