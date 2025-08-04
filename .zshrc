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
source ~/az.completion
source <(kubectl completion zsh)

eval "$(op completion zsh)"; compdef _op op
eval "$(github-copilot-cli alias -- "$0")"

# Go
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"

# Lazy load NVM for faster shell startup
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}

# Auto-use .nvmrc when changing directories
autoload -U add-zsh-hook
load-nvmrc() {
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
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# NOTE: Replace with your actual NPM token or use environment variable
# export NPM_TOKEN="your_token_here"

eval "$(starship init zsh)"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

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