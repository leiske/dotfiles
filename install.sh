#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mode="${1:-}"
profile_name=".home_profile"
other_profile_name=".work_profile"

if [[ "$mode" == "--work" ]]; then
  profile_name=".work_profile"
  other_profile_name=".home_profile"
fi

safe_symlink() {
  local src="$1"
  local dest="$2"

  if [[ ! -e "$src" ]]; then
    echo "Missing source file: $src" >&2
    exit 1
  fi

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    echo "Skipping $dest: exists and is not a symlink" >&2
    return 0
  fi

  if [[ -L "$dest" ]]; then
    rm "$dest"
  fi

  ln -s "$src" "$dest"
  echo "Linked $dest -> $src"
}

maybe_remove_other_profile() {
  local other_dest="$1"

  if [[ -L "$other_dest" ]]; then
    local target
    target="$(readlink "$other_dest" || true)"
    if [[ "$target" == "$repo_root"/* ]]; then
      rm "$other_dest"
      echo "Removed other profile symlink: $other_dest"
    fi
  fi
}

ensure_sourced_in_file() {
  local shell_file="$1"
  local profile_file="$2"
  local marker="# opencode dotfiles"

  if [[ ! -f "$shell_file" ]]; then
    return 1
  fi

  if ! grep -Fq "$marker" "$shell_file" 2>/dev/null; then
    printf "\n%s\n" "$marker" >>"$shell_file"
  fi

  local shared_line="[ -f \"$HOME/.shared_profile\" ] && source \"$HOME/.shared_profile\""
  local profile_line="[ -f \"$profile_file\" ] && source \"$profile_file\""

  grep -Fqx "$shared_line" "$shell_file" 2>/dev/null || printf "%s\n" "$shared_line" >>"$shell_file"
  grep -Fqx "$profile_line" "$shell_file" 2>/dev/null || printf "%s\n" "$profile_line" >>"$shell_file"

  echo "Updated $shell_file"
}

safe_symlink "$repo_root/bash/.shared_profile" "$HOME/.shared_profile"
safe_symlink "$repo_root/bash/$profile_name" "$HOME/$profile_name"
maybe_remove_other_profile "$HOME/$other_profile_name"

updated_any=0
for shell_file in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.bash_profile" "$HOME/.zsh_profile"; do
  if ensure_sourced_in_file "$shell_file" "$HOME/$profile_name"; then
    updated_any=1
  fi
done

if [[ "$updated_any" -eq 0 ]]; then
  echo "No shell startup files found among:" >&2
  echo "  ~/.bashrc ~/.bash_profile ~/.zshrc ~/.zsh_profile" >&2
  echo "Add these lines to the appropriate file:" >&2
  echo "  [ -f \"$HOME/.shared_profile\" ] && source \"$HOME/.shared_profile\"" >&2
  echo "  [ -f \"$HOME/$profile_name\" ] && source \"$HOME/$profile_name\"" >&2
fi
