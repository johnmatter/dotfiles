return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- speed
    bigfile = {},
    quickfile = {}, -- Quick file operations

    lazygit = {},
    explorer = {
      enabled = true,
    },

    notifier = {}, -- Nice notifications
    terminal = {}, -- Better terminal integration
    toggle = {}, -- Toggle utilities
    words = {}, -- Word highlighting

    dashboard = {
      -- https://github.com/folke/snacks.nvim/blob/main/docs/dashboard.md

      win = {
        position = "center", -- Center the entire dashboard window
        backdrop = false,
      },

      sections = {

        {
          section = "keys",
          icon = "󰌌",
          title = "keys",
          style = "header",
          indent = 2,
          padding = 1,
        },

        {
          icon = "",
          title = "repo",
          style = "header",
          indent = 2,
          padding = 1,
          function()
            local in_git = Snacks.git.get_root() ~= nil
            local cmds = {
              {
                enabled = in_git,
                icon = "   ",
                title = "browse",
                key = "b",
                cmd = "echo Open in browser",
                height = 2,
                action = function()
                  Snacks.gitbrowse()
                end,
                indent = 4,
              },
              {
                enabled = true,
                icon = "   ",
                title = "notifications",
                key = "N",
                cmd = "gh notify -s -n2",
                action = function()
                  vim.ui.open("https://github.com/notifications")
                end,
                height = 2,
                indent = 4,
              },
              {
                icon = "   ",
                title = "issues",
                key = "i",
                cmd = "gh issue list -L 2",
                action = function()
                  vim.fn.jobstart("gh issue list --web", { detach = true })
                end,
                height = 2,
                indent = 4,
              },
              {
                icon = "   ",
                title = "pull requests",
                cmd = "gh pr list -L 2",
                key = "P",
                action = function()
                  vim.fn.jobstart("gh pr list --web", { detach = true })
                end,
                height = 2,
                indent = 4,
              },
              {
                icon = "   ",
                title = "status",
                cmd = "git status --short --branch --renames",
                section = "terminal",
                enabled = function()
                  return Snacks.git.get_root() ~= nil
                end,
                ttl = 5 * 60,
                height = 5,
                indent = 4,
              },
            }
            return vim.tbl_map(
              function(cmd)
                return vim.tbl_extend("force", {
                  section = "terminal",
                  enabled = in_git,
                  ttl = 5 * 60,
                  indent = 4,
                },
                cmd)
              end,
            cmds)
          end,
        },

      }, -- sections
    }, -- dashboard

  }, -- snacks opts

  keys = {

    -- lazygit
    { "<leader>lg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },

    -- explorer
    { "<leader>e", function() Snacks.explorer() end, desc = "Toggle Explorer" },

    -- terminal
    { "<leader>nt", function() Snacks.terminal() end, desc = "Toggle Terminal" },

    -- notifications
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },

    -- words
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },

  }, -- snacks keybinds

} 