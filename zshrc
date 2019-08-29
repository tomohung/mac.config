source /usr/local/Cellar/antigen/2.2.3/share/antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle git
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle paulirish/git-open
antigen bundle tmuxinator

# Load the theme
# antigen theme ys

# theme for pure, can't use antigen theme command directly
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Tell antigen that you're done
antigen apply

export PATH="$HOME/.bin:$PATH"

# avoid warnings https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/10
export LC_ALL=en_US.UTF-8

# recommended by brew doctor
# export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# put local secret here
source ~/.local.zshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -U -g ""'

export EDITOR='vim'

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

gmerge() {
  local b="$(git_current_branch)"
  echo "PR: $1 merge into the branch: ${b}"
  hub pr checkout $1 && \
  git rebase -i ${b} && \
  ggfl && \
  git checkout ${b} && \
  hub merge https://github.com/easyship/easyship-api/pull/$1 && \
  git push
}

# array=(1234 2345)
# bgmerge "${array[@]}"
bgmerge() {
  arr=("$@")
  echo "PRs: ${arr}"
	for i in "${arr[@]}"
	do
    gmerge $i || { echo 'merge failed' ; return; }
	done
}

