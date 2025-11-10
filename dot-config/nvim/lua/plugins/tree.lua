return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			filesystem = {
				enable_diagnostics = false,
				enable_git_status = false,
			},

            window = {
                mappings = {
                    ["<cr>"] = "open",
                    ["<space>"] = "none"
                }
            }
		})
	end,
	vim.keymap.set("n", "<Leader>bb", ":Neotree toggle<CR>")
}
