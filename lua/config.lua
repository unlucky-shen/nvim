-- Nixvim's internal module table
-- Can be used to share code throughout init.lua
local _M = {}

-- Set up options {{{
do
	local nixvim_options = {
	  number = true,
    mouse = 'a',
    showmode = false,
    cmdheight = 0,
    laststatus = 0,
    statusline = '',
    clipboard = 'unnamedplus',
    breakindent = true,
    swapfile = false,
    ignorecase = true,
    smartcase = true,
    signcolumn = 'yes:1',
    updatetime = 250,
    timeoutlen = 300,
    splitright = true,
    splitbelow = true,
    list = false,
    listchars = { tab = '» ', trail = '·', nbsp = '␣' },
    fillchars = { eob = ' ' },
    inccommand = 'split',
    cursorline = true,
    scrolloff = 10,
    winborder = "solid",
    termguicolors = true,
    background = "dark",
  }

	for k, v in pairs(nixvim_options) do
		vim.opt[k] = v
	end
end
-- }}}

vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_background = "hard"
vim.cmd.colorscheme("gruvbox-material")

require("nvim-web-devicons").setup({})

require("mini.ai").setup({ n_lines = 500 })

require("mini.files").setup({ mappings = { go_in = "L", go_in_plus = "", go_out = "H", go_out_plus = "" } })

local cmp = require("cmp")
cmp.setup({
	autoEnableSources = true,
	completion = { completeopt = "menu,menuone,noinsert" },
	experimental = { ghost_text = true },
	formatting = { fields = { "kind", "abbr", "menu" } },
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-j>"] = cmp.mapping(function(fallback)
			if require("luasnip").locally_jumpable(-1) then
				require("luasnip").jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-k>"] = cmp.mapping.complete(),
		["<C-l>"] = cmp.mapping(function(fallback)
			if require("luasnip").locally_jumpable(1) then
				require("luasnip").jump(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select),
		["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
	},
	performance = { debounce = 60, fetchingTimeout = 200, maxViewEntries = 30 },
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "emoji" },
		{ keywordLength = 3, name = "buffer", option = { get_bufnrs = vim.api.nvim_list_bufs } },
		{ keywordLength = 3, name = "path" },
		{ name = "nvim_lua" },
		{ keywordLength = 3, name = "luasnip" },
	},
	window = { completion = cmp.config.window.bordered(), documentation = cmp.config.window.bordered() },
})

require("nvim-ts-autotag").setup({})

vim.opt.runtimepath:prepend(vim.fs.joinpath(vim.fn.stdpath("data"), "site"))
require("nvim-treesitter.config").setup({
	auto_install = false,
	ensure_installed = {
		"c",
		"cpp",
		"css",
		"glsl",
		"html",
		"latex",
		"lua",
		"markdown",
		"nix",
		"python",
		"svelte",
		"tsx",
		"typescript",
		"vimdoc",
	},
	highlight = { enable = true },
	parser_install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
})

require("transparent").setup({})

require("telescope").setup({
	defaults = {
		file_ignore_patterns = { "node_modules" },
		layout_config = { horizontal = { prompt_position = "top" } },
		sorting_strategy = "ascending",
	},
	pickers = {
		find_files = {
			find_command = {
				"rg",
				"--files",
				"--glob",
				"!{.git/*,.svelte-kit/*,target/*,node_modules/*}",
				"--path-separator",
				"/",
			},
			hidden = true,
		},
	},
})

local __telescopeExtensions = { "ui-select", "fzf" }
for i, extension in ipairs(__telescopeExtensions) do
	require("telescope").load_extension(extension)
end

require("nvim-autopairs").setup({})

require("luasnip").config.setup({})

require("luasnip.loaders.from_vscode").lazy_load({})

require("ibl").setup({})

require("gitsigns").setup({})

require("flash").setup({})

require("fidget").setup({})

require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		separator_style = "thick",
		sort_by = "insert_after_current",
	},
})

local set = vim.keymap.set
local mc = require("multicursor-nvim")
mc.setup()

set({ "n", "v" }, "<M-k>", function()
	mc.lineAddCursor(-1)
end, { desc = "add cursor above" })
set({ "n", "v" }, "<M-j>", function()
	mc.lineAddCursor(1)
end, { desc = "add cursor below" })
set({ "n", "v" }, "<C-n>", function()
	mc.matchAddCursor(1)
end, { desc = "Add cursor by matching word/selection" })
set({ "n", "v" }, "<M-a>", mc.matchAllAddCursors, { desc = "Add all matches" })
set({ "n", "v" }, "<c-q>", mc.toggleCursor, { desc = "Add and remove cursors" })
set("n", "<c-leftmouse>", mc.handleMouse, { desc = "Add and remove cursors with mouse" })

