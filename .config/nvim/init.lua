vim.o.termguicolors = true
vim.o.nu = true
vim.o.cursorline = true
vim.o.autoread = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.list = true
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.path = "**/*"
vim.diagnostic.config({ virtual_text = true })

function GitBranch()
  local handle = io.popen("git branch --show-current 2>/dev/null")
  local result = handle and handle:read("*l") or nil
  if handle then handle:close() end
  return (result and result ~= "") and (" " ..result) or ""
end

vim.o.statusline = "%<%f %h%w%m%r%{v:lua.GitBranch()}%=%-14.(%l,%c%V%) %P"

vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
})

require("mini.ai").setup()
require("mini.surround").setup()
require("mini.notify").setup()
require('mini.hipatterns').setup()
require("mini.pick").setup()
require("mini.files").setup()
require("mini.git").setup()
require("mini.completion").setup()
require("mini.cmdline").setup()
require("mini.diff").setup({
  view = {
    style = 'sign',
    signs = { add = '+', change = '~', delete = '-' },
  },
})
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    { mode = { 'n', 'x' }, keys = '<Leader>' },
    { mode = 'n', keys = '[' },
    { mode = 'n', keys = ']' },
    { mode = 'i', keys = '<C-x>' },
    { mode = { 'n', 'x' }, keys = 'g' },
    { mode = { 'n', 'x' }, keys = "'" },
    { mode = { 'n', 'x' }, keys = '`' },
    { mode = { 'n', 'x' }, keys = '"' },
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    { mode = 'n', keys = '<C-w>' },
    { mode = { 'n', 'x' }, keys = 'z' },
  },
  clues = {
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

require("mason").setup()
vim.lsp.enable({ "lua_ls", "ts_ls" })

local hipatterns = require "mini.hipatterns"
hipatterns.setup({
  highlighters = {
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

vim.cmd.colorscheme("vague")

vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

local notify = require "mini.notify"
vim.keymap.set("n", "<leader>nh", notify.show_history, { desc = "Show notify history" })

vim.keymap.set("n", "<leader>f", ":Pick files<CR>", { desc = "Search files" })
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>", { desc = "Search buffers" })
vim.keymap.set("n", "<leader>/", ":Pick grep_live<CR>", { desc = "Search live grep" })
vim.keymap.set("n", "<leader>?", ":Pick help<CR>", { desc = "Search help" })
vim.keymap.set("n", "<leader>'", ":Pick resume<CR>", { desc = "Resume last search" })

local diff = require "mini.diff"
local git = require "mini.git"
vim.keymap.set("n", "<leader>go", diff.toggle_overlay, { desc = "Git toggle overlay" })
vim.keymap.set("n", "<leader>gs", git.show_at_cursor, { desc = "Git show at cursor"})

local files = require "mini.files"
vim.keymap.set("n", "<leader>e", function() files.open(vim.api.nvim_buf_get_name(0)) end, { desc = "Explore" })
vim.keymap.set("n", "<leader>E", files.open, { desc = "Explore project dir" })

vim.keymap.set({ "n", "x" }, "<leader>y", "\"+y", { desc = "Yeank to clipboard" })

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")

local terminal_buf, terminal_win
function ToggleTerminal()
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    vim.api.nvim_win_close(terminal_win, true)
    terminal_win = nil
    return
  end

  vim.cmd("belowright 15split")
  terminal_win = vim.api.nvim_get_current_win()

  if not terminal_buf or not vim.api.nvim_buf_is_valid(terminal_buf) then
    vim.cmd("terminal")
    terminal_buf = vim.api.nvim_get_current_buf()
  else
    vim.api.nvim_win_set_buf(terminal_win, terminal_buf)
  end

  vim.cmd("startinsert")
end

vim.keymap.set({ "n", "t" }, "<M-t>", ToggleTerminal)
