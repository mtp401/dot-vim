" vint: -ProhibitSetNoCompatible
set nocompatible
set showmatch
set autoindent

if !has('nvim')
set esckeys
endif

set expandtab
set tabstop=8
set shiftwidth=4
set splitbelow
set splitright
set softtabstop=4
set tw=79
set fo+=t
set number
set ruler
set hlsearch
set bs=2
set t_Co=256
set clipboard^=unnamed,unnamedplus
set undofile
set undodir=~/.vim/undodir
set mouse=

" LanguageClient/ALE
set hidden

set listchars=trail:-,nbsp:+,eol:$,tab:>-

syntax on

" Turn off line number underlining
:hi LineNr NONE

" Toggle folding with f9
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" Remap O and o (Insert newline before and newline after) so that
" vim isn't left in insert mode after execution
nnoremap O O<esc>
nnoremap o o<esc>

augroup VimrcColors
au!
    autocmd ColorScheme * highlight OverLength ctermbg=red ctermfg=white
        \ guibg=#592929
    autocmd ColorScheme * highlight TrailingWhitespace ctermbg=red guibg=#592929
    autocmd ColorScheme * highlight Tabs ctermbg=green
augroup end

colorscheme pellands

function! HighlightWSErrors(hl_on)
    if a:hl_on
        let t:hl_ws_er_ol=matchadd('OverLength', '\%>80v.\+')
        let t:hl_ws_er_trlws=matchadd('TrailingWhitespace', '\s\+$')
        let t:hl_ws_er_tbs=matchadd('Tabs', '\t')
    else
        if exists('t:hl_ws_er_ol')
            call matchdelete(t:hl_ws_er_ol)
        endif

        if exists('t:hl_ws_er_trlws')
            call matchdelete(t:hl_ws_er_trlws)
        endif

        if exists('t:hl_ws_er_tbs')
            call matchdelete(t:hl_ws_er_tbs)
        endif
    endif
endfunction

function! ToggleHighlightWSErrors()
    let t:highlight_ws_errors = exists('t:highlight_ws_errors') ?
                              \ !t:highlight_ws_errors :
                              \ 1

    call HighlightWSErrors(t:highlight_ws_errors)
endfunction

if has('cscope')
    cnoreabbrev <expr> csa
        \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs add'  : 'csa')
    cnoreabbrev <expr> csf
        \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs find' : 'csf')
    cnoreabbrev <expr> csk
        \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs kill' : 'csk')
    cnoreabbrev <expr> csr
        \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs reset' : 'csr')
    cnoreabbrev <expr> css
        \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs show' : 'css')
    cnoreabbrev <expr> csh
        \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs help' : 'csh')
endif

filetype plugin on

" Make gq wrap long blocks in Latex
map \gq ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>gq//-1<CR>
omap lp ?^$\\|^\s*\(\\begin\\|\\end\\|\\label\)?1<CR>//-1<CR>.<CR>

let g:vimpager_scrolloff = 0

" Use real tabs in makefiles and kconfig
autocmd FileType make setlocal noexpandtab sw=4 ts=4 sts=4
autocmd FileType kconfig setlocal noexpandtab sw=4 ts=4 sts=4

" Recognize `Config.in`s kconfig
au! BufNewFile,BufRead Config.in setf kconfig

" Automatically pick up rusty-tags
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/

set statusline+=%#warningmsg#
set statusline+=%*

" Use host python when in virtualenvs
let g:python_host_prog = '/usr/bin/python'

" Fix airline statuses
set laststatus=2

" Use powerlineish theme with powerline hacked fonts
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'

" Enable Airline integration with fugitive
let g:airline#extensions#branch#enabled = 1

" change the text for when no branch is detected
let g:airline#extensions#branch#empty_message = ''

" truncate long branch names to a fixed length
let g:airline#extensions#branch#displayed_head_limit = 10

" Enable Airline integration with ALE
let g:airline#extensions#ale#enabled = 1

" vim-polyglot uses tpope/vim-markdown, plasticboy is better
let g:polyglot_disabled = ['markdown']

" Stop vim-markdown from autofolding markdown on every write
let g:vim_markdown_folding_disabled = 1

inoremap <F7> :call ToggleHighlightWSErrors()<CR>
nnoremap <F7> :call ToggleHighlightWSErrors()<CR>
vnoremap <F7> :call ToggleHighlightWSErrors()<CR>

" scratch buffers
" http://dhruvasagar.com/2014/03/11/creating-custom-scratch-buffers-in-vim
function! ScratchEdit(cmd, options)
    exe a:cmd tempname()
    setl buftype=nofile bufhidden=wipe nobuflisted
    if !empty(a:options) | exe 'setl' a:options | endif
endfunction

" Open a scratch buffer in a split
command! -bar -nargs=* Ssp call ScratchEdit('split', <q-args>)
command! -bar -nargs=* Svsp call ScratchEdit('vsplit', <q-args>)

function! SetLKStyle()
    setlocal ts=8 sts=8 sw=8 noexpandtab
endfunction

command! SetLKStyle call SetLKStyle()

" neovim stuff
if has('nvim')
    " remap terminal buffer escape to escape key
    tnoremap <Esc> <C-\><C-n>

    " make some mappings to make moving around terminal buffers easier
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l

    " true color support
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" if exists('+termguicolors')
"   let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif

" cpp:
"   cpplint: `pip install --user cpplint`
" gitcommit:
"   gitlint: `pip install --user gitlint`
" markdown:
"   mdl: `gem install mdl`
" sh:
"   shellcheck: `cabal update; cabal install ShellCheck`
" rust:
"   rls: `rustup component add rls`
" yaml:
"   yamllint: `pip install --user yamllint`
let g:ale_linters = {
\   'cpp': ['cpplint'],
\   'gitcommit': ['gitlint'],
\   'markdown': ['mdl'],
\   'sh': ['shellcheck'],
\   'rust': ['rls'],
\   'yaml': ['yamllint'],
\}

let g:ale_fixers = {
\   'rust': ['rustfmt']
\}

let g:ale_rust_rls_toolchain='stable'
let g:ale_linters_explicit=1

call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-fugitive'

Plug 'godlygeek/tabular'

" Syntax Plugins
Plug 'plasticboy/vim-markdown'
Plug 'mtp401/vim-cpp-enhanced-highlight', { 'branch': 'mpelland/custom' }
Plug 'mesonbuild/meson', { 'rtp': 'data/syntax-highlighting/vim', 'for': 'meson' }
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'wgwoods/vim-systemd-syntax'
Plug 'rust-lang/rust.vim'
Plug 'vim-python/python-syntax'
Plug 'uarun/vim-protobuf'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'vim-scripts/groovy.vim'
Plug 'tpope/vim-git'
Plug 'docker/docker', { 'rtp': 'contrib/syntax/vim' }
Plug 'Glench/Vim-Jinja2-Syntax'

call plug#end()

" Some of the syntax files above reset the default indentation to 2 spaces
autocmd FileType yaml setlocal sw=4 ts=4 sts=4
autocmd FileType meson setlocal sw=4 ts=4 sts=4
autocmd FileType proto setlocal sw=4 ts=4 sts=4
