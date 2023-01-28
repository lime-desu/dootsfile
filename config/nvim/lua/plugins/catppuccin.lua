return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        options = {
          icons_enabled = true,
          theme = "catppuccin",
          disabled_filetypes = {},
          component_separators = "|",
          section_separators = { left = "", right = "" },
        },
      }
    end,
  },
}
