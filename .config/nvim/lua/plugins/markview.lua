return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  priority = 1100, -- Higher than treesitter to ensure it loads first
  dependencies = {
      "saghen/blink.cmp",
  },
  opts = {
    experimental = {
      check_rtp = false, -- Disable runtime path checking to suppress warning
    },
  },
  preview = {
      icon_provider = "internal", -- internal, mini or devicons
  }
} 