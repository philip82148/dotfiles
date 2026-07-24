#!/usr/bin/env zsh

# dotfiles ディレクトリ直下にいるかチェック
check_current_dir() {
  local current_dir=$(basename "$PWD")
  if [[ "$current_dir" != "dotfiles" ]]; then
    echo "❌ Error: This script must be executed inside the 'dotfiles' directory."
    echo "Current directory: $PWD"
    exit 1
  fi
}

# OS判定関数 (mac / wsl / unknown)
get_os_type() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "mac"
  elif [[ -f /proc/version ]] && grep -qi "microsoft" /proc/version; then
    echo "wsl"
  else
    echo "unknown"
  fi
}
