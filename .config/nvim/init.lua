-- some lines taken from https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua

vim.g.project_root = vim.fn.getcwd()
-- vim.opt.termguicolors = true

-- plugins
require('config.lazy')
require('lualine').setup()

-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.cmd("vertical topleft 30vsplit | SnacksExplorer")
--   end
-- })

-- quick keymaps
vim.keymap.set('n', '<leader>q', ':q<cr>')
vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>t', ':tabnew<cr>')
vim.keymap.set('n', '<leader>o', ':Oil<CR>')

-- colors
vim.cmd.colorscheme "oh-lucy-evening"
-- vim.cmd.colorscheme "oh-lucy"
-- vim.cmd.colorscheme "solarized"
-- vim.o.background = "light"
vim.o.background = "dark"
vim.api.nvim_set_hl(0, "Visual", {
  fg = "#cac0ae",
  bg = "#4c7842",
})

vim.o.mouse = 'a'
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
-- vim.o.showmode = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

-- spacebar is leader
vim.g.mapleader = " "

-- tabs
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2

-- keep undo history
vim.o.undofile = true

-- case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- splits
vim.o.splitright = true
vim.o.splitbelow = true
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Split to the right
map('n', '<leader>ll', ':vsplit<CR>', opts)
map('n', '<leader>jj', ':split<CR>', opts)
map('n', '<leader>kk', ':split<CR><C-w>k', opts)
map('n', '<leader>hh', ':vsplit<CR><C-w>h', opts)

map('n', '<leader>wh', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<leader>wl', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<leader>wj', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<leader>wk', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- display whitespace
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- preview substitutions as you type
vim.o.inccommand = 'split'

-- cursor options
vim.o.cursorline = true
vim.o.scrolloff = 10

-- if e.g. :q would fail because of unsaved changes, prompt to save
vim.o.confirm = true

-- clear highlights in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- -- sync os and vim clipboard
-- vim.schedule(function()
--   vim.o.clipboard = 'unnamedplus'
-- end)

-- highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- -- aider
-- local function update_aider_watch_list()
--   local files = {}
--   local seen = {}
--   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
--     if vim.api.nvim_buf_is_loaded(buf) then
--       local name = vim.api.nvim_buf_get_name(buf)
--       if name ~= '' and vim.fn.filereadable(name) == 1 and
--          name:find(vim.g.project_root, 1, true) == 1 and not seen[name] then
--         table.insert(files, name)
--         seen[name] = true
--       end
--     end
--   end
--   local path = vim.fn.expand("~/.aider-watch-list")
--   vim.fn.writefile(files, path)
-- end
-- vim.api.nvim_create_augroup("AiderWatchSync", {clear=true})
-- vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost"}, {
--    pattern = "*",
--    callback = update_aider_watch_list,
--    group = "AiderWatchSync",
-- })

-- oil
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end
local detail = false

-- if a file has four spaces per indent level, this will convert it to two per indent level
vim.api.nvim_create_user_command("Retab4to2", function()
  vim.opt.expandtab = false
  vim.opt.tabstop = 4
  vim.cmd("retab!")
  vim.opt.expandtab = true
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.cmd("retab")
end, {})

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local builtin = require('telescope.builtin')

-- Custom action: Insert selected file path at cursor
local function insert_file_path_at_cursor(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  actions.close(prompt_bufnr)

  local path = entry.path or entry.filename
  if path then
    -- Escape backslashes and quotes for safety (optional)
    path = path:gsub("\\", "\\\\"):gsub('"', '\\"')

    -- Insert at cursor position
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local before = line:sub(1, col)
    local after = line:sub(col + 1)
    vim.api.nvim_set_current_line(before .. path .. after)
  end
end

-- Wrapper to call Telescope with the custom action
local function browse_and_insert_path()
  require('telescope.builtin').find_files({
    attach_mappings = function(_, map)
      map("i", "<CR>", insert_file_path_at_cursor)
      map("n", "<CR>", insert_file_path_at_cursor)
      return true
    end
  })
end

vim.keymap.set("n", "<Leader>fp", browse_and_insert_path, { desc = "Insert file path at cursor" })
vim.keymap.set("i", "<C-f>", browse_and_insert_path, { desc = "Insert file path at cursor" }) -- insert mode
