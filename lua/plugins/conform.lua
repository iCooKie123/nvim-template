return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup {
      formatters_by_ft = {
        javascript = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        python = { "autopep8" },
        csharp = { "csarhpie" },
      },
      format_on_save = true,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args) require("conform").format { bufnr = args.buf } end,
    })
  end,
}
