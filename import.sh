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
echo "🚀 Starting dotfiles import..."

mkdir -p src

OS_TYPE=$(get_os_type)

import_gitconfig
import_config_files
clean_ignored_configs
import_vscode_keybindings "$OS_TYPE"
import_vscode_settings "$OS_TYPE"
import_brewfile
import_zshrc "$OS_TYPE"

echo "✅ Import complete!"
