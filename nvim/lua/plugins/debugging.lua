return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio", "leoluz/nvim-dap-go" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      require("dap-go").setup()
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
        args = { "--interpreter=vscode" },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }

      vim.keymap.set("n", "<leader>tb", dap.toggle_breakpoint, {})
      vim.keymap.set(
        "n",
        "<leader>sb",
        "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>"
      )
      vim.keymap.set(
        "n",
        "<leader>lb",
        "<cmd>lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>"
      )
      vim.keymap.set("n", "<leader>dc", dap.continue, {})
      vim.keymap.set("n", "<leader>si", dap.step_into, {})
      vim.keymap.set("n", "<leader>so", dap.step_over, {})
      vim.keymap.set("n", "<leader>eo", dap.step_out, {})
      vim.keymap.set("n", "<leader>rl", dap.run_last, {})
    end,
  },
}
