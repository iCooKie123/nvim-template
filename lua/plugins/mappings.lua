return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          ["<C-s>"] = { ":w!<cr>", desc = "Save File" },
          ["<Leader><C-P>"]={":Telescope projects<cr>",desc="open projects"}
        },
      },
    },
  },
  
}