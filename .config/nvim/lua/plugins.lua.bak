return {

--                       _
--  ___ _ __   __ _  ___| | _____
-- / __| '_ \ / _` |/ __| |/ / __|
-- \__ \ | | | (_| | (__|   <\__ \
-- |___/_| |_|\__,_|\___|_|\_\___/

  {
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
            icon = "",
            title = "repo",
            style = "header",
            indent = 2,
            padding = 1,
            function()
              local in_git = Snacks.git.get_root() ~= nil
              local cmds = {
                {
                  enabled = in_git,
                  icon = "   ",
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
                  icon = "   ",
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
                  icon = "   ",
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
                  icon = "   ",
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
                  icon = "   ",
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

  },

--      _        _             _ _
--  ___| |_ __ _| |_ _   _ ___| (_)_ __   ___
-- / __| __/ _` | __| | | / __| | | '_ \ / _ \
-- \__ \ || (_| | |_| |_| \__ \ | | | | |  __/
-- |___/\__\__,_|\__|\__,_|___/_|_|_| |_|\___|

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'seoul256',
        icons_enabled = false,
      }
    }
  },

--            _
--   ___ ___ | | ___  _ __ ___
--  / __/ _ \| |/ _ \| '__/ __|
-- | (_| (_) | | (_) | |  \__ \
--  \___\___/|_|\___/|_|  |___/

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

--                       _       _
--  _ __ ___   __ _ _ __| | ____| | _____      ___ __
-- | '_ ` _ \ / _` | '__| |/ / _` |/ _ \ \ /\ / / '_ \
-- | | | | | | (_| | |  |   < (_| | (_) \ V  V /| | | |
-- |_| |_| |_|\__,_|_|  |_|\_\__,_|\___/ \_/\_/ |_| |_|

  -- must be loaded after colorschemes and not lazily, as it already is lazy internally(?)
  -- also needs to be loaded before vim-treesitter
  {
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
  },


--  _ __   __ _ _ __ ___ _ __  ___
-- | '_ \ / _` | '__/ _ \ '_ \/ __|
-- | |_) | (_| | | |  __/ | | \__ \
-- | .__/ \__,_|_|  \___|_| |_|___/
-- |_|


  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { "BufReadPost", "BufNewFile" }, -- Load after buffer is ready
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
      -- "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = 'rainbow-delimiters.strategy.global',
          vim = 'rainbow-delimiters.strategy.local',
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        priority = {
          [''] = 110,
          lua = 210,
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },

      }
    end,
  },

--           _     _ _
-- __      _| |__ (_) |_ ___  ___ _ __   __ _  ___ ___
-- \ \ /\ / / '_ \| | __/ _ \/ __| '_ \ / _` |/ __/ _ \
--  \ V  V /| | | | | ||  __/\__ \ |_) | (_| | (_|  __/
--   \_/\_/ |_| |_|_|\__\___||___/ .__/ \__,_|\___\___|
--                               |_|

  {
    'echasnovski/mini.trailspace',
    config = function()
      require('mini.trailspace').setup()
      -- Automatically trim on write
      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
          require('mini.trailspace').trim()
          require('mini.trailspace').trim_last_lines()
        end
      })
    end
  },

  -- colorpicker
  {
    "eero-lehtinen/oklch-color-picker.nvim",
    event = "VeryLazy",
    version = "*",
    keys = {
      -- One handed keymap recommended, you will be using the mouse
      {
        "<leader>c",
        function() require("oklch-color-picker").pick_under_cursor() end,
        desc = "Color pick under cursor",
      },
    },
    ---@type oklch.Opts
    opts = {},
  },


--  _            __  __
-- | |__  _   _ / _|/ _| ___ _ __ ___
-- | '_ \| | | | |_| |_ / _ \ '__/ __|
-- | |_) | |_| |  _|  _|  __/ |  \__ \
-- |_.__/ \__,_|_| |_|  \___|_|  |___/

  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy', -- Load after colorscheme
    config = function()
      require('bufferline').setup({
        options = {
          mode = 'tabs',
          diagnostics = "nvim_lsp",
          separator_style = "none",
          show_buffer_close_icons = true,
          show_close_icon = true,
          color_icons = true,
          get_element_icon = function(element)
            local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
            return icon, hl
          end,
        },
      })

      -- Programmatically force all bufferline colors to use colorscheme colors
      local function set_bufferline_colors()
        -- Get all highlight groups that start with "BufferLine"
        local all_highlights = vim.fn.getcompletion('BufferLine', 'highlight')

        -- Define mapping rules based on highlight group patterns
        local highlight_mapping = {
          -- Selected/active elements
          { pattern = "Selected", link = "CursorLine" },
          { pattern = "Pick", link = "Function" },
          { pattern = "Indicator", link = "Function" },

          -- Diagnostic states
          { pattern = "Error", link = "ErrorMsg" },
          { pattern = "Warning", link = "WarningMsg" },
          { pattern = "Info", link = "Directory" },
          { pattern = "Hint", link = "Comment" },
          { pattern = "Modified", link = "WarningMsg" },

          -- Default fallback (should be last)
          { pattern = ".*", link = "Normal" },
        }

        -- Apply mapping to each BufferLine highlight group
        for _, hl_name in ipairs(all_highlights) do
          for _, mapping in ipairs(highlight_mapping) do
            if hl_name:match(mapping.pattern) then
              vim.api.nvim_set_hl(0, hl_name, { link = mapping.link })
              break -- Stop at first match
            end
          end
        end

        -- Optional: Print discovered groups for debugging
        -- print("Found BufferLine highlights:", vim.inspect(all_highlights))
      end

      -- Apply colors immediately
      set_bufferline_colors()

      -- Ensure it works when switching colorschemes
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_bufferline_colors,
      })
    end
  },


--   __       _     _
--  / _| ___ | | __| |
-- | |_ / _ \| |/ _` |
-- |  _| (_) | | (_| |
-- |_|  \___/|_|\__,_|

  -- {
  --   "chrisgrieser/nvim-origami",
  --   event = "VeryLazy",
  --   opts = {}, -- needed even when using default config
  --   -- recommended: disable vim's auto-folding
  --   init = function()
  --     vim.opt.foldlevel = 99
  --     vim.opt.foldlevelstart = 99
  --     -- default settings
  --     require("origami").setup {
  --       -- features incompatible with `nvim-ufo`
  --       useLspFoldsWithTreesitterFallback = not package.loaded["ufo"],
  --       autoFold = {
  --         enabled = false,
  --         kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
  --       },
  --       foldtextWithLineCount = {
  --         enabled = not package.loaded["ufo"],
  --         template = "   %s lines", -- `%s` gets the number of folded lines
  --         hlgroupForCount = "Comment",
  --       },
  --       -- can be used with or without `nvim-ufo`
  --       pauseFoldsOnSearch = true,
  --       foldKeymaps = {
  --         setup = true, -- modifies `h` and `l`
  --         hOnlyOpensOnFirstColumn = false,
  --       },
  --       -- features requiring `nvim-ufo`
  --       keepFoldsAcrossSessions = package.loaded["ufo"],
  --     }
  --   end,
  -- },

--        _ _
--   ___ (_) |
--  / _` | | |
-- | (_) | | |
--  \___/|_|_|

  {
    'stevearc/oil.nvim',
    lazy = false,
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },


--   __ _       _      _
--  / _(_) __ _| | ___| |_
-- | |_| |/ _` | |/ _ \ __|
-- |  _| | (_| | |  __/ |_
-- |_| |_|\__, |_|\___|\__|
--        |___/

  {
    "pavanbhat1999/figlet.nvim",
    keys = {
      { "<leader>af", ":Fig ", desc = "Figlet" }
    }
  },


--        _ _
--   __ _(_) |_
--  / _` | | __|
-- | (_| | | |_
--  \__, |_|\__|
--  |___/

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },


--  _   _     _       _                 _
-- | |_(_) __| | __ _| | ___ _   _  ___| | ___  ___
-- | __| |/ _` |/ _` | |/ __| | | |/ __| |/ _ \/ __|
-- | |_| | (_| | (_| | | (__| |_| | (__| |  __/\__ \
--  \__|_|\__,_|\__,_|_|\___|\__, |\___|_|\___||___/
--                           |___/

  {
    'tidalcycles/vim-tidal',
    ft = 'tidal',
    config = function()
      -- vim.g.tidal_sc_enable = 1
      vim.g.tidal_target = "tmux"
      vim.g.tidal_flash_duration = 150
      vim.g.tidal_paste_file = "/tmp/tidal_paste_file.txt"
    end,
  },

--                       _
--  _ __ ___   __ _ _ __| | _____
-- | '_ ` _ \ / _` | '__| |/ / __|
-- | | | | | | (_| | |  |   <\__ \
-- |_| |_| |_|\__,_|_|  |_|\_\___/
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
  },


--      _ _       _
--   __| (_) __ _| |
--  / _` | |/ _` | |
-- | (_| | | (_| | |
--  \__,_|_|\__,_|_|

  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()

      local function feed_and_save(keys)
        local feedkeys = vim.api.nvim_feedkeys
        local replace_termcodes = vim.api.nvim_replace_termcodes
        feedkeys(replace_termcodes(keys, true, false, true), "n", false)
        vim.defer_fn(function()
          vim.cmd("write")
        end, 20)
      end

      vim.keymap.set("n", "<F12>", function()
        feed_and_save("<Plug>(dial-increment)")
      end, { noremap = true })

      vim.keymap.set("n", "<F11>", function()
        feed_and_save("<Plug>(dial-decrement)")
      end, { noremap = true })

    end,
  },


--  _       _
-- | |_ ___| | ___  ___  ___ ___  _ __   ___
-- | __/ _ \ |/ _ \/ __|/ __/ _ \| '_ \ / _ \
-- | ||  __/ |  __/\__ \ (_| (_) | |_) |  __/
--  \__\___|_|\___||___/\___\___/| .__/ \___|
--                               |_|


  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',

        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {telescope.setup{
        pickers = { colorscheme = { enable_preview = true } },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Set Telescope colors to match global colorscheme
      local function set_telescope_colors()
        local highlights = {
          TelescopeNormal = { link = "Normal" },
          TelescopeBorder = { link = "Normal" },
          TelescopePromptBorder = { link = "Normal" },
          TelescopeResultsBorder = { link = "Normal" },
          TelescopePreviewBorder = { link = "Normal" },
          TelescopeMatching = { link = "Search" },
          TelescopePromptPrefix = { link = "Identifier" },
          TelescopeSelection = { link = "CursorLine" },
          TelescopeSelectionCaret = { link = "Identifier" },
        }
        
        for group, opts in pairs(highlights) do
          vim.api.nvim_set_hl(0, group, opts)
        end
      end

      -- Apply colors immediately and when colorscheme changes
      set_telescope_colors()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_telescope_colors,
      })

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  {
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
  },

--  _     ____  ____
-- | |   / ___||  _ \
-- | |   \___ \| |_) |
-- | |___ ___) |  __/
-- |_____|____/|_|

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Use COQ for completion capabilities
      'ms-jpq/coq_nvim',
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Create a function that lets us more easily define mappings specific for LSP related
          -- items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- COQ capabilities for LSP
      local capabilities = require('coq').lsp_ensure_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- diagnostics = { disable = { 'missing-fields' } },
              -- diagnostics = { enable = true, globals = { "vim" }, },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      -- You can add other tools here that you want Mason to install
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  }, -- end LSP config

}
