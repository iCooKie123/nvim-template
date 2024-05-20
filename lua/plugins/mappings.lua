return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          ["<C-s>"] = { ":w<cr>", desc = "Save File(no force)" },
          ["<C-P>"] = {
            function() require("telescope").extensions.projects.projects {} end,
            desc = "open projects",
          },
          ["o"] = { "o<ESC>", desc = "Insert new line from cursor" },
          ["-"] = { "<CMD>Oil<CR>", desc = "Open parent directory" },
          ["<C-b>"] = { function() vim.g.dotnet_build_project() end, desc = "Build dotnet project" },
          ["<Leader>x"] = {
            function() require("nvim-emmet").wrap_with_abbreviation() end,
            desc = "wrap in emmet abreviation",
          },
          ["<C-F5>"] = { function() require("csharp").debug_project() end },
          ["<C-F6>"] = { function() require("csharp").run_project() end },
        },
        t = {
          ["o"] = false,
        },
        v = {
          ["<Leader>x"] = {
            function() require("nvim-emmet").wrap_with_abbreviation() end,
            desc = "wrap in emmet abreviation",
          },
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
