-- INIT.LUA
vim.o.number = true
vim.o.list = true
vim.o.expandtab = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.signcolumn = 'yes'
vim.o.winborder = 'rounded'


vim.pack.add {
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-telescope/telescope.nvim' },
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
}

vim.cmd('colorscheme habamax')

vim.lsp.enable { 'lua_ls', 'pylsp', 'rust-analyzer' }

require("oil").setup()

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>e',   ':Ex<CR>')
vim.keymap.set('n', '<leader>E',   ':Ex %:p:h<CR>')
vim.keymap.set('n', '<leader>f',   ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>b',   ':Telescope buffers<CR>')
vim.keymap.set('n', '<leader>/',   ':Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>g',   ':Telescope git_branches<CR>')
vim.keymap.set('n', '<leader>\'',  ':Telescope resume<CR>')
