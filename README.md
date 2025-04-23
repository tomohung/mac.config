# Setup 2024 Maccbook M4 Mini

## Initial

1. extract `.ssh` to `~`

2. clone mac.config (This repo)
```
git clone git@github.com:tomohung/mac.config.git
```
### install homebrew
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```
brew bundle
```

## config for diff-so-fancy
https://github.com/so-fancy/diff-so-fancy
```
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
```

## Antigen for ZSH
```
ln -s ~/mac.config/zshrc ~/.zshrc
```
make sure iTerm is using zsh, then close iTerm and open again will automatical update

## vim config is built from scratch!
vim plugin manager switch to vim-plug, it's much simpler.

Install
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Neovim
```
mkdir ~/.config/nvim
ln -s ~/mac.config/vimrc ~/.config/nvim/init.vim
```

2. open nvim
3. `:PlugInstall` # not necessary for first time

## Tmux
#### Tmux Plugin Manager
Install
```
if [ ! -d ~/.tmux/plugins ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
```
Run
```
ln -s ~/mac.config/tmux.conf ~/.tmux.conf
```
open tmux > `prefix + I` -> install plugin

#### Auto start tmux in iTerm2
Navigate to "Preferences > Profiles > PROFILE > Command > Send text at start" and set it to:
```
tmux attach -t tomo || tmux new -s tomo zsh
```

#### Enable copy at iTerm2
To enable this:
1. Go into iTerm2's preferences.
2. Go to the "General" > "Selection" tab.
3. Check "Applications in terminal may access clipboard"

#### Import Color
Appearnace > Colors > Color Presets > Import

Pick the color file from this repo.

#### fzf

Enable key bindings
```
$(brew --prefix)/opt/fzf/install
```
#### asdf

run
```
asdf plugin add ruby
asdf install ruby latest
```

#### tig
```
ln -s ~/mac.config/tigrc ~/.tigrc
```
