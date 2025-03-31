-- Portions 

return {
    "mfussenegger/nvim-lint",
    ft = {
        'sh',
        'bash',
        'zsh',
        'cpp',
        'gitcommit',
        'markdown',
        'yaml',
        'python'
    },
    opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
            bash = { 'bash' },
            cpp = { 'cpplint' },  -- `pipx install cpplint`
            gitcommit = { 'gitlint' },  -- `pipx install --include-deps gitlint`
            markdown = { 'mdl' }, -- `cabal install MarkdownLint`
            sh = { 'shellcheck' },  -- `cabal update; cabal install --installdir=${HOME}/.local/bin ShellCheck`
            yaml = { 'yamllint' },  -- `pipx install yamllint`
            python = { 'pylint' },  -- `pipx install pylint`
            zsh = { 'shellcheck', 'zsh' }
        },
        linters =  {
            mdl = {
                cmd = 'mdl',
                args = { '--json' },
                stdin = true,
                ignore_exitcode = true,
                parser = function(output, bufnr, linter_cwd)
                    local diagnostics = {}
                    local decoded = vim.json.decode(output)

                    if decoded == nil then
                        return diagnostics
                    end

                    for _, lint in ipairs(decoded) do
                        table.insert(diagnostics, {
                            source = 'mdl',
                            bufnr = bufnr,
                            lnum = lint.line - 1,
                            col = 0,
                            severity = vim.diagnostic.severity.ERROR,
                            message = lint.rule .. ': ' .. lint.description,
                            code = lint.rule
                        })
                    end

                    return diagnostics
                end
            }
        },
    },
    config = function(_, opts)
        local M = {}

        local lint = require("lint")
        lint.linters_by_ft = opts.linters_by_ft
        
        for name, deets in pairs(opts.linters) do
            lint.linters[name] = deets
        end

        function M.debounce(ms, fn)
            local timer = vim.uv.new_timer()
            return function(...)
                local argv = { ... }
                timer:start(ms, 0, function()
                    timer:stop()
                    vim.schedule_wrap(fn)(unpack(argv))
                end)
            end
        end

        function M.lint()
            -- Use nvim-lint's logic first:
            -- * checks if linters exist for the full filetype first
            -- * otherwise will split filetype by "." and add all those linters
            -- * this differs from conform.nvim which only uses the first filetype that has a formatter
            local names = lint._resolve_linter_by_ft(vim.bo.filetype)

            -- Create a copy of the names table to avoid modifying the original.
            names = vim.list_extend({}, names)

            -- Add fallback linters.
            if #names == 0 then
                vim.list_extend(names, lint.linters_by_ft["_"] or {})
            end

            -- Add global linters.
            vim.list_extend(names, lint.linters_by_ft["*"] or {})

            -- Run linters.
            if #names > 0 then
                lint.try_lint(names)
            end
        end

        vim.api.nvim_create_autocmd(opts.events, {
            group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
            callback = M.debounce(100, M.lint),
        })
    end
}
