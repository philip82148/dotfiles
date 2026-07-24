#!/usr/bin/env zsh

# --- Install ---
install_vscode_keybindings() {
  local os_type="$1"
  echo "⌨️  Setting up keybindings for VS Code & Cursor..."
  local src_file="src/vscode-keybindings.jsonc"

  local vscode_dir cursor_dir
  [[ "$os_type" == "mac" ]] && vscode_dir="$HOME/Library/Application Support/Code/User" || vscode_dir="$HOME/.config/Code/User"
  [[ "$os_type" == "mac" ]] && cursor_dir="$HOME/Library/Application Support/Cursor/User" || cursor_dir="$HOME/.config/Cursor/User"

  [[ -d "$vscode_dir" || -f "$vscode_dir/keybindings.json" ]] && inject_common_block "$vscode_dir/keybindings.json" "$src_file" "//"
  [[ -d "$cursor_dir" || -f "$cursor_dir/keybindings.json" ]] && inject_common_block "$cursor_dir/keybindings.json" "$src_file" "//"
}

install_vscode_settings() {
  local os_type="$1"
  echo "⚙️  Setting up user settings for VS Code & Cursor..."
  local src_file="src/vscode-user-settings.jsonc"

  local vscode_dir cursor_dir
  [[ "$os_type" == "mac" ]] && vscode_dir="$HOME/Library/Application Support/Code/User" || vscode_dir="$HOME/.config/Code/User"
  [[ "$os_type" == "mac" ]] && cursor_dir="$HOME/Library/Application Support/Cursor/User" || cursor_dir="$HOME/.config/Cursor/User"

  [[ -d "$vscode_dir" || -f "$vscode_dir/settings.json" ]] && inject_common_block "$vscode_dir/settings.json" "$src_file" "//"
  [[ -d "$cursor_dir" || -f "$cursor_dir/settings.json" ]] && inject_common_block "$cursor_dir/settings.json" "$src_file" "//"
}

# --- Export ---
_export_jsonc_common() {
  local os_type="$1"
  local file_name="$2"
  local target_src_file="$3"
  local label="$4"

  echo "📄 Exporting $label..."
  local vscode_path="" cursor_path=""

  case "$os_type" in
    "mac")
      vscode_path="$HOME/Library/Application Support/Code/User/$file_name"
      cursor_path="$HOME/Library/Application Support/Cursor/User/$file_name"
      ;;
    "wsl")
      vscode_path="$HOME/.config/Code/User/$file_name"
      cursor_path="$HOME/.config/Cursor/User/$file_name"
      ;;
    *)
      echo "⚠️  Unknown OS. Skipping $label export."
      return 0
      ;;
  esac

  local tmp_vscode_out=$(mktemp)
  local tmp_cursor_out=$(mktemp)

  # 一時ファイルへ純粋に COMMON 区間のテキストのみを抽出
  local has_vscode=$(extract_common "$vscode_path" "$tmp_vscode_out" "//" && echo 1 || echo 0)
  local has_cursor=$(extract_common "$cursor_path" "$tmp_cursor_out" "//" && echo 1 || echo 0)

  local selected_file=""

  if [[ $has_vscode -eq 1 && $has_cursor -eq 1 ]]; then
    if cmp -s "$tmp_vscode_out" "$tmp_cursor_out"; then
      echo "  ✓ VS Code and Cursor $label COMMON blocks are identical."
      selected_file="$vscode_path"
    else
      echo "⚠️  Diff detected between VS Code and Cursor COMMON $label!"
      echo "------------------------------------------------------------"
      diff -u "$tmp_vscode_out" "$tmp_cursor_out" || true
      echo "------------------------------------------------------------"
      echo -n "Which $label COMMON block do you want to export? 1) VS Code 2) Cursor [default: 1]: "
      read choice
      [[ "$choice" == "2" ]] && selected_file="$cursor_path" || selected_file="$vscode_path"
    fi
  elif [[ $has_vscode -eq 1 ]]; then
    selected_file="$vscode_path"
  elif [[ $has_cursor -eq 1 ]]; then
    selected_file="$cursor_path"
  else
    echo "⚠️  No COMMON $label block found in VS Code or Cursor. Skipping."
    rm -f "$tmp_vscode_out" "$tmp_cursor_out"
    return 0
  fi

  rm -f "$tmp_vscode_out" "$tmp_cursor_out"

  # 選択された実機ファイルから target_src_file (src/配下) へマーカー置換エクスポート
  export_common_block "$selected_file" "$target_src_file" "//"

  echo "✅ $label exported to $target_src_file"
}

export_vscode_keybindings() {
  _export_jsonc_common "$1" "keybindings.json" "src/vscode-keybindings.jsonc" "Keybindings"
}

export_vscode_settings() {
  _export_jsonc_common "$1" "settings.json" "src/vscode-user-settings.jsonc" "User Settings"
}
