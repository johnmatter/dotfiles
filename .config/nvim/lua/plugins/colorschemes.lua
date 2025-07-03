return {
  {
    "yazeed1s/oh-lucy.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("oh-lucy")
    end,
  },

  {
    "shaunsingh/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark" -- or "light"
      vim.cmd([[colorscheme solarized]])
    end,
  },
} 