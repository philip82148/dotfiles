#!/usr/bin/env zsh

set -e

# モジュールの読み込み
source ./scripts/common/env.sh
source ./scripts/common/helpers.sh
source ./scripts/tasks/config_sync.sh
source ./scripts/tasks/vscode_extensions.sh
source ./scripts/tasks/vscode_jsonc.sh
source ./scripts/tasks/zsh.sh

check_current_dir
echo "🚀 Starting dotfiles installation..."

OS_TYPE=$(get_os_type)

install_gitconfig
install_config_files
install_vscode_extensions
install_vscode_keybindings "$OS_TYPE"
install_vscode_settings "$OS_TYPE"
setup_zshrc "$OS_TYPE"

echo "✅ Installation complete!"
