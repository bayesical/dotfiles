return {
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		config = function()
			require("telescope").load_extension("rest")
			vim.keymap.set("n", "<leader>rr", ":Rest run<CR>")
      vim.keymap.set("n", "<leader>se", ":Rest env show<CR>")
      vim.keymap.set("n", "<leader>ce", ":Telescope rest select_env<CR>")
      vim.keymap.set("n", "<leader>rc", ":Rest cookies<CR>")
		end,
		-- TODO: Add logic to run the following if not installed: vim.cmd(":TSInstall http")
	},
	{
		"diepm/vim-rest-console",
		config = function()
			vim.g.vrc_set_default_mapping = 0
			vim.g.vrc_response_default_content_type = "application/json"
			vim.g.vrc_output_buffer_name = "_OUTPUT.json"
			vim.g.vrc_auto_format_response_patterns = {
				json = "jq",
			}
			vim.keymap.set("n", "<leader>hq", ":call VrcQuery()<CR>")
		end,
	},
}
