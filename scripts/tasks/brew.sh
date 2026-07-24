#!/usr/bin/env zsh

export_brewfile() {
  if command -v brew >/dev/null 2>&1; then
    echo "🍺 Dumping Homebrew packages..."
    brew bundle dump -f --no-describe --no-vscode --file=src/Brewfile
  else
    echo "⚠️  Homebrew is not installed. Skipping 'brew bundle dump'."
  fi
}
