#!/usr/bin/env zsh

install_gitconfig() {
  echo "📋 Setting up ~/.gitconfig..."
  inject_common_block "$HOME/.gitconfig" "src/.gitconfig" "#"
}

export_gitconfig() {
  echo "📄 Exporting ~/.gitconfig COMMON block..."
  if export_common_block "$HOME/.gitconfig" "src/.gitconfig" "#"; then
    echo "✅ Exported .gitconfig COMMON block to src/.gitconfig"
  else
    echo "⚠️  No '# COMMON START' block found in ~/.gitconfig. Skipping."
  fi
}

install_config_files() {
  echo "📦 Copying ~/.config items..."
  local include_file="config/config-include.txt"

  if [[ -f "$include_file" ]]; then
    mkdir -p ~/.config
    _restore_item() {
      local item="$1"
      if [[ -d "src/.config/$item" || -f "src/.config/$item" ]]; then
        echo "  -> Restoring ~/.config/$item"
        cp -r "src/.config/$item" ~/.config/
      fi
    }
    read_config_list "$include_file" _restore_item
  elif [[ -d "src/.config" ]]; then
    cp -r src/.config ~/.config
  fi
}

export_config_files() {
  local include_file="config/config-include.txt"

  if [[ -f "$include_file" ]]; then
    echo "📦 Exporting specified ~/.config items from $include_file..."
    mkdir -p src/.config
    _export_item() {
      local item="$1"
      if [[ -d "$HOME/.config/$item" || -f "$HOME/.config/$item" ]]; then
        echo "  -> Copying ~/.config/$item"
        rm -rf "src/.config/$item"
        cp -r "$HOME/.config/$item" "src/.config/$item"
      fi
    }
    read_config_list "$include_file" _export_item
  else
    echo "⚠️  $include_file not found. Copying all ~/.config..."
    cp -r ~/.config src/
  fi
}

clean_ignored_configs() {
  local ignore_file="config/config-ignore.txt"

  if [[ -f "$ignore_file" ]]; then
    echo "🧹 Removing ignored files/folders specified in $ignore_file..."
    _remove_item() {
      local item="$1"
      if [[ -e "src/.config/$item" ]]; then
        echo "  -> Removing src/.config/$item"
        rm -rf "src/.config/$item"
      fi
    }
    read_config_list "$ignore_file" _remove_item
  fi
}
