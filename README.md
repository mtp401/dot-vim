# Matt's (neo)vim Setup

## Installation

1. `git clone <dot-vim> ~/.vim`
3. `cd ~/.vim`
4. `git submodule update --init`
5. `ln -s ~/.vim/.vimrc ~/.vimrc`

For `neovim`:
6. `ln -s ~/.vim ~/.config/nvim`

You'll also need to install and configure the various linters for Syntastic,
see [.vimrc](/.vimrc) for the short list with the right commands to install
each (on Debian based Linuxes at least).

## Overview

I use this setup to program/get stuff done in gterm in combination with a
custom compiled Vim 7.4. My Vim is compiled with the following config, some of
which you may need in order for my .vim to work correctly as is:

```
mtpelland@padron:~/.vim$ vim --version
VIM - Vi IMproved 7.4 (2013 Aug 10, compiled Nov  2 2015 15:09:30)
Included patches: 1-908
Compiled by mtpelland@padron
Huge version without GUI.  Features included (+) or not (-):
+acl             +farsi           +mouse_netterm   +syntax
+arabic          +file_in_path    +mouse_sgr       +tag_binary
+autocmd         +find_in_path    -mouse_sysmouse  +tag_old_static
-balloon_eval    +float           +mouse_urxvt     -tag_any_white
-browse          +folding         +mouse_xterm     -tcl
++builtin_terms  -footer          +multi_byte      +terminfo
+byte_offset     +fork()          +multi_lang      +termresponse
+cindent         +gettext         -mzscheme        +textobjects
+clientserver    -hangul_input    +netbeans_intg   +title
+clipboard       +iconv           +path_extra      -toolbar
+cmdline_compl   +insert_expand   -perl            +user_commands
+cmdline_hist    +jumplist        +persistent_undo +vertsplit
+cmdline_info    +keymap          +postscript      +virtualedit
+comments        +langmap         +printer         +visual
+conceal         +libcall         +profile         +visualextra
+cryptv          +linebreak       +python          +viminfo
+cscope          +lispindent      -python3         +vreplace
+cursorbind      +listcmds        +quickfix        +wildignore
+cursorshape     +localmap        +reltime         +wildmenu
+dialog_con      -lua             +rightleft       +windows
+diff            +menu            -ruby            +writebackup
+digraphs        +mksession       +scrollbind      +X11
-dnd             +modify_fname    +signs           +xfontset
-ebcdic          +mouse           +smartindent     -xim
+emacs_tags      -mouseshape      -sniff           +xsmp_interact
+eval            +mouse_dec       +startuptime     +xterm_clipboard
+ex_extra        -mouse_gpm       +statusline      -xterm_save
+extra_search    -mouse_jsbterm   -sun_workshop    +xpm
   system vimrc file: "$VIM/vimrc"
     user vimrc file: "$HOME/.vimrc"
 2nd user vimrc file: "~/.vim/vimrc"
      user exrc file: "$HOME/.exrc"
  fall-back for $VIM: "/usr/local/share/vim"
Compilation: gcc -c -I. -Iproto -DHAVE_CONFIG_H     -g -O2 -U_FORTIFY_SOURCE
-D_FORTIFY_SOURCE=1
Linking: gcc   -L/usr/local/lib -Wl,--as-needed -o vim
-lSM -lICE -lXpm -lXt -lX11 -lXdmcp -lSM -lICE  -lm -ltinfo -lnsl   -ldl
-L/usr/lib/python2.7/config-x86_64-linux-gnu -lpython2.7 -lpthread -ldl -lutil
-lm -Xlinker -export-dynamic -Wl,-O1 -Wl,-Bsymbolic-functions
```

I use [Chris Simpkins' _Hack_](https://github.com/chrissimpkins/Hack) font on a
black background with darkish grey text. If you don't want to go through the
effort of installing a custom font, I at least recommend using a monospaced
font. Bitstream Vera Mono is a great choice and is present on most systems by
default.

I use [Pathogen](https://github.com/tpope/vim-pathogen) to manage the following
plugins, which I've found to be the right combination of helpfulness without
trying to make vim into an IDE:

- [Syntastic](https://github.com/scrooloose/syntastic)
- [vim-airline](https://github.com/vim-airline/vim-airline)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [vim-polyglot](https://github.com/sheerun/vim-polyglot)
- [vim-markdown](https://github.com/plasticboy/vim-markdown)

### Neovim

I recently started using [Neovim](https://github.com/neovim/neovim) part time
because terminal buffers are amazing. My `.vim` is shareable between both `vim`
and `neovim` so everything above still applies.

## Probably not so helpful notes

- `expandtab` is on, which replaces hard tabs with spaces, because [tabs are
  evil](https://www.emacswiki.org/emacs/TabsAreEvil).
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
- Syntastic is off by default. Some rickety code I wrote in `.vimrc` turns it on
  automatically if it finds a file named `.enable_syntastic` in your current
  directory or any of it's ancestors (all the way to `/`).
