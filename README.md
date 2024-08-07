# Matt's neovim Setup

## Installation

1. `git clone <dot-vim> ~/.config/nvim`
2. Open neovim and run `:PaqInstall` to install plugins.
3. Run `:TSInstall <languages>` to install treesitter parsers for the languages
   you care about. See `:TSModuleInfo` for the list of supported languages.
    - **NOTE**: You may need to install the tree-sitter binary to install
      languages based on upstream grammar files. See
      [the tree-sitter release page](https://github.com/tree-sitter/tree-sitter/releases)

## Overview

I use [Chris Simpkins' _Hack_](https://github.com/chrissimpkins/Hack) font on a
black background with darkish grey text. If you don't want to go through the
effort of installing a custom font, I at least recommend using a monospaced
font. Bitstream Vera Mono is a great choice and is present on most systems by
default. For a lualine compatible version, see the version of Hack on
[Nerd Fonts](https://www.nerdfonts.com).

I use [paq](https://github.com/savq/paq-nvim) to manage plugins, so
`:PaqUpdate` can be used to keep the plugins configured in `init.lua`
