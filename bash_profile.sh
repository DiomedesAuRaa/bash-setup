# ====== Aliases & Functions ======

# ls improvements
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls='ls --color=auto'
alias sl='ls'

# python
alias python='python3'

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# safer file operations
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# utilities
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -m'

# history search with arrows
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# ====== Git ======
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gca='git commit -a'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'
alias gcam='git commit -m'

# ====== Kubernetes ======
alias k='kubectl'
alias kx='kubectx'
alias kns='kubens'
alias kga='kubectl get all'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kd='kubectl describe'
alias kdel='kubectl delete'
alias klo='kubectl logs -f'

# ====== Terraform ======
alias tf='terraform'
alias tfinit='terraform init --upgrade'
alias tfplan='terraform plan'
alias tfapply='terraform apply -auto-approve'
alias tfdestroy='terraform destroy -auto-approve'

# ====== Docker ======
alias d='docker'
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dexec='docker exec -it'

# ====== Handy Stuff ======
alias reload='source ~/.bashrc'
alias venv='source venv/bin/activate'
alias myip='curl -s ifconfig.me'

# timestamped history
export HISTTIMEFORMAT="%F %T "

# ====== pyenv setup ======
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
