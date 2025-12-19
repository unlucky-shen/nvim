# nvim

* Cursed config
* Minimal plugins installed
* LSPs must be updated manually by following these steps,
  1. Make sure executable for LSPs are installed.
  2. At the [nvim-lsp-config Github repository](https://github.com/neovim/nvim-lspconfig), navigate to `/nvim-lspconfig/` and look for required lsp. (eg. `pyright.lua`)
  3. Copy and paste the contents of required lsp file contents into neovim config folder under `~/.config/nvim/lsp/`
  4. Enable the lsp from `init.lua`. (eg.`vim.lsp.enable({ 'pyright' })`)
  5. To trigger LSP autocomplete use `Ctrl + x + o`
  6. Have fun.

### Personal Settings (For clean look)
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
