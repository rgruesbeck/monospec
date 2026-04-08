#!/usr/bin/env bash
set -euo pipefail

MONOSPEC_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$HOME/.local/bin"
SCRIPT_SRC="$MONOSPEC_ROOT/scripts/monospec"
SCRIPT_DEST="$BIN_DIR/monospec"

# Detect shell config
if [[ "$SHELL" == */zsh ]]; then
  SHELL_RC="$HOME/.zshrc"
elif [[ "$SHELL" == */bash ]]; then
  SHELL_RC="$HOME/.bashrc"
else
  SHELL_RC="$HOME/.profile"
fi

# Create ~/.local/bin if needed
mkdir -p "$BIN_DIR"

# Symlink the script so updates to the repo are reflected immediately
if [[ -L "$SCRIPT_DEST" ]]; then
  rm "$SCRIPT_DEST"
fi
ln -s "$SCRIPT_SRC" "$SCRIPT_DEST"
chmod +x "$SCRIPT_SRC"

# Helper: append a line to shell rc only if a marker string isn't already present
append_if_absent() {
  local marker="$1"
  local line="$2"
  if ! grep -qF "$marker" "$SHELL_RC" 2>/dev/null; then
    echo "$line" >> "$SHELL_RC"
  fi
}

append_if_absent "MONOSPEC_ROOT" "export MONOSPEC_ROOT=\"$MONOSPEC_ROOT\"  # monospec"
append_if_absent "monospec:PATH" "export PATH=\"\$HOME/.local/bin:\$PATH\"  # monospec:PATH"

echo "installed:      $SCRIPT_DEST -> $SCRIPT_SRC"
echo "MONOSPEC_ROOT:  $MONOSPEC_ROOT"
echo "shell config:   $SHELL_RC"
echo ""
echo "reload your shell or run:"
echo "  source $SHELL_RC"
