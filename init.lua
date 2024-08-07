-- security
vim.o.exrc = false  -- ignore ~/.exrc
vim.o.secure = true  -- disallow local rc exec

-- tab / whitespace control
vim.o.expandtab = true  -- expand hard tabs to spaces
vim.o.softtabstop = 4  -- expand tabs to 4 spaces
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

-- spelling
-- set spell to activate
vim.o.spelllang = 'en_us'

---- remap O and o to not leave things in insert mode
vim.api.nvim_set_keymap('n', 'O', 'O<esc>', {noremap = true})
vim.api.nvim_set_keymap('n', 'o', 'o<esc>', {noremap = true})

-- disable unused providers to speed up start up
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
    folding = {enable = true},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    incremental_selection = {enable = true},
    ensure_installed = {
        'bash',
        'c',
        'comment',
        'cpp',
        'devicetree',
        'diff',
        'disassembly',
        'dockerfile',
        'editorconfig',
        'git_rebase',
        'gitcommit',
        'gitignore',
        'go',
        'groovy',
        'javascript',
        'json',
        'kconfig',
        'latex',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'meson',
        'ninja',
        'passwd',
        'pem',
        'perl',
        'promql',
        'proto',
        'python',
        'query',
        'regex',
        'rust',
        'ssh_config',
        'strace',
        'toml',
        'udev',
        'vim',
        'xml',
        'yaml'
    }
})
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false

paq({'norcalli/nvim-colorizer.lua'})
require('colorizer').setup()

paq({'marko-cerovac/material.nvim'})
require('material').setup({
    custom_colors = require('custom-material-colors').colors,
    style = 'darker'
})
vim.cmd([[colorscheme material]])

paq({'kyazdani42/nvim-web-devicons', opt = true})
paq({'nvim-lualine/lualine.nvim'})
require('lualine').setup({
    options = {theme = 'material'},
    sections = {
        lualine_y = {
            {'diagnostics', sources = {'nvim_diagnostic', 'ale'}}
        }
    }
})

paq({'neovim/nvim-lspconfig'})
local lspconfig = require('lspconfig')
lspconfig.clangd.setup({
    cmd = {'clangd', '--background-index', '--clang-tidy'}
})
lspconfig.rust_analyzer.setup({})

vim.g.ale_linters_explicit = 1
vim.g.ale_linters = {
    cpp = {'cpplint'},  -- `pipx install cpplint`
    gitcommit = {'gitlint'},  -- `pipx install --include-deps gitlint`
    markdown = {'mdl'},  -- `gem install --user mdl`
    sh = {'shellcheck'},  -- `cabal update; cabal install --installdir=${HOME}/.local/bin ShellCheck`
    yaml = {'yamllint'},  -- `pipx install yamllint`
    python = {'pylint'}  -- `pipux install pylint`
}
vim.g.ale_sh_shellcheck_options = '-x'
vim.g.ale_sh_shellcheck_change_directory = 0
paq({'w0rp/ale'})

paq({'tpope/vim-fugitive'})
paq({'godlygeek/tabular'})
paq({'martinda/Jenkinsfile-vim-syntax'})
paq({'glench/vim-jinja2-syntax'})

paq({'nvim-lua/popup.nvim'})
paq({'nvim-lua/plenary.nvim'})
paq({'nvim-telescope/telescope.nvim'})

-- miscellaneous
vim.g.vimpager_scrolloff = 0

-- use real tabs in Makefiles and Kconfig
local expand_tabs_override_augroup = vim.api.nvim_create_augroup(
    'ExpandTabsOverride',
    {clear = true}
)
vim.api.nvim_create_autocmd(
    'FileType',
    {
        group = expand_tabs_override_augroup,
        pattern = {'make', 'kconfig'},
        callback = function()
            vim.opt_local.expandtab = false
        end
    }
)

-- some the syntax files set indents to 2, reset them to 4
local set_indentation_back_to_four_augroup = vim.api.nvim_create_augroup(
    'SetIndentationBackToFour',
    {clear = true}
)
vim.api.nvim_create_autocmd(
    'FileType',
    {
        group = set_indentation_back_to_four_augroup,
        pattern = {
            'make',
            'kconfig',
            'yaml',
            'meson',
            'proto'
        },
        callback = function()
            vim.opt_local.shiftwidth = 4
            vim.opt_local.tabstop = 4
            vim.opt_local.softtabstop = 4
        end
    }
)

-- detect files named Config.in as Kconfig
local detect_config_in_as_kconfig_augroup = vim.api.nvim_create_augroup(
    'DetectConfigInAsKconfig',
    {clear = true}
)
vim.api.nvim_create_autocmd(
    {'BufNewFile', 'BufRead'},
    {
        group = detect_config_in_as_kconfig_augroup,
        pattern = 'Config.in',
        callback = function()
            vim.opt_local.filetype = 'kconfig'
        end
    }
)
