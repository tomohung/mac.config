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
antigen theme ys

# Tell antigen that you're done
antigen apply

export PATH="$HOME/.bin:$PATH"

# recommended by brew doctor
# export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
source /Users/tomohung/.asdf/asdf.sh

# put local secret here
source /Users/tomohung/.secret_key
