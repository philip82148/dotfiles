#!/usr/bin/env zsh

set -e

# モジュールの読み込み
source ./scripts/common/env.sh
source ./scripts/common/helpers.sh
source ./scripts/tasks/config_sync.sh
source ./scripts/tasks/vscode_jsonc.sh
source ./scripts/tasks/brew.sh
source ./scripts/tasks/zsh.sh

check_current_dir
echo "🚀 Starting dotfiles export..."

mkdir -p src

OS_TYPE=$(get_os_type)

export_gitconfig
export_config_files
clean_ignored_configs
export_vscode_keybindings "$OS_TYPE"
export_vscode_settings "$OS_TYPE"
export_brewfile
export_zshrc "$OS_TYPE"

echo "✅ Export complete!"
