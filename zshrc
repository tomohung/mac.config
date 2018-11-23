source /usr/local/Cellar/antigen/2.2.3/share/antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle git
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle paulirish/git-open

# Load the theme
# antigen theme ys

# theme for pure, can't use antigen theme command directly
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Tell antigen that you're done
antigen apply

export PATH="$HOME/.bin:$PATH"

# recommended by brew doctor
# export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
source ~/.asdf/asdf.sh

# Alias

# git fetch and reset to origin branch
gfgro() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git fetch && git reset --hard origin/"${b:=$1}"
}

alias gfgrbi='gf && grbi'

deploy() {
  echo "deploy: $(git_current_branch) -> origin/deploy/$1"
  git push origin "$(git_current_branch):deploy/$1"
}
fdeploy() {
  echo "deploy: $(git_current_branch) -> origin/deploy/$1"
  git push -f origin "$(git_current_branch):deploy/$1"
}

# put local secret here
source ~/.local.zshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -U -g ""'
