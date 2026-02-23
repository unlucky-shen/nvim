-- This config only works on Neovim v0.12.0++
local vim = vim

-- Global Variables
vim.g.mapleader = " "
vim.g.localleader = " "

-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.signcolumn = 'yes:1'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.fillchars = { eob = ' ' }
vim.opt.mouse = 'a'
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
vim.keymap.set('n', '<leader>w', ':w<CR>')
vim.keymap.set('n', '<leader>q', ':qa<CR>')
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')

-- Add Plugins
vim.pack.add({
	{ src = 'https://github.com/sainnhe/gruvbox-material' },
	{ src = 'https://github.com/xiyaowong/transparent.nvim' },
	{ src = 'https://github.com/rktjmp/lush.nvim' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-mini/mini.pick' },
	{ src = 'https://github.com/akinsho/toggleterm.nvim' },
	{ src = 'https://github.com/windwp/nvim-autopairs' },
	{ src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
})

-- Colorscheme
vim.g.gruvbox_material_foreground = 'mix'
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_ui_contrast = 'high'
vim.g.gruvbox_material_float_style = 'bright'
vim.g.gruvbox_material_statusline_style = 'mix'
vim.g.gruvbox_material_cursor = 'auto'
vim.cmd("colorscheme gruvbox-material")

-- transparent.nvim
require 'transparent'.setup({})

-- Mini.pick
require 'mini.pick'.setup()
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>g', ':Pick grep_live<CR>')

-- Toggleterm
require 'toggleterm'.setup({
	insert_mappings = false,
	terminal_mappings = true,
	persist_mode = true,
	open_mapping = [[<leader><leader>]],
	shell = 'powershell', -- Change accordingly
	direction = 'float',
	float_opts = {
		border = 'curved',
		width = function()
			return math.ceil(vim.o.columns * 0.8)
		end,
		height = function()
			return math.ceil(vim.o.lines * 0.8)
		end,
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		}
	},
})

--  Autopairs
require 'nvim-autopairs'.setup()

-- Indent-Blankline
require 'ibl'.setup()

-- Tree-sitter
require 'nvim-treesitter.config'.setup({
	ensure_installed = {
		'r',
		'python',
		'lua',
		'rust',
		'c',
		'cpp',
	},
	highlight = { enable = true },
})

-- Lsp
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.lsp.enable({
	'lua_ls',
	'rust_analyzer',
	'pyright',
	'clangd',
	'r_language_server',
})
