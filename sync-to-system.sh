#!/bin/bash

echo "📤 Syncing dotfiles to system..."

# Create symlinks for dotfiles
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/.gitconfig" "$HOME/.gitconfig"
ln -sf "$PWD/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$PWD/.editorconfig" "$HOME/.editorconfig"
mkdir -p "$HOME/.ssh"
ln -sf "$PWD/.ssh/config" "$HOME/.ssh/config"
ln -sf "$PWD/.nvmrc" "$HOME/.nvmrc"

# VS Code settings
if [ -d "$HOME/Library/Application Support/Code/User" ]; then
    ln -sf "$PWD/vscode-settings.json" "$HOME/Library/Application Support/Code/User/settings.json"
    echo "✅ VS Code settings synced"
fi

echo "🔄 Reloading shell configuration..."
if [ "$SHELL" = "/bin/zsh" ] || [ "$SHELL" = "/usr/local/bin/zsh" ] || [ "$SHELL" = "/opt/homebrew/bin/zsh" ]; then
    zsh -c "source ~/.zshrc"
else
    echo "⚠️  Please restart your terminal or run 'source ~/.zshrc' in a zsh shell"
fi

echo "✅ Sync to system complete!"