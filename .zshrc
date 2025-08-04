# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
        git
        kube-ps1
        vscode
        kubectl
        z
)

source $ZSH/oh-my-zsh.sh
PROMPT='$(kube_ps1)'$PROMPT

# Better completion settings
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:warnings' format 'No matches found'

# User configuration
eval "$(direnv hook zsh)"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias zshconfig="code ~/.zshrc"
alias og="git open"
alias gs="git status"
alias gp="git push"
alias gpl="git pull"
alias gm="git merge"
alias gc="git commit"
alias gcm="git commit -m"
alias npr="nr dev"
alias i="ni"
alias ns="nr start"
alias mp="make push"
alias ktx="kubectx"
alias kns="kubens"
alias slf="stacc logs flow-process"
alias sla="stacc logs api-gateway"
alias sl="stacc logs"
alias gpr="git pull --rebase --autostash"

cursor() {
    if [ $# -eq 0 ]; then
        /Applications/Cursor.app/Contents/MacOS/Cursor .
    else
        /Applications/Cursor.app/Contents/MacOS/Cursor "$1"
    fi
}

. $(brew --prefix)/etc/profile.d/z.sh

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

export EDITOR='code --wait'

autoload -U +X bashcompinit && bashcompinit

# Lazy load completions for faster startup
_lazy_load_completions() {
    # Only load if not already loaded
    if [[ -z "$_COMPLETIONS_LOADED" ]]; then
        export _COMPLETIONS_LOADED=1
        
        # Azure CLI completion
        if [[ -f ~/az.completion ]]; then
            source ~/az.completion
        fi
        
        # Kubernetes completions
        if command -v kubectl &> /dev/null; then
            source <(kubectl completion zsh)
        fi
        
        # kubectx and kubens completions
        local brew_prefix="${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null)}"
        if [[ -n "$brew_prefix" ]]; then
            [[ -f "$brew_prefix/opt/kubectx/etc/bash_completion.d/kubectx" ]] && source "$brew_prefix/opt/kubectx/etc/bash_completion.d/kubectx"
            [[ -f "$brew_prefix/opt/kubectx/etc/bash_completion.d/kubens" ]] && source "$brew_prefix/opt/kubectx/etc/bash_completion.d/kubens"
        fi
        
        # Helm completion
        if command -v helm &> /dev/null; then
            source <(helm completion zsh)
        fi
        
        # 1Password completion
        if command -v op &> /dev/null; then
            eval "$(op completion zsh)"; compdef _op op
        fi
    fi
}

# Lazy load completions on first tab completion
autoload -Uz compinit
compinit -C  # Skip security check for faster startup

# Hook to load completions on first tab press
_completion_loader() {
    unset -f _completion_loader
    _lazy_load_completions
    # Call original completion
    zle expand-or-complete
}
zle -N _completion_loader
bindkey '^I' _completion_loader

# Cache brew prefix for better performance
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"

# Lazy load GitHub Copilot CLI
_github_copilot_loader() {
    unset -f github-copilot-cli
    if command -v github-copilot-cli &> /dev/null; then
        eval "$(github-copilot-cli alias -- "$0")"
    fi
    github-copilot-cli "$@"
}
alias github-copilot-cli='_github_copilot_loader'

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# Lazy load NVM for faster shell startup
export NVM_DIR="$HOME/.nvm"
_load_nvm() {
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

nvm() {
    unset -f nvm
    _load_nvm
    nvm "$@"
}

# Auto-use .nvmrc when changing directories
autoload -U add-zsh-hook
load-nvmrc() {
    # Only run if nvm is available and we haven't loaded it yet
    if [[ -f "$NVM_DIR/nvm.sh" ]] && ! command -v nvm_find_nvmrc &> /dev/null; then
        _load_nvm
    fi
    
    # Now check for .nvmrc if nvm is loaded
    if command -v nvm_find_nvmrc &> /dev/null; then
        local node_version="$(nvm version)"
        local nvmrc_path="$(nvm_find_nvmrc)"
        
        if [ -n "$nvmrc_path" ]; then
            local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
            
            if [ "$nvmrc_node_version" = "N/A" ]; then
                nvm install
            elif [ "$nvmrc_node_version" != "$node_version" ]; then
                nvm use
            fi
        elif [ "$node_version" != "$(nvm version default)" ]; then
            echo "Reverting to nvm default version"
            nvm use default
        fi
    fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# NOTE: Replace with your actual NPM token or use environment variable
# export NPM_TOKEN="your_token_here"

# fzf integration for better completions (lazy loaded)
_load_fzf() {
    if command -v fzf &> /dev/null && [[ -z "$_FZF_LOADED" ]]; then
        export _FZF_LOADED=1
        source <(fzf --zsh)
        
        # fzf options
        export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --ansi"
        export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type directory --hidden --follow --exclude .git"
    fi
}

# Load fzf when first used
for cmd in fzf **; do
    eval "${cmd}() { _load_fzf; unset -f ${cmd}; ${cmd} \$@; }"
done

# Lazy load starship prompt
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi

. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

# Clean up old z database files periodically to prevent startup slowdown
_cleanup_z_files() {
    local z_count=$(ls ~/.z.* 2>/dev/null | wc -l)
    if [[ $z_count -gt 10 ]]; then
        # Keep only the 5 most recent z database files
        ls -t ~/.z.* 2>/dev/null | tail -n +6 | xargs rm -f 2>/dev/null
    fi
}

# Run cleanup occasionally (1 in 20 shells)
if [[ $((RANDOM % 20)) -eq 0 ]]; then
    _cleanup_z_files
fi

alias claude="$HOME/.claude/local/claude"

# Modern CLI tool aliases
alias ll="eza -la --git --header"
alias ls="eza --color=always --group-directories-first"
alias lt="eza --tree --level=2"
alias cat="bat --paging=never"
alias find="fd"
alias grep="rg"
alias preview="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# Productivity aliases
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias c="clear"
alias h="history | grep"
alias ports="netstat -tulanp"