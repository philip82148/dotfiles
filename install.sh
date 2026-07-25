#!/usr/bin/env zsh

set -e

# モジュールの読み込み
source ./scripts/common/env.sh
source ./scripts/common/helpers.sh
source ./scripts/tasks/install_tasks.sh

check_current_dir

echo "⚠️  WARNING: This script will OVERWRITE your local configuration files with files from 'src/'."
echo "ℹ️  Existing configuration files will be backed up to a timestamped folder inside 'backup/' before installation."
echo -n "Are you sure you want to proceed with full installation? (y/N): "
read reply

if [[ ! "$reply" =~ ^[Yy]$ ]]; then
    echo "❌ Installation cancelled."
    exit 0
fi

OS_TYPE=$(get_os_type)

# 1. バックアップの作成 (タイムスタンプフォルダ作成)
create_backup "$OS_TYPE"

# 2. 各種設定ファイルの全体コピー上書き
full_install_files "$OS_TYPE"

# 3. VS Code 拡張機能のインストール
install_vscode_extensions

echo "🎉 Full installation completed successfully!"
