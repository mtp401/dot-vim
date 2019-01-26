# Matt's (neo)vim Setup

## Installation

1. `git clone <dot-vim> ~/.vim`
2. `cd ~/.vim`
3. `ln -s ~/.vim/.vimrc ~/.vimrc`

For `neovim`:
4. `ln -s ~/.vim ~/.config/nvim`

## Overview

I use [Chris Simpkins' _Hack_](https://github.com/chrissimpkins/Hack) font on a
black background with darkish grey text. If you don't want to go through the
effort of installing a custom font, I at least recommend using a monospaced
font. Bitstream Vera Mono is a great choice and is present on most systems by
default.

I use [vim-plug](https://github.com/junegunn/vim-plug) to manage the following
plugins, which I've found to be the right combination of helpfulness without
trying to make vim into an IDE:

- [ALE](https://github.com/w0rp/ale)
- [vim-airline](https://github.com/vim-airline/vim-airline)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [vim-markdown](https://github.com/plasticboy/vim-markdown)

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