set("n", "<esc>", function()
	vim.cmd([[nohlsearch]])
	if not mc.cursorsEnabled() then
		mc.enableCursors()
	elseif mc.hasCursors() then
		mc.clearCursors()
	end
end, { desc = "Remove cursors and highlight" })

set("v", "I", mc.insertVisual, { desc = "Insert for each line of visual selections" })
set("v", "A", mc.appendVisual, { desc = "Append for each line of visual selections" })
set("v", "M", mc.matchCursors, { desc = "Match new cursors within visual selections by regex" })

set({ "v", "n" }, "<c-i>", mc.jumpForward, { desc = "jumplist forward" })
set({ "v", "n" }, "<c-o>", mc.jumpBackward, { desc = "jumplist backward" })

local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { link = "Cursor" })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
-- for rust-analyzer https://github.com/neovim/neovim/issues/30985
for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
	local default_diagnostic_handler = vim.lsp.handlers[method]
	vim.lsp.handlers[method] = function(err, result, context, config)
		if err ~= nil and err.code == -32802 then
			return
		end
		return default_diagnostic_handler(err, result, context, config)
	end
end

local filetype = {
	lua = require("formatter.filetypes.lua").stylua,

	c = require("formatter.filetypes.cpp").clangformat,
	cpp = require("formatter.filetypes.cpp").clangformat,
	glsl = require("formatter.filetypes.cpp").clangformat,

	python = require("formatter.filetypes.python").ruff,
	rust = require("formatter.filetypes.rust").rustfmt,
	tex = require("formatter.filetypes.tex").latexindent,
	nix = require("formatter.filetypes.nix").nixfmt,

	typst = function()
		return { exe = "typstyle", args = { "-i" } }
	end,
}

local prettier = {
	"css",
	"javascript",
	"json",
	"typescript",
	"typescriptreact",
	"astro",
	"html",
	"svelte",
}
for _, lang in ipairs(prettier) do
	filetype[lang] = require("formatter.defaults.prettierd")
end

require("formatter").setup({ filetype = filetype })

