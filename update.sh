#!/usr/bin/env zsh

set -e

# モジュールの読み込み
source ./scripts/common/env.sh
source ./scripts/common/helpers.sh
source ./scripts/tasks/install_tasks.sh
source ./scripts/tasks/config_sync.sh
source ./scripts/tasks/vscode_jsonc.sh
source ./scripts/tasks/zsh.sh

check_current_dir
echo "🚀 Starting dotfiles update..."

OS_TYPE=$(get_os_type)

# 1. 更新前の事前バックアップ (タイムスタンプ付き)
create_backup "$OS_TYPE"

# 2. 各種設定の挿入・更新
update_gitconfig
update_config_files
update_vscode_keybindings "$OS_TYPE"
update_vscode_settings "$OS_TYPE"
setup_zshrc "$OS_TYPE"

echo "✅ Update complete!"
