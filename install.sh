#!/bin/bash

set -e

echo "🚀 Setting up your Mac..."

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages from Brewfile
echo "📦 Installing Homebrew packages..."
brew bundle --file=Brewfile

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "🐚 Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Create symlinks for dotfiles
echo "🔗 Creating symlinks..."
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/.gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.ssh"
ln -sf "$PWD/.ssh/config" "$HOME/.ssh/config"
ln -sf "$PWD/.nvmrc" "$HOME/.nvmrc"

# Install Node.js and global packages
echo "🟢 Setting up Node.js..."
./install-global-packages.sh

# Install VS Code extensions
echo "📝 Installing VS Code extensions..."
./install-vscode-extensions.sh

# Install Starship prompt
echo "🚀 Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "✅ Setup complete! Please restart your terminal or run 'source ~/.zshrc'"
echo "📝 Don't forget to:"
echo "   - Sign in to 1Password"
echo "   - Configure your SSH keys with 1Password"
echo "   - Sign in to GitHub CLI with 'gh auth login'"