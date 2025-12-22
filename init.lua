-- ################
-- ### Settings ###
-- ################

local vim = vim

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
vim.opt.wrap = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.opt.inccommand = 'split'
vim.opt.scrolloff = 10
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.winborder = 'rounded'

vim.diagnostic.config({ virtual_text = true })

-- Keymaps
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

-- Add Plugins
vim.pack.add({
	{ src = 'https://github.com/vague-theme/vague.nvim' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-lualine/lualine.nvim' },
	{ src = 'https://github.com/nvim-mini/mini.pick' },
	{ src = 'https://github.com/windwp/nvim-autopairs' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

-- ################
-- ### Configs ####
-- ################

-- Colorscheme
require 'vague'.setup()
vim.cmd('colorscheme vague')

-- Lualine
require 'lualine'.setup()

-- Mini.pick
require 'mini.pick'.setup()
vim.keymap.set('n', '<leader><leader>', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')

--  Autopairs
require 'nvim-autopairs'.setup()

-- Tree-sitter
require 'nvim-treesitter'.install({
	"r",
	"python",
	"lua",
	"rust",
	"typst",
})

-- ###########
-- ### Lsp ###
-- ###########
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.lsp.enable({
	'lua_ls',
	'rust_analyzer',
	'pyright',
	'r_language_server',
	'tinymist',
})
