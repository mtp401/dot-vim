-- plugins
require('config.lazy')

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
vim.opt.colorcolumn = '80'

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

vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'nvim_treesitter#foldexpr()'
vim.o.foldenable = false

vim.cmd([[colorscheme material]])

-- -- miscellaneous
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
