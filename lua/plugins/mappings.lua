return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
          ["<Leader><C-P>"] = {
            function() require("telescope").extensions.projects.projects {} end,
            desc = "open projects",
          },
          ["o"] = { "a<CR><ESC>", desc = "Insert new line from cursor" },
          ["<C-F5>"] = { function() require("csharp").debug_project() end, desc = "CSharp project runner" },
          ["-"] = { "<CMD>Oil<CR>", desc = "Open parent directory" },
        },
        t = {
          ["o"] = false,
        },
      },
      -- {
      --   "AstroNvim/astrolsp",
      --   ---@type AstroLSPOpts
      --   opts = {
      --     mappings = {
      --       n = {
      --         -- this mapping will only be set in buffers with an LSP attached
      --         K = {
      --           function() vim.lsp.buf.hover() end,
      --           desc = "Hover symbol details",
      --         },
      --         -- condition for only server with declaration capabilities
      --         gD = {
      --           function() vim.lsp.buf.declaration() end,
      --           desc = "Declaration of current symbol",
      --           cond = "textDocument/declaration",
      --         },
      --       },
      --     },
      --   },
      -- },
    },
  },
}