-- Set up keybinds {{{
do
	local __nixvim_binds = {
		{
			action = '<cmd>Telescope function()\nbuiltin.current_buffer_fuzzy_find(\n  require("telescope.themes").get_dropdown({\n    winblend = 10,\n    previewer = false,\n  })\n)\nend\n<cr>',
			key = "<leader>/",
			mode = "n",
			options = { desc = "Fuzzily search in current buffer", expr = true },
		},
		{
			action = "<cmd>Telescope find_files<cr>",
			key = "<leader><leader>",
			mode = "n",
			options = { desc = "Search Files" },
		},
		{
			action = "<cmd>Telescope oldfiles<cr>",
			key = "<leader>s.",
			mode = "n",
			options = { desc = "Search Recent Files ('.' for repeat)" },
		},
		{
			action = '<cmd>Telescope function()\n  builtin.live_grep({\n    grep_open_files = true,\n    prompt_title = "Live Grep in Open Files",\n  })\nend\n<cr>',
			key = "<leader>s/",
			mode = "n",
			options = { desc = "Search in Open Files", expr = true },
		},
		{
			action = "<cmd>Telescope buffers<cr>",
			key = "<leader>sb",
			mode = "n",
			options = { desc = "Find existing buffers" },
		},
		{
			action = "<cmd>Telescope diagnostics<cr>",
			key = "<leader>sd",
			mode = "n",
			options = { desc = "Search Diagnostics" },
		},
		{
			action = "<cmd>Telescope live_grep<cr>",
			key = "<leader>sg",
			mode = "n",
			options = { desc = "Search by Grep" },
		},
		{ action = "<cmd>Telescope help_tags<cr>", key = "<leader>sh", mode = "n", options = { desc = "Search Help" } },
		{
			action = "<cmd>Telescope keymaps<cr>",
			key = "<leader>sk",
			mode = "n",
			options = { desc = "Search Keymaps" },
		},
		{
			action = '<cmd>Telescope function()\n  builtin.find_files({ cwd = vim.fn.stdpath("config") })\nend\n<cr>',
			key = "<leader>sn",
			mode = "n",
			options = { desc = "Search Neovim files", expr = true },
		},
		{ action = "<cmd>Telescope resume<cr>", key = "<leader>sr", mode = "n", options = { desc = "Search Resume" } },
		{
			action = "<cmd>Telescope builtin<cr>",
			key = "<leader>ss",
			mode = "n",
			options = { desc = "Search Select Telescope" },
		},
		{
			action = "<cmd>Telescope grep_string<cr>",
			key = "<leader>sw",
			mode = "n",
			options = { desc = "Search current Word" },
		},
		{
			action = "<cmd>BufferLineCycleNext<cr>",
			key = "<leader>k",
			mode = "n",
			options = { desc = "Next buffer", silent = true },
		},
		{
			action = "<cmd>BufferLineCyclePrev<cr>",
			key = "<leader>j",
			mode = "n",
			options = { desc = "Previous buffer", silent = true },
		},
		{
			action = "<cmd>BufferLineCycleNext<cr>",
			key = "<leader>k",
			mode = "n",
			options = { desc = "Next buffer", silent = true },
		},
		{
			action = "<cmd>bn|bd#<cr>",
			key = "<leader>q",
			mode = "n",
			options = { desc = "Delete buffer", silent = true },
		},
		{
			action = "<cmd>BufferLineSortByDirectory<cr>",
			key = "<leader>b",
			mode = "n",
			options = { desc = "Sort buffelinee by directory", silent = true },
		},
		{
			action = ":vs term://bash<cr>a",
			key = "<leader>l",
			mode = "n",
			options = { desc = "Open vertical terminal", silent = true },
		},
		{
			action = "<cmd>BufferLineMovePrev<cr>",
			key = "<m-h>",
			mode = "n",
			options = { desc = "Move buffer left", silent = true },
		},
		{
			action = "<cmd>BufferLineMoveNext<cr>",
			key = "<m-l>",
			mode = "n",
			options = { desc = "Move buffer right", silent = true },
		},
		{
			action = "<c-w><c-h>",
			key = "<c-h>",
			mode = "n",
			options = { desc = "Move focus to the left window", silent = true },
		},
		{
			action = "<c-w><c-l>",
			key = "<c-l>",
			mode = "n",
			options = { desc = "Move focus to the right window", silent = true },
		},
		{
			action = "<c-w><c-j>",
			key = "<c-j>",
			mode = "n",
			options = { desc = "Move focus to the lower window", silent = true },
		},
		{
			action = "<c-w><c-k>",
			key = "<c-k>",
			mode = "n",
			options = { desc = "Move focus to the upper window", silent = true },
		},
		{
			action = vim.diagnostic.open_float,
			key = "<leader>ce",
			mode = "n",
			options = { desc = "Show diagnostic [E]rror messages", silent = true },
		},
		{
			action = vim.diagnostic.open_float,
			key = "<leader>cq",
			mode = "n",
			options = { desc = "Open diagnostic [Q]uickfix list", silent = true },
		},
		{ action = "<C-\\><C-n>", key = "<esc>", mode = "t", options = { desc = "Exit terminal mode", silent = true } },
		{
			action = function()
				require("mini.files").open(vim.api.nvim_buf_get_name(0))
			end,
			key = "<c-b>",
			mode = "n",
			options = { desc = "Toggle Mini Files", noremap = true, nowait = true, silent = true },
		},
		{ action = "<cmd>Format<cr>", key = "<leader>f", mode = "n", options = { desc = "Format", silent = true } },
		{
			action = function()
				require("flash").jump()
			end,
			key = "S",
			mode = { "n" },
			options = { desc = "Flash" },
		},
		{
			action = function()
				require("flash").remote()
			end,
			key = "r",
			mode = "o",
			options = { desc = "Remote Flash" },
		},
		{
			action = function()
				require("flash").toggle()
			end,
			key = "<c-s>",
			mode = "c",
			options = { desc = "Toggle Flash Search" },
		},
	}
	for i, map in ipairs(__nixvim_binds) do
		vim.keymap.set(map.mode, map.key, map.action, map.options)
	end
end
-- }}}

-- LSP {{{
do
	local __lspCapabilities = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		return capabilities
	end

	local __setup = { capabilities = __lspCapabilities() }

	local __wrapConfig = function(cfg)
		if cfg == nil then
			cfg = __setup
		else
			cfg = vim.tbl_extend("keep", cfg, __setup)
		end
		return cfg
	end

	vim.lsp.config("astro", __wrapConfig({}))
	vim.lsp.enable("astro")
	vim.lsp.config("biome", __wrapConfig({}))
	vim.lsp.enable("biome")
	vim.lsp.config("clangd", __wrapConfig({ cmd = { "clangd", "--query-driver=c++" } }))
	vim.lsp.enable("clangd")
	vim.lsp.config("emmet_language_server", __wrapConfig({}))
	vim.lsp.enable("emmet_language_server")
	vim.lsp.config(
		"lua_ls",
		__wrapConfig({ settings = { Lua = { Lua = { diagnostic = { disable = { "missing-fields" } } } } } })
	)
	vim.lsp.enable("lua_ls")
	vim.lsp.config("pyright", __wrapConfig({ settings = { python = { analysis = { typeCheckingMode = "off" } } } }))
	vim.lsp.enable("pyright")
	vim.lsp.config("rust_analyzer", __wrapConfig({}))
	vim.lsp.enable("rust_analyzer")
	vim.lsp.config(
		"svelte",
		__wrapConfig({
			on_attach = function(client)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})
	)
	vim.lsp.enable("svelte")
	vim.lsp.config(
		"tailwindcss",
		__wrapConfig({
			settings = {
				tailwindCSS = { classAttributes = { "class", "className", "class:list", ".*ClassName.*", "tw" } },
			},
		})
	)
	vim.lsp.enable("tailwindcss")
	vim.lsp.config(
		"texlab",
		__wrapConfig({ settings = { texlab = { build = { args = { "-lualatex", "-pvc", "-synctex=1", "%f" } } } } })
	)
	vim.lsp.enable("texlab")
	vim.lsp.config("tinymist", __wrapConfig({}))
	vim.lsp.enable("tinymist")
	vim.lsp.config(
		"ts_ls",
		__wrapConfig({
			filetypes = {
				"javascript",
				"javascriptreact",
				"javascript.jsx",
				"typescript",
				"typescriptreact",
				"typescript.tsx",
			},
		})
	)
	vim.lsp.enable("ts_ls")
end
-- }}}

