------------------------------basic config------------------------------
----------------------------------------
-- key mapping
local key_map_opt = { noremap = true, silent = true }
vim.g.mapleader = " " -- configure the space bar as the leader button	


-- insert mode key mapping
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', key_map_opt)
vim.api.nvim_set_keymap('n', 'j', [[v:count ? 'j' : 'gj']], { noremap = true, expr = true })
vim.api.nvim_set_keymap('n', 'k', [[v:count ? 'k' : 'gk']], { noremap = true, expr = true })

-- normal mode key mapping

-- basic key mapping
vim.api.nvim_set_keymap('n', 'W', ':w<CR>', key_map_opt)
vim.api.nvim_set_keymap('n', 'Q', ':q<CR>', key_map_opt)


----------------------------------------
-- about screen
-- split screen processing
vim.api.nvim_set_keymap('n', '<leader>l', ':vsplit<CR><C-w>l', key_map_opt)
vim.api.nvim_set_keymap('n', '<leader>h', ':vsplit<CR><C-w>h', key_map_opt)
vim.api.nvim_set_keymap('n', '<leader>j', ':split<CR><C-w>j', key_map_opt)
vim.api.nvim_set_keymap('n', '<leader>k', ':split<CR><C-w>k', key_map_opt)

-- change the size of screen
vim.api.nvim_set_keymap('', '<Left>', ':vertical resize-2<CR>', key_map_opt)
vim.api.nvim_set_keymap('', '<Right>', ':vertical resize+2<CR>', key_map_opt)
vim.api.nvim_set_keymap('', '<Up>', ':res +2<CR>', key_map_opt)
vim.api.nvim_set_keymap('', '<Down>', ':res -2<CR>', key_map_opt)

-- about tag
vim.api.nvim_set_keymap('n', '<leader>[', '<C-o>', key_map_opt)
vim.api.nvim_set_keymap('n', '<leader>]', '<C-i>', key_map_opt)


-- config relative number
vim.o.number = true
vim.o.relativenumber = true

-- about font
vim.o.cursorline = true
vim.o.guifont = "RobotoMono:16"
vim.o.tabstop = 4

-- config system clipboard
vim.o.clipboard = "unnamed"

------------------------------command------------------------------
-- auto command

-- text is highlighted after being copied
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" }, -- match all models
	callback = function()
		vim.highlight.on_yank({
			timeout = 300, -- the highlight time (300ms)
		})
	end,
})


------------------------------plugins------------------------------
-- plugins list
plugins = {
	{
		"ajmwagar/vim-deus", -- color theme
	},

	{
		"folke/persistence.nvim", -- record the nvim status
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
	},

	-- about fuzzy file find
	{
		cmd = "Telescope", -- telescope
		keys = { -- key map
			{ "<leader>p",  ":Telescope find_files<CR>", desc = "find files" },
			{ "<leader>P",  ":Telescope live_grep<CR>",  desc = "grep file" },
			{ "<leader>rs", ":Telescope resume<CR>",     desc = "resume" },
			{ "<leader>o",  ":Telescope oldfiles<CR>",   desc = "oldfiles" },
		},
		'nvim-telescope/telescope.nvim',
		tag = '0.1.5',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},


	-- about lsp
	{
		event = "VeryLazy",
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end
	},

	{
		event = "VeryLazy",
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" }
	},

	-- code completion
	{
		event = "VeryLazy",
		"hrsh7th/nvim-cmp",
		dependencies = {
			'neovim/nvim-lspconfig',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/nvim-cmp',
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',
		}
	},

	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp"
	},

	{
		event = "VeryLazy",
		"folke/neodev.nvim",
		opts = {}
	},

	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	}


}

opts = {
	root = vim.fn.stdpath("config") .. "/lazy",
}
----------------------------------------
-- lazy.nvim
local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim" -- set the path of lazy.nvim
if not vim.loop.fs_stat(lazypath) then                         -- download the file of the lazy.nvim
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)        -- add lazy.nvim's path to tht runtim path
require("lazy").setup(plugins, opts) -- load lazy.nvim


------------------------------plugins' configration------------------------------
-- config color scheme
vim.cmd.colorscheme("deus")


------------------------------lsp configration------------------------------
----------------------------------------
--mason config
local mason_opts = {
	-- config the dir in which to install packages
	-- install_root_dir = path.concat { vim.fn.stdpath "config", "mason"},
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	},

}

----------------------------------------
--mason-lspconfig settings
local mason_lspconfig_opts = {
	-- install the lsp servcer
	ensure_installed = {
		"lua_ls",
		"clangd",
	},
}

----------------------------------------
-- lspconfig
local lspconfig = require('lspconfig')

-- lspconfig keymap
-- Global mappings
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

require("mason").setup(mason_opts)
require("mason-lspconfig").setup(mason_lspconfig_opts)


-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- load lua_ls
lspconfig['lua_ls'].setup {
	capabilities = capabilities
}


------------------------------code completion------------------------------
-- Set up nvim-cmp.
local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp = require 'cmp'
local luasnip = require("luasnip")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},

	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
				-- that way you will only jump inside the snippet region
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),

	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'vsnip' }, -- For vsnip users.
		{ name = 'luasnip' }, -- For luasnip users.
		-- { name = 'ultisnips' }, -- For ultisnips users.
		-- { name = 'snippy' }, -- For snippy users.
	}, {
		{ name = 'buffer' },
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
	}, {
		{ name = 'buffer' },
	})
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})


-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

------------------------------autopairs------------------------------
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

----------------------------------------neodev------------------------------
require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
})

