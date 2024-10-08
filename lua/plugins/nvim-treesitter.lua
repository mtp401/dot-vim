return {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'LazyFile', 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0,
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts = {
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
            'git_config',
            'git_rebase',
            'gitcommit',
            'gitignore',
            'go',
            'groovy',
            'javascript',
            'json',
            'kconfig',
            'lua',
            'make',
            'markdown',
            'markdown_inline',
            'meson',
            'ninja',
            'passwd',
            'pem',
            'perl',
            'printf',
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
            'vimdoc',
            'xml',
            'yaml'
        }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end
}
