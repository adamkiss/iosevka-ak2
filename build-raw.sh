#!/usr/bin/env bash
set -euo pipefail

git clone https://github.com/be5invis/Iosevka.git --depth 1
cp private-build-plans.toml Iosevka/

AK_VERSION=$(head -n 1 private-build-plans.toml | cut -f 3 -d ' ')
export AK_VERSION
cd Iosevka
IO_VERSION=$(jq -r '(.version)' package.json)
export IO_VERSION
IO_SHA=$(git rev-parse --short HEAD)
export IO_SHA

export FULLID="$AK_VERSION.$IO_VERSION.$IO_SHA"
npm install
npm run build -- ttf::iosevka-ak2
npm run build -- ttf::iosevka-ak2-prose

zip -jr "iosevka-ak2-$FULLID.zip" dist/iosevka-ak2/TTF
zip -jr "iosevka-ak2-$FULLID-unhinted.zip" dist/iosevka-ak2/TTF-Unhinted
zip -jr "iosevka-ak2-prose-$FULLID.zip" dist/iosevka-ak2-prose/TTF
zip -jr "iosevka-ak2-prose-$FULLID-unhinted.zip" dist/iosevka-ak2-prose/TTF-Unhinted

echo "DONE"