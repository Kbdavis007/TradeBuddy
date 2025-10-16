#!/usr/bin/env bash
set -euo pipefail

echo "Running post-create steps: ensure uv tool 'specify-cli' from spec-kit is installed"

# Ensure pipx binary dir is on PATH for this script
export PIPX_BIN_DIR="/home/vscode/.local/bin"
export PATH="$PIPX_BIN_DIR:$PATH"

if ! command -v uv >/dev/null 2>&1; then
  echo "uv not found on PATH. Attempting to install via pipx..."
  python -m pip install --user pipx
  python -m pipx ensurepath || true
  python -m pipx install uv || true
fi

echo "Installing specify-cli from GitHub spec-kit"
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git || {
  echo "uv tool install failed; printing uv version and PATH for debugging"
  uv --version || true
  env | sort
  exit 1
}

echo "specify-cli installed. You can run 'specify-cli --help' or 'uv tools list'"
