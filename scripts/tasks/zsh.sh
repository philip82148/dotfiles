#!/usr/bin/env zsh

setup_zshrc() {
  local os_type="$1"
  echo "🔍 Setting up ~/.zshrc for $os_type..."
  local target_zshrc_dir="src/.zshrc"

  case "$os_type" in
  "mac" | "wsl")
    sed '/# INSERT COMMON/,$d' "${target_zshrc_dir}/${os_type}.zshrc" >~/.zshrc
    cat "${target_zshrc_dir}/common.zshrc" >>~/.zshrc
    sed "1,/# INSERT COMMON/d" "${target_zshrc_dir}/${os_type}.zshrc" >>~/.zshrc
    ;;
  *)
    echo "❌ Unknown or unsupported environment."
    exit 1
    ;;
  esac
}

export_zshrc() {
  local os_type="$1"
  echo "🔍 Exporting .zshrc for $os_type..."
  local target_zshrc_dir="src/.zshrc"
  mkdir -p "$target_zshrc_dir"

  case "$os_type" in
  "mac" | "wsl")
    sed -n '/# COMMON START/,/# COMMON END/p' ~/.zshrc >"${target_zshrc_dir}/common.zshrc"
    sed '/# COMMON START/,$d' ~/.zshrc >"${target_zshrc_dir}/${os_type}.zshrc"
    echo "# INSERT COMMON" >>"${target_zshrc_dir}/${os_type}.zshrc"
    sed '1,/# COMMON END/d' ~/.zshrc >>"${target_zshrc_dir}/${os_type}.zshrc"
    ;;
  *)
    echo "❌ Unknown or unsupported environment."
    exit 1
    ;;
  esac
}
