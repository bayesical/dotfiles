return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- LSPs
					"lua_ls",
					"clangd",
					"gopls",
					"pylsp",
					"rust_analyzer",
					"ts_ls",
					"sqls",
					"omnisharp",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "Hoffs/omnisharp-extended-lsp.nvim" },
		config = function()
			-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")

			local function on_attach(client, bufnr)
				local bufopts = { noremap = true, silent = true, buffer = bufnr }

				if client.name == "omnisharp" then
					vim.keymap.set(
						"n",
						"<leader>gd",
						"<cmd>lua require('omnisharp_extended').telescope_lsp_definition()<CR>",
						bufopts
					)
					vim.keymap.set(
						"n",
						"<leader>D",
						"<cmd>lua require('omnisharp_extended').telescope_lsp_type_definition()<CR>",
						{ noremap = true, silent = true }
					)

					vim.keymap.set(
						"n",
						"<leader>gr",
						"<cmd>lua require('omnisharp_extended').telescope_lsp_references()<CR>",
						{ noremap = true, silent = true }
					)

					vim.keymap.set(
						"n",
						"<leader>gi",
						"<cmd>lua require('omnisharp_extended').telescope_lsp_implementation()<CR>",
						{ noremap = true, silent = true }
					)
				else
					vim.keymap.set(
						"n",
						"<leader>gd",
						require("telescope.builtin").lsp_definitions,
						{ desc = "LSP: [G]oto [D]efinition" }
					)
					vim.keymap.set(
						"n",
						"<leader>gr",
						require("telescope.builtin").lsp_references,
						{ desc = "LSP: [G]oto [R]eferences" }
					)
					vim.keymap.set(
						"n",
						"<leader>gi",
						require("telescope.builtin").lsp_implementations,
						{ desc = "LSP: [G]oto [I]mplementation" }
					)
					vim.keymap.set(
						"n",
						"<leader>td",
						require("telescope.builtin").lsp_type_definitions,
						{ desc = "LSP: [T]ype [D]efinition" }
					)
				end
			end

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.clangd.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
				settings = {
					gopls = {
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			})

			lspconfig.pylsp.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.sqls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig.omnisharp.setup({
				capabilities = capabilities,
				cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
				on_attach = on_attach,
			})

			vim.keymap.set(
				"n",
				"<leader>ds",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "LSP: [D]ocument [S]ymbols" }
			)
			vim.keymap.set(
				"n",
				"<leader>ws",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				{ desc = "LSP: [W]orkspace [S]ymbols" }
			)

			vim.keymap.set("n", "D", vim.lsp.buf.hover, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters (none-ls)
					"stylua",
					"prettier",
					"isort",
					"google-java-format",
					"gofumpt",
					"goimports",

					-- Linters (none-ls)
					"eslint_d",

					-- (Formatter + Linter)s (none-ls)
					"rubocop",

					-- DAPs
					"netcoredbg",
					"delve",
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					require("none-ls.diagnostics.eslint_d"),
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.rubocop,
					null_ls.builtins.formatting.rubocop,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.google_java_format,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports,
				},
			})

			vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
		end,
	},
}
