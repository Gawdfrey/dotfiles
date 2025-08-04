#!/bin/bash

echo "📥 Syncing changes from system to dotfiles..."

# Copy current configs to dotfiles
cp ~/.zshrc .zshrc
cp ~/.gitconfig .gitconfig
cp ~/.gitignore_global .gitignore_global 2>/dev/null || echo "# Global gitignore not found"
cp ~/.editorconfig .editorconfig 2>/dev/null || echo "# EditorConfig not found"
cp ~/.ssh/config .ssh/config
cp ~/.nvmrc .nvmrc 2>/dev/null || echo "22" > .nvmrc

# VS Code settings
if [ -f "$HOME/Library/Application Support/Code/User/settings.json" ]; then
    cp "$HOME/Library/Application Support/Code/User/settings.json" vscode-settings.json
    echo "✅ VS Code settings copied"
fi

# Update Brewfile
echo "📦 Updating Brewfile..."
brew bundle dump --force --file=Brewfile

# Update VS Code extensions
echo "📝 Updating VS Code extensions..."
code --list-extensions > vscode-extensions.txt

# Update global npm packages
echo "🟢 Updating global npm packages..."
npm list -g --depth=0 --parseable | grep -v '/npm$' | awk -F'/' '{print $NF}' | grep -v '^npm@' > global-npm-packages.txt

echo "✅ Sync complete! Review changes with 'git status'"