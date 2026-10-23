# Setup 2024 Maccbook M4 Mini

## SSH

Follow
https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

```
gh ssh-key add ~/.ssh/id_ed25519.pub --type authentication
```

## Initial

clone mac.config (This repo)
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

## Git pager (delta)
https://github.com/dandavison/delta
```
git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.navigate true
```

## Zsh (antidote + starship)
```
ln -s ~/mac.config/zshrc ~/.zshrc
```
Plugins are listed in `zsh_plugins.txt` and cloned by antidote on the first shell start.
The prompt is starship (default config, customize in `~/.config/starship.toml`).

## Neovim

Requires Neovim 0.12+ (nvim-treesitter `main` branch). `brew bundle` installs `neovim`, `tree-sitter-cli`, `ripgrep` and `fzf`.
Node (for JSON/YAML language servers) and Ruby come from asdf, see below.

1. Link the config
```
mkdir -p ~/.config/nvim
ln -s ~/mac.config/vimrc ~/.config/nvim/init.vim
```

2. Install plugins (vim-plug bootstraps itself on first launch; errors on the very first start are expected before plugins exist)
```
nvim --headless -c 'PlugInstall --sync' -c 'qa!'
```

3. Install treesitter parsers
```
nvim --headless -c "lua require('nvim-treesitter').install({'ruby','embedded_template','html','css','javascript','json','yaml','toml','markdown','markdown_inline','lua','vim','vimdoc','query','bash','sql','dockerfile','diff','gitcommit','git_config','regex','elixir'}):wait(600000)" -c 'qa!'
```

4. Install language servers / formatters (managed by mason, needs node)
```
nvim --headless -c 'MasonInstall json-lsp yaml-language-server marksman prettier' -c 'qa!'
```

5. Ruby LSP (per Ruby version installed by asdf)
```
gem install ruby-lsp
```
In Rails projects add `ruby-lsp-rails` (and `ruby-lsp-rspec`) to the Gemfile development group.
When the project Gemfile has `gem "standard"`, ruby-lsp lints/formats with StandardRB automatically.

6. Check everything: open nvim and run `:checkhealth`

Update later: `:PlugUpdate`, `:TSUpdate`, `:MasonUpdate`

### Key mappings (leader = Space)

| Key | Action |
| --- | --- |
| `<C-p>` / `<C-b>` / `<leader>fr` | files / buffers / recent files (fzf-lua) |
| `<leader>/` / `<leader>?` | live grep / grep word under cursor (or selection) |
| `<leader>fs` / `<leader>fS` | document / workspace symbols |
| `<leader>fd` / `<leader>fD` | diagnostics in file / workspace |
| `<leader>fc` / `<leader>fk` / `<leader>f.` | git status / keymaps / resume last picker |
| `gd` / `<C-]>` / `K` | go to definition / definition / hover doc |
| `grr` / `grn` / `gra` / `gri` | references / rename / code action / implementation |
| `[d` / `]d` / `gl` | prev / next diagnostic / show line diagnostic |
| `<leader>F` | format (ruby-lsp for Ruby, prettier for json/yaml/md) |
| `<C-space>` `<C-n>` `<C-p>` `<C-y>` `<C-e>` | completion: open / next / prev / accept / close |
| `s` / `S` / `r` (operator) | flash jump / treesitter select / remote action |
| `af` `if` / `ac` `ic` / `ar` `ir` / `aa` `ia` | function / class / block / argument text objects |
| `am` `im` / `aM` `iM` / `]m` `[m` | Ruby method / class text objects and motions (vim-ruby) |
| `]c` / `[c` | next / prev git hunk |
| `<leader>hs` `hr` `hp` `hb` / `ih` | stage / reset / preview hunk, blame line / hunk text object |
| `<leader>gs` `gd` `gb` `ga` `gc` `gp` `gl` | fugitive: status / diff / blame / add / commit / push / pull |
| `<leader>gh` | open line (or selection) on GitHub |
| `<leader>tn` `tf` `ts` `tl` `tv` | vim-test: nearest / file / suite / last / visit |
| `<leader>tt` | symbol outline (aerial) |
| `<leader>mv` / `<leader>mp` | toggle markdown render / browser preview |
| `<leader>bo` | close all buffers but the current one |
| `gc` / `gcc` | comment (built in) |
| `zc` `zo` `za` | fold / unfold (treesitter folds) |

## Other tools

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

## Ghostty

Install
```
brew install --cask ghostty
```

Setup config symlink
```
mkdir -p ~/.config/ghostty
ln -s ~/mac.config/ghostty.config ~/.config/ghostty/config
```

> **Note:** On macOS, `cmd+,` may open a default config file at `~/Library/Application Support/com.mitchellh.ghostty/config` instead of the symlinked one. Remove it if it exists:
> ```
> rm ~/Library/Application\ Support/com.mitchellh.ghostty/config
> ```
