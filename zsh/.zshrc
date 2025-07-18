# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Source/Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/base.toml)"
fi

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space # If we want a command to not be included in the history, simple prepend a space
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Aliases
alias ls='ls --color'

# Shell integrations
eval "$(fzf --zsh)"

export PATH="$HOME/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:$(go env GOPATH)/bin
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

if [ -f "$HOME/.local/share/dnvm/env" ]; then
    . "$HOME/.local/share/dnvm/env"
fi

find_bytes() {
  fzf --ansi \
      --disabled \
      --query "" \
      --prompt "Select an occurrence: " \
      --delimiter : \
      --bind "change:reload:rg --fixed-strings --no-heading --line-number --color=always {q} . 2>/dev/null || true" \
      --preview '[[ -n {1} && -n {2} ]] && bat --style=numbers --color=always --highlight-line {2} {1} || echo "I would tell a chemistry joke, but I might not get a reaction..."' \
      --preview-window=right:60%:wrap \
      --bind 'enter:execute(nvim +{2} {1})'
}

# Function to fuzzy-find file within the ~/repos directory and open a new tmux session and nvim session
find_file() {
  local file=$(find $1 -type f | fzf --preview='bat --color=always {}')
  
  # If no file is selected, return
  [[ -z $file ]] && return

  nvim "$file"
}

# Function to fuzzy-find a repository and open a new tmux session and nvim sesion
find_repo() {
  # Use fzf to select a repository from the base directory
  local repo=$(find "$1" -type d -name ".git" -prune -exec dirname {} \; | fzf --prompt="Select a repository: " --preview="tree -L 2 {}")

  # If no repository is selected, return
  [[ -z $repo ]] && return

  # Extract the repository name from the selected path
  local repo_name=$(basename "$repo")

  # Check if a tmux session with the same name already exists
  if tmux has-session -t "$repo_name" 2>/dev/null; then
    echo "Tmux session '$repo_name' already exists. Switching..."
  else
    # Create a new tmux session in the selected repository
    echo "Creating new tmux session: $repo_name"
    tmux new-session -d -s "$repo_name" -c "$repo"
    
    # Open nvim in the new tmux session
    tmux send-keys -t "$repo_name" "nvim" C-m
  fi

  # Check if already inside a tmux session
  if [[ -n $TMUX ]]; then
    # Switch to the new session
    tmux switch-client -t "$repo_name"
  else
    # Attach to the new session
    tmux attach-session -t "$repo_name"
  fi
}

stty -ixon
bindkey -s '^br' 'find_repo ~/repos\n'
bindkey -s '^qr' 'find_file ~/repos\n'
bindkey -s '^xr' 'find_bytes ~/repos\n'

bindkey -s '^bh' 'find_repo ~\n'
bindkey -s '^qh' 'find_file ~\n'
bindkey -s '^xh' 'find_bytes ~\n'

alias f='ffmpeg'
