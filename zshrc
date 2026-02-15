# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $(brew --prefix)/opt/antigen/share/antigen/antigen.zsh

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
antigen theme romkatv/powerlevel10k

# theme for pure, can't use antigen theme command directly
# antigen bundle mafredri/zsh-async
# antigen bundle sindresorhus/pure

# Tell antigen that you're done
antigen apply

export PATH="$HOME/.bin:$PATH"

# avoid warnings https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/10
export LC_ALL=en_US.UTF-8

# recommended by brew doctor
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# put local secret here
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -U -g ""'

export EDITOR='nvim'

# Alias

alias vi="nvim"
alias gfgrbi='gf && grbi'
alias mp3='yt-dlp -x --audio-format mp3 --postprocessor-args "ffmpeg:-ar 16000 -ac 1 -b:a 64k"'
# git fetch and reset to origin branch
gfgro() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git fetch && git reset --hard origin/"${b:=$1}"
}

gDelete() {
  git checkout develop
  git branch | grep -v "develop" | grep -v "master" | xargs git branch -D
  git prune
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

