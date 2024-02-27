------------------------------basic config------------------------------
----------------------------------------
-- key mapping
local key_map_opt = {noremap = true, silent = true}
vim.g.mapleader = " " 					-- configure the space bar as the leader button	

-- insert mode key mapping
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', key_map_opt)
vim.api.nvim_set_keymap('n', 'j', [[v:count ? 'j' : 'gj']], {noremap = true, expr = true})
vim.api.nvim_set_keymap('n', 'k', [[v:count ? 'k' : 'gk']], {noremap = true, expr = true})

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


-- config relative number
vim.o.number = true 			
vim.o.relativenumber = true

-- about font
vim.o.cursorline = true
vim.o.guifont = "RobotoMono:16"

-- config system clipboard
vim.o.clipboard = "unnamed" 	

------------------------------command------------------------------
-- auto command

-- text is highlighted after being copied
vim.api.nvim_create_autocmd({"TextYankPost"}, {
	pattern = {"*"}, 					-- match all models
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,				-- the highlight time (300ms)
		})
	end,
})


------------------------------plugins------------------------------
-- plugins list
plugins = { 
	"ajmwagar/vim-deus" 			 		-- color theme
}

----------------------------------------
-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" 	-- set the path of lazy.nvim
if not vim.loop.fs_stat(lazypath) then 				-- download the file of the lazy.nvim
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })

end
vim.opt.rtp:prepend(lazypath) 					-- add lazy.nvim's path to tht runtim path
require("lazy").setup(plugins, opts) 				-- load lazy.nvim


------------------------------plugins' configration------------------------------
-- config color scheme
vim.cmd.colorscheme("deus")

