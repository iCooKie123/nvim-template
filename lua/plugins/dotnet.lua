return {
  {
    "iabdelkareem/csharp.nvim",
    dependencies = {
      "williamboman/mason.nvim", -- Required, automatically installs omnisharp
      "mfussenegger/nvim-dap",
      "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
    },
    config = function()
      require("mason").setup() -- Mason setup must run before csharp
      require("csharp").setup()
    end,
    opts = {
      lsp = {
        enable = false,
        cmd_path = nil,
      },
    },
  },
}
