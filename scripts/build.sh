#!/usr/bin/env bash
set -e

if [ -f "build/web/index.html" ]; then
  echo "Found pre-built web bundle. Skipping SDK download."
  exit 0
fi

if ! command -v flutter >/dev/null 2>&1; then
  echo "Cloning Flutter SDK..."
  git clone https://github.com/flutter/flutter.git --depth 1 -b stable /tmp/flutter-sdk
fi

export PATH="/tmp/flutter-sdk/bin:$PATH"
flutter config --enable-web
flutter pub get
flutter build web --release
