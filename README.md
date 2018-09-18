# Setup my new mac for 2018

## Initial
### Run script from Thoughtbot
https://github.com/thoughtbot/laptop
1. curl --remote-name https://raw.githubusercontent.com/thoughtbot/laptop/master/mac
### custom installation
2. ln -s ~/mac.config/laptop.local ~/.laptop.local
### Update Mac
3. sh mac 2>&1 | tee ~/laptop.log

## config for diff-so-fancy
https://github.com/so-fancy/diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"

## Antigen for ZSH
1. $ ln -s ~/mac.config/zshrc ~/.zshrc
make sure iTerm is using zsh, then close iTerm and open again will automatical update

## vim config is built from scratch!
vim plugin manager switch to vim-plug, it's much simpler.

1. $ ln -s ~/mac.config/vimrc ~/.vimrc

or neovim
   $ ln -s ~/mac.config/vimrc ~/.config/nvim/init.vim

2. open vim
3. `:PlugInstall` # not necessary for first time

## Tmux
#### Tmux Plugin Manager
0. ln -s ~/mac.config/tmux.conf ~/.tmux.conf
1. open tmux
2. `prefix + I` -> install plugin

#### Auto start tmux in iTerm2
Navigate to "Preferences > Profiles > PROFILE > Command > Send text at start" and set it to:
```
tmux ls && read tmux_session && tmux attach -t ${tmux_session:-default} || tmux new -s ${tmux_session:-default}
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
