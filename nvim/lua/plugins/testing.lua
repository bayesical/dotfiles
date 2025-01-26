return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "Issafalcon/neotest-dotnet",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-dotnet")({
            dap = {
              adapter_name = "coreclr",
            },
          }),
        },
      })
      vim.keymap.set("n", "<leader>rt", "<cmd>lua require('neotest').run.run()<CR>")
      vim.keymap.set("n", "<leader>rf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
      vim.keymap.set("n", "<leader>dt", "<cmd>lua require('neotest').run.run({strategy = 'dap'})<CR>")
    end,
  },
}
