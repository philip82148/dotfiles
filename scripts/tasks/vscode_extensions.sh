#!/usr/bin/env zsh

install_vscode_extensions() {
  local ext_file="config/vscode-extensions.txt"

  if [[ ! -f "$ext_file" ]]; then
    echo "⚠️  $ext_file not found. Skipping VS Code extensions installation."
    return 0
  fi

  echo "🧩 Installing VS Code extensions from $ext_file..."

  _install_ext() {
    local ext="$1"
    echo "  -> Installing extension: $ext"
    code --install-extension "$ext"
  }

  read_config_list "$ext_file" _install_ext
}
