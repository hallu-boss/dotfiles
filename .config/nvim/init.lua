vim.o.termguicolors = true
vim.o.nu = true
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

vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>/", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>?", ":Pick help<CR>")
vim.keymap.set("n", "<leader>'", ":Pick resume<CR>")

local diff = require "mini.diff"
local git = require "mini.git"
vim.keymap.set("n", "<leader>go", diff.toggle_overlay)
vim.keymap.set("n", "<leader>gs", git.show_at_cursor)

local files = require "mini.files"
vim.keymap.set({ "n", "x" }, "<leader>e", files.open)

vim.keymap.set({ "n", "x" }, "<leader>y", "\"+y")

vim.keymap.set("n", "<leader>t", ":below term<CR>i")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
