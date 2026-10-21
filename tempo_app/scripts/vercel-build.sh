#!/usr/bin/env bash
# Vercel build for the Flutter web app. Vercel's build image has no Flutter,
# so the install phase fetches a pinned SDK; the build phase compiles.
#
#   bash scripts/vercel-build.sh install
#   bash scripts/vercel-build.sh build
#
# Override the SDK with the FLUTTER_VERSION environment variable (Vercel
# project settings) when upgrading Flutter; keep it equal to local/CI.
set -euo pipefail

FLUTTER_VERSION="${FLUTTER_VERSION:-3.44.6}"
FLUTTER_HOME="${FLUTTER_HOME:-$HOME/flutter-$FLUTTER_VERSION}"
export PATH="$FLUTTER_HOME/bin:$PATH"
# No telemetry or progress animations in CI logs.
export CI=true

install() {
  # Tools the Flutter SDK needs on first run; Vercel's Amazon Linux image
  # may lack some of them.
  local missing=()
  for tool in git curl unzip xz zip which file; do
    command -v "$tool" >/dev/null 2>&1 || missing+=("$tool")
  done
  if ((${#missing[@]})); then
    echo "Installing: ${missing[*]}"
    dnf install -y "${missing[@]}" >/dev/null
  fi

  if [[ ! -x "$FLUTTER_HOME/bin/flutter" ]]; then
    git clone --depth 1 --branch "$FLUTTER_VERSION" \
      https://github.com/flutter/flutter.git "$FLUTTER_HOME"
  fi
  flutter config --no-analytics --no-cli-animations >/dev/null
  flutter --version
  flutter precache --web
  flutter pub get
}

build() {
  # --wasm: WebAssembly with automatic JS fallback for older browsers.
  # --no-web-resources-cdn: self-host CanvasKit/skwasm instead of loading
  #   them from Google's CDN (offline-first, and safe under COEP).
  flutter build web --release --wasm --no-web-resources-cdn
}

case "${1:-}" in
  install) install ;;
  build) build ;;
  *) echo "usage: $0 install|build" >&2; exit 64 ;;
esac
