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

function GitBranch()
  local handle = io.popen("git branch --show-current 2>/dev/null")
  if handle then
    local result = handle:read("*l")
    handle:close()
    if result ~= nil and result ~= "" then
      return " " .. result
    end
  end
  return ""
end

vim.o.statusline = "%<%f %h%w%m%r%{v:lua.GitBranch()}%=%-14.(%l,%c%V%) %P"

vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
})

require('vague').setup({
  on_highlights = function(hl, colors)
    hl.MiniPickNormal  = { bg = colors.bg }
    hl.MiniPickBorder  = { bg = colors.bg }
    hl.MiniFilesNormal = { bg = colors.bg }
    hl.MiniFilesBorder = { bg = colors.bg }
  end,
})

require("mini.pick").setup()
require("mini.files").setup()
require("mini.git").setup()

vim.cmd.colorscheme("vague")

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>f", ":Pick files<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>/", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>?", ":Pick help<CR>")
vim.keymap.set("n", "<leader>'", ":Pick resume<CR>")

local files = require "mini.files"
vim.keymap.set("n", "<leader>e", files.open)

vim.keymap.set({ "n", "x" }, "<leader>y", "\"+y")

vim.keymap.set("n", "<leader>t", ":below term<CR>i")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
