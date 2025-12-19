# nvim

* Most cursed nvim config you'll ever see
* Minimal plugins installed
* LSP servers will need to be updated manually by following the below steps,
  1. At the nvim-lsp-config github repo, navigate to `/nvim-lspconfig/lsp` and look for required lsp
  2. Copy and paste the required lsp file contents into nvim config folder under `~/.config/nvim/lsp`
  3. enable the lsp from `init.lua`. (eg.`vim.lsp.enable({ 'pyright' })`)
  4. Good luck.

```lua
-- Global Variables
vim.g.mapleader = " "
vim.g.localleader = " "

-- Options
vim.opt.number = true
vim.opt.cmdheight = 0
vim.opt.signcolumn = 'yes:2'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.fillchars = { eob = ' ' }
vim.opt.mouse = 'a'
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.winborder = 'rounded'

-- Keymaps
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
``` 
