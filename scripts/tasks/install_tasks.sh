#!/usr/bin/env zsh

# バックアップ作成処理 (タイムスタンプ付きフォルダ)
create_backup() {
    local os_type="$1"
    local timestamp=$(date +"%Y%m%m_%H%M%S")
    local target_backup_dir="backup/$timestamp"

    echo "📦 Creating timestamped backup in '$target_backup_dir'..."
    mkdir -p "$target_backup_dir"

    # .gitconfig
    [[ -f "$HOME/.gitconfig" ]] && cp "$HOME/.gitconfig" "$target_backup_dir/.gitconfig"

    # .zshrc
    [[ -f "$HOME/.zshrc" ]] && cp "$HOME/.zshrc" "$target_backup_dir/.zshrc"

    # ~/.config items
    if [[ -f "config/config-include.txt" ]]; then
        mkdir -p "$target_backup_dir/.config"
        _backup_config_item() {
            local item="$1"
            if [[ -e "$HOME/.config/$item" ]]; then
                cp -r "$HOME/.config/$item" "$target_backup_dir/.config/"
            fi
        }
        read_config_list "config/config-include.txt" _backup_config_item
    fi

    # VS Code & Cursor settings / keybindings
    local vscode_dir=$(get_editor_user_dir "$os_type" "Code")
    local cursor_dir=$(get_editor_user_dir "$os_type" "Cursor")

    if [[ -n "$vscode_dir" && -d "$vscode_dir" ]]; then
        mkdir -p "$target_backup_dir/vscode"
        [[ -f "$vscode_dir/settings.json" ]] && cp "$vscode_dir/settings.json" "$target_backup_dir/vscode/settings.json"
        [[ -f "$vscode_dir/keybindings.json" ]] && cp "$vscode_dir/keybindings.json" "$target_backup_dir/vscode/keybindings.json"
    fi

    if [[ -n "$cursor_dir" && -d "$cursor_dir" ]]; then
        mkdir -p "$target_backup_dir/cursor"
        [[ -f "$cursor_dir/settings.json" ]] && cp "$cursor_dir/settings.json" "$target_backup_dir/cursor/settings.json"
        [[ -f "$cursor_dir/keybindings.json" ]] && cp "$cursor_dir/keybindings.json" "$target_backup_dir/cursor/keybindings.json"
    fi

    echo "✅ Backup completed -> '$target_backup_dir/'"
}

# まるごと上書きインストール処理
full_install_files() {
    local os_type="$1"
    echo "🚀 Overwriting and installing configuration files..."

    # --- .gitconfig ---
    if [[ -f "src/.gitconfig" ]]; then
        echo "  -> Copying src/.gitconfig -> ~/.gitconfig"
        cp "src/.gitconfig" "$HOME/.gitconfig"
    fi

    # --- .zshrc ---
    echo "  -> Building and copying ~/.zshrc for $os_type"
    local target_zshrc_dir="src/.zshrc"
    case "$os_type" in
    "mac" | "wsl")
        sed '/# INSERT COMMON/,$d' "${target_zshrc_dir}/${os_type}.zshrc" >~/.zshrc
        cat "${target_zshrc_dir}/common.zshrc" >>~/.zshrc
        sed "1,/# INSERT COMMON/d" "${target_zshrc_dir}/${os_type}.zshrc" >>~/.zshrc
        ;;
    esac

    # --- ~/.config items ---
    if [[ -f "config/config-include.txt" ]]; then
        mkdir -p ~/.config
        _install_config_item() {
            local item="$1"
            if [[ -e "src/.config/$item" ]]; then
                echo "  -> Copying src/.config/$item -> ~/.config/$item"
                rm -rf "$HOME/.config/$item"
                cp -r "src/.config/$item" "$HOME/.config/"
            fi
        }
        read_config_list "config/config-include.txt" _install_config_item
    fi

    # --- VS Code & Cursor Settings / Keybindings ---
    local vscode_dir=$(get_editor_user_dir "$os_type" "Code")
    local cursor_dir=$(get_editor_user_dir "$os_type" "Cursor")

    _copy_editor_configs() {
        local target_dir="$1"
        local label="$2"
        if [[ -n "$target_dir" && (-d "$target_dir" || -f "$target_dir/settings.json" || -f "$target_dir/keybindings.json") ]]; then
            mkdir -p "$target_dir"
            if [[ -f "src/vscode-user-settings.jsonc" ]]; then
                echo "  -> Overwriting $label settings.json"
                cp "src/vscode-user-settings.jsonc" "$target_dir/settings.json"
            fi
            if [[ -f "src/vscode-keybindings.jsonc" ]]; then
                echo "  -> Overwriting $label keybindings.json"
                cp "src/vscode-keybindings.jsonc" "$target_dir/keybindings.json"
            fi
        fi
    }

    _copy_editor_configs "$vscode_dir" "VS Code"
    _copy_editor_configs "$cursor_dir" "Cursor"
}

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
        code --install-extension "$ext" >/dev/null
    }

    read_config_list "$ext_file" _install_ext
}
