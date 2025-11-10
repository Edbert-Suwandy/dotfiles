local lsp_server_name = {}
if _G.Lsp and type(_G.Lsp) == 'table' then
    for key, _ in pairs(_G.Lsp) do
        table.insert(lsp_server_name, key)
    end
end

return {
  { "neovim/nvim-lspconfig" },
  {
    "mason-org/mason.nvim",
    opts = {
        ui = {
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
            }
        },
        ensure_installed = lsp_server_name,
    }
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        automatic_enable = true
    },
    dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local capable = require("cmp_nvim_lsp").default_capabilities()
        local m_lsp = require("mason-lspconfig")
        local on_attach = function(client, bufnr)
            local auto_format = _G.Lsp[client]
            -- auto formatting
            if client.supports_method("textDocument/formatting") and auto_format then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("LspFormatting" .. client.name, { clear = true }),
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ async = true }) 
                    end,
                })
            end

            --hotkeys
            local opts = { buffer = bufnr }
            vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>d", vim.lsp.buf.definition, opts)
            vim.keymap.set('n', '<leader>D', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', '<leader>r', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>RN', vim.lsp.buf.rename, opts)
        end
        m_lsp.setup({
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = capable,
                        on_attach = on_attach,
                    })
                end
            }
        })
    end
  },
}
