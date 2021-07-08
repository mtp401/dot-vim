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

## Probably not so helpful notes

- `expandtab` is on, which replaces hard tabs with spaces, because
  [tabs are evil](https://www.emacswiki.org/emacs/TabsAreEvil).
- Similarly, `tw` is set to 79 and `fo` will automatically wrap in insert mode
- clipboard is setup to use the `+` register. Use it, you will love it. I
  promise.
- `F9` is setup to toggle folding where available
- `O` and `o` are remapped. They do the same thing as normally except they
  don't leave you in insert mode.
- `gq` is setup to autowrap blocks at 79 characters. For best results, use
  visual mode to highlight all of someone else's long lines and then hit `gq`
  to win.
- There's a handy `ToggleHighlightWSErrors` function that you can call that
  will highlight tabs in this offensive green color and long lines in blinding
  red. Use judiciously to banish tabs.
  - it also highlights trailing whitespace
  - `call ToggleHighlightWSErrors()` to use from normal mode
- There's some extra stuff here to support
  [vimpager](https://github.com/rkitover/vimpager)
  - Use vimpager, it's much better than the alternatives and allows you to
    regex search your paged content.
- When editing markdown, you can use `:TableFormat` to automatically line up
  and center tables (brought to you by
  [tabular](https://github.com/godlygeek/tabular) and
  [vim-markdown](https://github.com/plasticboy/vim-markdown))
