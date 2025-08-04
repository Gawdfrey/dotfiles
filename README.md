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
- **Zsh** with Oh My Zsh and optimized startup (lazy-loaded NVM)
- **Modern CLI tools** with aliases (eza, bat, fzf, ripgrep, fd, tldr)
- **Starship prompt** with kubernetes context
- **Auto .nvmrc** detection when changing directories
- **Environment setup** for Node.js, Go, Python

### Development Tools
- **Git configuration** with delta diff viewer and 1Password SSH signing
- **Global .gitignore** for common unwanted files
- **EditorConfig** for consistent formatting across editors
- **VS Code settings** sync with optimized configuration
- **VS Code extensions** (TypeScript, Tailwind, Prettier, Biome, etc.)
- **Node.js 22 LTS** as default version
- **Global npm packages** (@antfu/ni, corepack)

### Applications & Tools
- Complete **Brewfile** with development tools and modern CLI utilities
- **Kubernetes tools** (kubectl, k9s, helm, etc.)
- **Cloud tools** (Azure CLI, Vercel CLI)  
- **Essential apps** (1Password CLI, Bruno, Raycast, Warp)

### Modern CLI Aliases
- `ll` → `eza -la --git --header` (better ls with git status)
- `cat` → `bat` (syntax highlighted cat)
- `find` → `fd` (faster find)
- `grep` → `rg` (ripgrep)
- `preview` → `fzf` with file preview

## Manual Steps

After running the installer:

1. **1Password**: Sign in and configure SSH agent
2. **GitHub**: `gh auth login`
3. **Terminal**: Restart or `source ~/.zshrc`

## Keeping Dotfiles Synced

### From System to Repository
When you make changes to your configs:
```bash
./sync-from-system.sh  # Pull latest configs from system
./push.sh              # Commit and push to GitHub
```

### From Repository to System
When you pull updates from GitHub:
```bash
git pull origin main
./sync-to-system.sh    # Apply changes to system
```

## Files

- `.zshrc` - Zsh configuration with Oh My Zsh and modern aliases
- `.gitconfig` - Git aliases, delta diff viewer, and 1Password SSH signing
- `.gitignore_global` - Global gitignore for common files
- `.editorconfig` - Consistent formatting across editors
- `.ssh/config` - SSH configuration for 1Password agent  
- `Brewfile` - Homebrew packages including modern CLI tools
- `vscode-extensions.txt` - VS Code extensions list
- `vscode-settings.json` - VS Code configuration
- `global-npm-packages.txt` - Global npm packages
- `.nvmrc` - Node.js version (22 LTS)
