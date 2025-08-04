#!/bin/bash

echo "📥 Syncing changes from system to dotfiles..."

# Copy current configs to dotfiles
cp ~/.zshrc .zshrc
cp ~/.gitconfig .gitconfig
cp ~/.ssh/config .ssh/config
cp ~/.nvmrc .nvmrc 2>/dev/null || echo "22" > .nvmrc

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