return {
  "ahmedkhalf/project.nvim",
  setup = function()
    require("project_nvim").setup {}
    require("telescope").load_extension "projects"
    require("telescope").extensions.projects.projects {}
    require("nvim-tree").setup {
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    }
  end,
}
