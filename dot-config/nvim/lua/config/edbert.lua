vim.g.mapleader = " "

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.number = true

vim.api.nvim_set_keymap('n', '<leader>r', ':set invrelativenumber<CR>', {
    noremap = true,
    silent = true,
    desc = "Toggle Relative Number"
})

-- LSP to install and enable auto format
Lsp = {
    lua_ls = true,
    gopls = true,
    docker_compose_language_service = true,
    dockerls = true,
    terraformls = true,
    bashls = true,
    pyright = true,
}
