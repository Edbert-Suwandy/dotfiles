-- This file defines essential key mappings for navigating diagnostics (errors and warnings).
vim.diagnostic.config({
    virtual_text = {
        source = true, -- Display the source name (e.g., 'eslint')
        prefix = "●", -- Use a symbol as a prefix
        wrap = true
    },
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        warp = true
    },
})

local function map_diagnostic(mode, key, severity, direction, desc)
    local fn = direction == 'next' and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    vim.keymap.set(mode, key, function()
        fn({ severity = severity })
    end, { desc = desc, silent = true, noremap = true })
end
map_diagnostic('n', '<leader>e', vim.diagnostic.severity.ERROR, 'next', 'Next Error')
map_diagnostic('n', '<leader>w', vim.diagnostic.severity.WARN, 'next', 'Next Warning')
map_diagnostic('n', '<leader>d', nil, 'next', 'Next Diagnostic')

map_diagnostic('n', '<leader>E', vim.diagnostic.severity.ERROR, 'prev', 'Previous Error')
map_diagnostic('n', '<leader>W', vim.diagnostic.severity.WARN, 'prev', 'Previous Warning')
map_diagnostic('n', '<leader>D', nil, 'prev', 'Previous Diagnostic')
