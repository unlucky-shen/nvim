local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

if not (vim.uv or vim.loop).fs_stat(pckr_path) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/lewis6991/pckr.nvim",
		pckr_path,
	})
end

vim.opt.rtp:prepend(pckr_path)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
do
	local nixvim_globals =
		{ have_nerd_font = true, loaded_netrw = 1, loaded_netrwPlugin = 1, mapleader = " ", maplocalleader = " " }

	for k, v in pairs(nixvim_globals) do
		vim.g[k] = v
	end
end

-- Setup pckr.nvim
require("pckr").add({
	"sainnhe/gruvbox-material",
	"tpope/vim-surround",
	"nvim-tree/nvim-web-devicons",
	"nvim-mini/mini.nvim",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"windwp/nvim-ts-autotag",
	"nvim-treesitter/nvim-treesitter",
	"xiyaowong/transparent.nvim",
	"windwp/nvim-autopairs",
	"lukas-reineke/indent-blankline.nvim",
	"lewis6991/gitsigns.nvim",
	"folke/flash.nvim",
	"j-hui/fidget.nvim",
	"akinsho/bufferline.nvim",
	"jake-stewart/multicursor.nvim",
	"mhartington/formatter.nvim",
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",

	{
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make clean && make",
			},
		},
	},

	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSPs
					"astro-language-server",
					"biome",
					"clangd",
					"emmet-language-server",
					"lua-language-server",
					"pyright",
					"rust-analyzer",
					"svelte-language-server",
					"tailwindcss-language-server",
					"texlab",
					"tinymist",
					"typescript-language-server",

					-- formatter
					"clang-format",
					"latexindent",
					"prettier",
					"ruff",
					"shfmt",
					"stylua",
					"stylua",
					"typstyle",
				},
				auto_update = false,
				run_on_start = true,
				start_delay = 3000,
				debounce_hours = 5,
				integrations = {
					["mason-lspconfig"] = true,
					["mason-null-ls"] = true,
					["mason-nvim-dap"] = true,
				},
			})
		end,
	},
})

require("config")
