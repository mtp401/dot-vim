return {
    'neovim/nvim-lspconfig',
    events = 'LazyFile',
    ft = { 'c', 'cpp', 'rust' },
    config = function()
        local lspconfig = require('lspconfig')
        local default_parallelism = vim.uv.available_parallelism()

        lspconfig.clangd.setup({
            cmd = {
                'clangd',
                '--background-index',
                '-j', math.max(1, default_parallelism / 2),
                '--limit-results=20000',
                '--limit-references=20000'
            }
        })
        lspconfig.rust_analyzer.setup({})
    end
}