-- Set up autogroups {{
do
	local __nixvim_autogroups = {
		["kickstart-highlight-yank"] = { clear = true },
		nixvim_binds_LspAttach = { clear = true },
		nixvim_lsp_on_attach = { clear = false },
	}

	for group_name, options in pairs(__nixvim_autogroups) do
		vim.api.nvim_create_augroup(group_name, options)
	end
end
-- }}
-- Set up autocommands {{
do
	local __nixvim_autocommands = {
		{
			callback = function(event)
				do
					-- client and bufnr are supplied to the builtin `on_attach` callback,
					-- so make them available in scope for our global `onAttach` impl
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					local bufnr = event.buf
				end
			end,
			desc = "Run LSP onAttach",
			event = "LspAttach",
			group = "nixvim_lsp_on_attach",
		},
		{
			callback = function(args)
				do
					local __nixvim_binds = {
						{
							action = vim.diagnostic.goto_prev,
							key = "[d",
							mode = "n",
							options = { desc = "Lsp diagnostic goto_prev", silent = false },
						},
						{
							action = vim.diagnostic.goto_next,
							key = "]d",
							mode = "n",
							options = { desc = "Lsp diagnostic goto_next", silent = false },
						},
						{
							action = vim.lsp.buf.code_action,
							key = "<leader>ca",
							mode = "n",
							options = { desc = "Lsp buf code_action", silent = false },
						},
						{
							action = vim.lsp.buf.rename,
							key = "<leader>rn",
							mode = "n",
							options = { desc = "Lsp buf rename", silent = false },
						},
						{
							action = vim.lsp.buf.hover,
							key = "K",
							mode = "n",
							options = { desc = "Lsp buf hover", silent = false },
						},
						{
							action = vim.lsp.buf.declaration,
							key = "gD",
							mode = "n",
							options = { desc = "Lsp buf declaration", silent = false },
						},
						{
							action = vim.lsp.buf.definition,
							key = "gd",
							mode = "n",
							options = { desc = "Lsp buf definition", silent = false },
						},
						{
							action = vim.lsp.buf.implementation,
							key = "gi",
							mode = "n",
							options = { desc = "Lsp buf implementation", silent = false },
						},
						{
							action = vim.lsp.buf.type_definition,
							key = "go",
							mode = "n",
							options = { desc = "Lsp buf type_definition", silent = false },
						},
						{
							action = vim.lsp.buf.references,
							key = "gr",
							mode = "n",
							options = { desc = "Lsp buf references", silent = false },
						},
						{ action = "<cmd>LspRestart<cr>", key = "<m-l>", mode = "" },
						{ action = vim.lsp.buf.signature_help, key = "<c-h>", mode = { "i", "s" } },
					}

					for i, map in ipairs(__nixvim_binds) do
						local options = vim.tbl_extend("keep", map.options or {}, { buffer = args.buf })
						vim.keymap.set(map.mode, map.key, map.action, options)
					end
				end
			end,
			desc = "Load keymaps for LspAttach",
			event = "LspAttach",
			group = "nixvim_binds_LspAttach",
		},
		{ command = "set guicursor=a:ver25-blinkon2", event = { "VimLeave" } },
		{
			callback = function()
				vim.highlight.on_yank()
			end,
			desc = "Highlight when yanking (copying) text",
			event = { "TextYankPost" },
			group = "kickstart-highlight-yank",
		},
	}

	for _, autocmd in ipairs(__nixvim_autocommands) do
		vim.api.nvim_create_autocmd(autocmd.event, {
			group = autocmd.group,
			pattern = autocmd.pattern,
			buffer = autocmd.buffer,
			desc = autocmd.desc,
			callback = autocmd.callback,
			command = autocmd.command,
			once = autocmd.once,
			nested = autocmd.nested,
		})
	end
end
-- }}
