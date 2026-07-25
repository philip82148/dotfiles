#!/usr/bin/env zsh

# --- 設定ファイル読み込みヘルパー ---
read_config_list() {
  local file_path="$1"
  local callback_func="$2"

  if [[ ! -f "$file_path" ]]; then
    return 1
  fi

  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue
    local target=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    "$callback_func" "$target"
  done <"$file_path"
}

# --- 汎用: COMMONブロック挿入・置換関数 (Update用) ---
inject_common_block() {
  local target_file="$1"         # 適用先 (例: ~/.gitconfig, settings.json)
  local src_file="$2"            # 参照元 (例: src/.gitconfig, src/vscode-user-settings.jsonc)
  local comment_prefix="${3:-#}" # コメント記号 (# または //)

  if [[ ! -f "$src_file" ]]; then
    echo "⚠️  Source file '$src_file' not found. Skipping."
    return 0
  fi

  local start_marker="${comment_prefix} COMMON START"
  local end_marker="${comment_prefix} COMMON END"

  # ターゲットファイルが存在しない場合は、参照元をそのままコピーして終了
  if [[ ! -f "$target_file" ]]; then
    mkdir -p "$(dirname "$target_file")"
    cp "$src_file" "$target_file"
    echo "  -> Created $target_file"
    return 0
  fi

  # マーカーが存在しない場合はエラー終了
  if ! grep -qF "${start_marker}" "$target_file"; then
    echo "❌ Error: Marker '${start_marker}' not found in '$target_file'."
    echo "   Please add '${start_marker}' and '${end_marker}' to the target file first."
    exit 1
  fi

  echo "  -> Updating $target_file..."

  local tmp_file=$(mktemp)
  local common_tmp=$(mktemp)

  local safe_start="${start_marker//\//\\/}"
  local safe_end="${end_marker//\//\\/}"

  # src から COMMON ブロックを抽出
  sed -n "/${safe_start}/,/${safe_end}/p" "$src_file" >"$common_tmp"

  # ターゲットファイルの COMMON START より前を出力
  sed "/${safe_start}/,\$d" "$target_file" >"$tmp_file"
  # 抽出した COMMON ブロックを結合
  cat "$common_tmp" >>"$tmp_file"
  # ターゲットファイルの COMMON END より後を出力
  sed "1,/${safe_end}/d" "$target_file" >>"$tmp_file"

  mv "$tmp_file" "$target_file"
  rm -f "$common_tmp"
}

# 補助関数: 純粋にマーカー区間テキストを抽出する
extract_common() {
  local target_file="$1"         # 読み取り元 (例: ~/.gitconfig, settings.json)
  local output_file="$2"         # 保存先 (例: src/.gitconfig, src/vscode-user-settings.jsonc)
  local comment_prefix="${3:-#}" # コメント記号 (# または //)

  if [[ ! -f "$target_file" ]]; then
    return 1
  fi

  local start_marker="${comment_prefix} COMMON START"
  local end_marker="${comment_prefix} COMMON END"

  if ! grep -qF "${start_marker}" "$target_file"; then
    return 1
  fi

  local safe_start="${start_marker//\//\\/}"
  local safe_end="${end_marker//\//\\/}"
  # マーカーで囲まれた行のみを抽出
  sed -n "/${safe_start}/,/${safe_end}/p" "$target_file" >"$output_file"
  [[ -s "$output_file" ]] && return 0 || return 1
}

# --- 汎用: COMMONブロック抽出・置換関数 (Import用) ---
import_common_block() {
  local target_file="$1"         # 読み取り元実機ファイル (例: ~/.gitconfig)
  local output_file="$2"         # 保存先リポジトリファイル (例: src/.gitconfig)
  local comment_prefix="${3:-#}" # コメント記号 (# または //)

  if [[ ! -f "$target_file" ]]; then
    return 1
  fi

  local start_marker="${comment_prefix} COMMON START"
  local end_marker="${comment_prefix} COMMON END"

  # 1. 読み取り元にマーカーが存在するかチェック
  if ! grep -qF "${start_marker}" "$target_file"; then
    return 1
  fi

  # 2. 保存先ファイルが既に存在する場合、保存先側にもマーカーがあるかチェック
  if [[ -f "$output_file" ]] && ! grep -qF "${start_marker}" "$output_file"; then
    echo "❌ Error: Import target file '$output_file' exists but lacks '${start_marker}' marker."
    echo "   Please add '${start_marker}' and '${end_marker}' to '$output_file' first."
    exit 1
  fi

  local common_tmp=$(mktemp)
  extract_common "$target_file" "$common_tmp" "$comment_prefix"

  if [[ ! -f "$output_file" ]]; then
    # 出力先が存在しない場合は新規作成
    mkdir -p "$(dirname "$output_file")"
    cp "$common_tmp" "$output_file"
  else
    # 出力先が存在する場合は、マーカー区間のみを置換
    local safe_start="${start_marker//\//\\/}"
    local safe_end="${end_marker//\//\\/}"
    local tmp_file=$(mktemp)
    sed "/${safe_start}/,\$d" "$output_file" >"$tmp_file"
    cat "$common_tmp" >>"$tmp_file"
    sed "1,/${safe_end}/d" "$output_file" >>"$tmp_file"
    mv "$tmp_file" "$output_file"
  fi

  rm -f "$common_tmp"
  return 0
}

# --- エディタパス取得ヘルパー ---
get_editor_user_dir() {
  local target_os="$1"     # mac または wsl
  local target_editor="$2" # Code または Cursor
  local config_file="config/editor-paths.txt"

  if [[ ! -f "$config_file" ]]; then
    return 1
  fi

  # 検索用キーの作成 (例: mac + cursor -> MAC_CURSOR_DIR)
  local os_upper="${(U)target_os}"
  local editor_upper="${(U)target_editor}"
  local target_key="${os_upper}_${editor_upper}_DIR"

  while IFS= read -r line || [[ -n "$line" ]]; do
    # 空行やコメント行を無視
    [[ -z "$line" || "$line" =~ ^[[:space:]]*# ]] && continue

    # '=' が含まれていない行をスキップ
    [[ "$line" != *"="* ]] && continue

    # KEY=VALUE の分割
    local key="${line%%=*}"
    local raw_path="${line#*=}"

    # 前後の空白除去
    key=$(echo "$key" | xargs)
    raw_path=$(echo "$raw_path" | xargs)

    # シングルクォートやダブルクォートが端にあれば除去
    raw_path="${raw_path#[\'\"]}"
    raw_path="${raw_path%[\'\"]}"

    if [[ "$key" == "$target_key" ]]; then
      # $HOME または ~ を現在の環境変数で置換して展開
      local expanded_path="${raw_path/\$HOME/$HOME}"
      expanded_path="${expanded_path/#\~/$HOME}"

      echo "$expanded_path"
      return 0
    fi
  done <"$config_file"

  return 1
}
