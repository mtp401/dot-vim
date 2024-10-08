# Matt's neovim Setup

## Installation

1. Install [luarocks](https://luarocks.org)
2. `git clone <dot-vim> ~/.config/nvim`
3. Install [neovim](https://neovim.io), at least version 0.10.0.
4. Run `nvim` then `:checkhealth` to ensure things installed successfully
5. See additional things to potentially install in the following sections:
    - [Lualine](#lualine)
    - [Telescope](#telescope)
    - [Linters](#linters)

### Migrating from Paq

Previously, I used to use [Paq](https://github.com/savq/paq-nvim) to manage my
neovim plugins. If you are updating from one of my configurations that is using
Paq you will need to delete Paq so it doesn't interfere with LazyVim. LazyVim
will flag this in the output of `:checkhealth` along with the path Paq is being
loaded from if you've forgotten where it's installed.

## Overview

I use [Chris Simpkins' _Hack_](https://github.com/chrissimpkins/Hack) font on a
black background with darkish grey text. If you don't want to go through the
effort of installing a custom font, I at least recommend using a monospaced
font. Bitstream Vera Mono is a great choice and is present on most systems by
default.

## Lualine

[Lualine](https://github.com/nvim-lualine/lualine.nvim) is used to provide
extra statusline features. You'll need a suitable "nerd font" from [Nerd
Fonts](https://www.nerdfonts.com) installed for the various symbols to display
correctly.

### Telescope

[LazyVim](http://www.lazyvim.org) is setup to lazy load
[Telescope](https://github.com/nvim-telescope/telescope.nvim) on demand when
using the `Telescope` command.

You will need to optionally install
[ripgrep](https://github.com/BurntSushi/ripgrep) and
[fd](https://github.com/sharkdp/fd) to use the `live_grep` and `find_files`
commands.

### Linters

There are several linters configured out of the box via
[nvim-lint](https://github.com/mfussenegger/nvim-lint) that you will need to
install the actual linting programs for. See
[nvim-lint.lua](lua/plugins/nvim-lint.lua) for the list along with the commands
commonly used to install them.

### LSP Configuration

LSP configuration is provided by
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) and is setup by
default to look for an LSP when editing C, C++, or Rust. You will need to
install [clangd](https://clangd.llvm.org) and
[rust-analyzer](https://rust-analyzer.github.io).

### Colorizer

[nvim-colorizer](https://github.com/norcalli/nvim-colorizer.lua) is setup to be
lazy loaded via the `ColorizerAttachToBuffer` command.

### Syntax Highlighting

Most highlighting is done via
[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter).
Treesitter modules are automatically kept to date by LazyVim. There are two
additional plugins to provide highlighting for `Jenkinfile`s and `jinja2`
templates:

- [Jenkinsfile-vim-syntax](https://github.com/martinda/Jenkinsfile-vim-syntax)
- [vim-jinja2-syntax](https://github.com/glench/vim-jinja2-syntax)
