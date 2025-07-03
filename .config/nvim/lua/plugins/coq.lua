return {
  'ms-jpq/coq_nvim',
  branch = 'coq',
  event = 'VeryLazy',
  dependencies = {
    { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
    { 'ms-jpq/coq.thirdparty', branch = '3p' },
  },
  init = function()
    vim.g.coq_settings = {
      auto_start = true,
      keymap = {
        recommended = true,
      },
      display = {
        icons = { mode = 'none', },
        statusline = { helo = false }
      },
    }
  end,
} 