#!/bin/bash

echo "📤 Syncing dotfiles to system..."

# Create symlinks for dotfiles
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/.gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.ssh"
ln -sf "$PWD/.ssh/config" "$HOME/.ssh/config"
ln -sf "$PWD/.nvmrc" "$HOME/.nvmrc"

echo "🔄 Reloading shell configuration..."
source ~/.zshrc

echo "✅ Sync to system complete!"