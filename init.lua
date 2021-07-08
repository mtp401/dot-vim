-- security
vim.o.exrc = false  -- ignore ~/.exrc
vim.o.secure = true  -- disallow local rc exec

-- tab / whitespace control
vim.o.expandtab = true  -- expand hard tabs to spaces
vim.o.softtabstop=4  -- expand tabs to 4 spaces
vim.o.tabstop = 8  -- use 8 spaces for hard tabs

-- formatting options
vim.o.autoindent = true
vim.o.shiftwidth = 4
vim.o.shiftround = true
vim.o.textwidth = 79
vim.opt.formatoptions = vim.opt.formatoptions
    + 't'
    + 'c'
    + 'r'
    - 'o'
    + 'q'
    - 'a'
    + 'n'
    - '2'
    + 'j'

-- display settings
vim.o.number = true
vim.o.ruler = true
vim.o.hidden = true
vim.o.hlsearch = true
vim.opt.listchars = {
    trail = '-',
    nbsp = '+',
    eol = '$',
    tab = '>-'
}
vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.laststatus = 2

-- windows
vim.o.splitbelow = true
vim.o.splitright = true

-- editing
vim.o.mouse = ''
vim.o.showmatch = true
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.undofile = true
vim.o.undodir = vim.env.HOME .. '/.vim/undodir'
vim.o.backspace = 'indent,eol,start'
vim.api.nvim_set_keymap('n', 'O', 'O<esc>', {noremap = true})
vim.api.nvim_set_keymap('n', 'o', 'o<esc>', {noremap = true})

vim.g.loaded_ruby_provider = 0
vim.g.loaded_python_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- plugins
vim.cmd('packadd paq-nvim')
local paq = require('paq').paq

paq({'savq/paq-nvim', opt = true})

paq({'nvim-treesitter/nvim-treesitter'})
require('nvim-treesitter.configs').setup({
    highlight = {enable = true},
    incremental_selection = {enable = true},
    indent = {enable = true}
})

paq({'norcalli/nvim-colorizer.lua'})
require('colorizer').setup()

paq({'marko-cerovac/material.nvim'})
vim.g.material_custom_colors = require('custom-material-colors').colors
require('material').set()

paq({'kyazdani42/nvim-web-devicons', opt = true})
paq({'hoob3rt/lualine.nvim'})
require('lualine').setup({
    options = {theme = 'material'}
})

paq({'neovim/nvim-lspconfig'})
local lspconfig = require('lspconfig')
lspconfig.clangd.setup({})
lspconfig.rust_analyzer.setup({})

vim.g.ale_linters_explicit = 1
vim.g.ale_linters = {
    cpp = {'cpplint'},  -- `pip install --user cpplint`
    gitcommit = {'gitlint'},  -- `pip install --user gitlint`
    markdown = {'mdl'},  -- `gem install mdl`
    sh = {'shellcheck'},  -- `cabal update; cabal install ShellCheck`
    yaml = {'yamllint'}  -- `pip install --user yamllint`
}
paq({'w0rp/ale'})

paq({'tpope/vim-fugitive'})
paq({'godlygeek/tabular'})
paq({'martinda/Jenkinsfile-vim-syntax'})

vim.g.vim_markdown_folding_disabled = 1
paq({'plasticboy/vim-markdown'})

paq({'nvim-lua/popup.nvim'})
paq({'nvim-lua/plenary.nvim'})
paq({'nvim-telescope/telescope.nvim'})

-- miscellaneous
vim.g.vimpager_scrolloff = 0

-- use real tabs in Makefiles and Kconfig
vim.api.nvim_command([[
    augroup ExpandTabsOverride
        autocmd! FileType make setlocal noexpandtab sw=4 ts=4 sts=4
        autocmd! FileType kconfig setlocal noexpandtab sw=4 ts=4 sts=4
    augroup END
]])
