# Setup 2022 Maccbook M1 Pro

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

Copy config
```
ln -s ~/mac.config/vimrc ~/.vimrc
```

or neovim
```
mkdir ~/.config/nvim
ln -s ~/mac.config/vimrc ~/.config/nvim/init.vim
```

2. open vim
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
use Tmuxp template

```
ln -s ~/mac.config/tmuxp ~/.config/tmuxp
```

Navigate to "Preferences > Profiles > PROFILE > Command > Send text at start" and set it to:
```
tmuxp load easyship
```

#### Enable copy at iTerm2
If you have tmux 1.5 or newer and are using iTerm2 version 3 or newer then the y in copy-mode and mouse selection will work without tmux-yank.

To enable this:
1. Go into iTerm2's preferences.
2. Go to the "General" tab.
3. Check "Applications in terminal may access clipboard"

#### fzf

Enable key bindings
```
$(brew --prefix)/opt/fzf/install
```
#### asdf

```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
```

run
```
asdf plugin add ruby
asdf install ruby 2.6.6
```

For vim tags
```
gem install ripper-tags
```

#### RubyMine
```
ln -s ~/mac.config/ideavimrc ~/.ideavimrc
```

#### tig
```
ln -s ~/mac.config/tigrc ~/.tigrc
```
