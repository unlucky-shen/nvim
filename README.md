# nvim

* Currently rewriting the the config, however, general settings will remain the same everytime
```lua
-- settings
vim.g.mapleader = " "
vim.g.localleader = " "

vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.statusline = ''
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)
vim.opt.breakindent = true
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes:1'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.fillchars = { eob = ' ' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.winborder = "solid"


-- keymaps
vim.keymap.set('n', '<leader>w', ':update<CR> :write<CR>')
vim.keymap.set('n', '<leader>q', ':update<CR> :quit<CR>')
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
``` 
