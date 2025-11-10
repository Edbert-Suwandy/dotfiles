return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            theme = 'auto',
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            globalstatus = true,
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = {
                {
                    'filename',
                    file_status = true,
                    path = 1,
                }
            },
            lualine_x = {
                function()
                    local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
                    if #clients > 0 then
                        local names = {}
                        for _, client in ipairs(clients) do
                            table.insert(names, client.name)
                        end
                        -- Unicode character '' is a nice LSP icon
                        return ' LSP: ' .. table.concat(names, ', ')
                    else
                        return 'LSP: N/A'
                    end
                end
            },
            lualine_y = { 'filetype', 'encoding' },
            lualine_z = { 'progress', 'location' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { { 'filename', path = 1 } },
            lualine_x = { 'location' },
            lualine_y = {},
            lualine_z = {}
        },
        extensions = { 'nvim-tree', 'lazy' },
    },
}
