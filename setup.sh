#!/usr/bin/env bash
set -euo pipefail

# ====== Colors ======
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${YELLOW}==> Checking for Homebrew...${RESET}"

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
  echo -e "${YELLOW}==> Installing Homebrew...${RESET}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo -e "${GREEN}==> Homebrew already installed${RESET}"
fi

echo -e "${YELLOW}==> Updating Homebrew...${RESET}"
brew update

# ====== Core Packages ======
CORE_PACKAGES=(
  kubectl
  terraform
  docker
  python
  go
  kubectx
  kubens
  git
  jq
)

# ====== Extended DevOps Toolkit ======
DEVOPS_PACKAGES=(
  # Cloud CLIs
  awscli
  azure-cli
  google-cloud-sdk

  # Kubernetes
  helm
  k9s
  stern
  kustomize

  # HashiCorp / IaC
  packer

  # System / Debugging
  htop
  iftop
  mtr
  nmap
  watch
  tree

  # Text / Data Tools
  yq
  bat
  fzf
  ripgrep
  fd

  # Productivity / Misc
  tmux
  direnv
  exa
  gh
  age
  sops
)

# ====== Cask Apps (GUI) ======
CASKS=(
  docker
)

# ====== Install Core Packages ======
echo -e "${YELLOW}==> Installing core packages...${RESET}"
for pkg in "${CORE_PACKAGES[@]}"; do
  echo -e "${YELLOW}Installing $pkg...${RESET}"
  brew install "$pkg" || true
done

# ====== Install DevOps Toolkit ======
echo -e "${YELLOW}==> Installing DevOps toolkit...${RESET}"
for pkg in "${DEVOPS_PACKAGES[@]}"; do
  echo -e "${YELLOW}Installing $pkg...${RESET}"
  brew install "$pkg" || true
done

# ====== Install Casks ======
echo -e "${YELLOW}==> Installing cask apps...${RESET}"
for cask in "${CASKS[@]}"; do
  echo -e "${YELLOW}Installing $cask...${RESET}"
  brew install --cask "$cask" || true
done

# ====== Setup Bash Profile ======
BASHRC="$HOME/.bashrc"

echo -e "${YELLOW}==> Adding aliases and configs to $BASHRC ...${RESET}"
cat >> "$BASHRC" <<'EOF'

# ====== DevOps/SRE Aliases & Functions ======

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
EOF

# Ensure .bash_profile sources .bashrc
if ! grep -q 'source ~/.bashrc' "$HOME/.bash_profile" 2>/dev/null; then
  echo 'source ~/.bashrc' >> "$HOME/.bash_profile"
fi

echo -e "${GREEN}==> Setup complete! Run 'source ~/.bashrc' or restart your terminal.${RESET}"
