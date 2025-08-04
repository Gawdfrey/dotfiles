# Dotfiles

Personal macOS setup and configuration files.

## Quick Setup

```bash
git clone https://github.com/Gawdfrey/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## What's Included

### Shell Configuration
- **Zsh** with Oh My Zsh
- **Custom aliases** for git, npm, kubernetes
- **Starship prompt** with kubernetes context
- **Environment setup** for Node.js, Go, Python

### Development Tools
- **Git configuration** with custom aliases and 1Password SSH signing
- **VS Code extensions** (TypeScript, Tailwind, Prettier, Biome, etc.)
- **Node.js 22 LTS** as default version
- **Global npm packages** (@antfu/ni, corepack)

### Applications & Tools
- Complete **Brewfile** with development tools
- **Kubernetes tools** (kubectl, k9s, helm, etc.)
- **Cloud tools** (Azure CLI, Vercel CLI)
- **Essential apps** (1Password CLI, Bruno, Raycast, Warp)

## Manual Steps

After running the installer:

1. **1Password**: Sign in and configure SSH agent
2. **GitHub**: `gh auth login`
3. **Terminal**: Restart or `source ~/.zshrc`

## Files

- `.zshrc` - Zsh configuration with Oh My Zsh
- `.gitconfig` - Git aliases and 1Password SSH signing
- `.ssh/config` - SSH configuration for 1Password agent
- `Brewfile` - Homebrew packages and applications
- `vscode-extensions.txt` - VS Code extensions list
- `global-npm-packages.txt` - Global npm packages
- `.nvmrc` - Node.js version (22 LTS)