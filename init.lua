------------------------------basic config------------------------------
----------------------------------------
-- key mapping
local key_map_opt = {noremap = true, silent = true}

----------------------------------------
-- insert mode key mapping
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', key_map_opt)

----------------------------------------
-- normal mode key mapping

-- basic key mapping
vim.api.nvim_set_keymap('n', 'W', ':w<CR>', key_map_opt)
vim.api.nvim_set_keymap('n', 'Q', ':q<CR>', key_map_opt)

-- split screen processing
vim.api.nvim_set_keymap('n', 'sd', ':vsplit<CR><C-w>l', key_map_opt)
vim.api.nvim_set_keymap('n', 'sa', ':vsplit<CR><C-w>h', key_map_opt)
vim.api.nvim_set_keymap('n', 'ss', ':split<CR><C-w>j', key_map_opt)
vim.api.nvim_set_keymap('n', 'sw', ':split<CR><C-w>k', key_map_opt)

-- change the size of screen
vim.api.nvim_set_keymap('', '<Left>', ':vertical resize-2<CR>', key_map_opt)
vim.api.nvim_set_keymap('', '<Right>', ':vertical resize+2<CR>', key_map_opt)
vim.api.nvim_set_keymap('', '<Up>', ':res +2<CR>', key_map_opt)
vim.api.nvim_set_keymap('', '<Down>', ':res -2<CR>', key_map_opt)


-- config relative number
vim.o.number = true 			
vim.o.relativenumber = true

-- config system clipboard
vim.o.clipboard = "unnamed" 	

------------------------------command------------------------------
-- auto command

-- text is highlighted after being copied
vim.api.nvim_create_autocmd({"TextYankPost"}, {
	pattern = {"*"}, 				-- match all models
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,			-- the highlight time (300ms)
		})
	end,
})


