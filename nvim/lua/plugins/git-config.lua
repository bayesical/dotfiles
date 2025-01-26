return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", {})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
			})
			vim.keymap.set("n", "<leader>ph", ":Gitsigns preview_hunk<CR>", {})
			vim.keymap.set("n", "<leader>tgb", ":Gitsigns toggle_current_line_blame<CR>", {})
		end,
	},
}
