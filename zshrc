# Plugins via antidote, bundle list lives next to this file (zshrc is symlinked)
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load ${${(%):-%x}:A:h}/zsh_plugins.txt ${XDG_CACHE_HOME:-$HOME/.cache}/zsh_plugins.zsh

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

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'

export EDITOR='nvim'

command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

export CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY=1

# Alias

alias vi="nvim"
alias gfgrbi='gf && grbi'
alias mp3='yt-dlp -x --audio-format mp3 --postprocessor-args "ffmpeg:-ar 16000 -ac 1 -b:a 64k"'
alias video='yt-dlp -f "bestvideo[height<=1080]+bestaudio[abr<=64]/best[height<=1080]"'
alias cc=claude
alias ccd='claude --dangerously-skip-permissions'
alias lg=lazygit

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

# Prompt
command -v starship >/dev/null && eval "$(starship init zsh)"

